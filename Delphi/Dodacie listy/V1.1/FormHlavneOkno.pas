unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ClassFaktury, StdCtrls, Grids, Typy, Db,
  DBTables;

type
  THlavneOkno = class(TForm)
    MainMenu: TMainMenu;
    MainProgram: TMenuItem;
    ProgramTlacit: TMenuItem;
    ProgramKoniec: TMenuItem;
    MainDodacieListy: TMenuItem;
    DodacieOtvorit: TMenuItem;
    DodacieUlozit: TMenuItem;
    DodacieUlozitAko: TMenuItem;
    StatusBar: TStatusBar;
    GroupBoxDodavatel: TGroupBox;
    Label1: TLabel;
    MemoDodavatel: TMemo;
    Label2: TLabel;
    EditDodavatel: TEdit;
    GroupBoxOdberatel: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    MemoOdberatel: TMemo;
    EditOdberatel: TEdit;
    CisloDodacieho: TLabel;
    DodacieNovy: TMenuItem;
    GroupBoxPolozky: TGroupBox;
    StringGridSpodok: TStringGrid;
    PrintDialog: TPrintDialog;
    ListView: TListView;
    Memo: TMemo;
    Label5: TLabel;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    Spolontext1: TMenuItem;
    Label6: TLabel;
    EditZaruka: TEdit;
    procedure ProgramKoniecClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DodacieNovyClick(Sender: TObject);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure MemoExit(Sender: TObject);
    procedure MemoDodavatelChange(Sender: TObject);
    procedure EditDodavatelChange(Sender: TObject);
    procedure MemoOdberatelChange(Sender: TObject);
    procedure EditOdberatelChange(Sender: TObject);
    procedure MemoChange(Sender: TObject);
    procedure StringGridSpodokSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: String);
    procedure DodacieUlozitClick(Sender: TObject);
    procedure DodacieUlozitAkoClick(Sender: TObject);
    procedure DodacieOtvoritClick(Sender: TObject);
    procedure ProgramTlacitClick(Sender: TObject);
    procedure Spolontext1Click(Sender: TObject);
    procedure EditZarukaChange(Sender: TObject);
    procedure EditZarukaExit(Sender: TObject);
  protected
    { Protected declarations }

  private
    { Private declarations }
    CestaSave : string;
    PlatneUdaje : boolean;

    procedure Inicializacia;

    procedure UrobZmenu;

    procedure NahadzDataDoFormu;
    procedure NahadzVyrobneDoMema;
    procedure NahadzDodaciDoSuboru;

    procedure NacitajDataZFormu;
    procedure NacitajDataZoSuboru;

    function FakturaToDodaci( iCislo : integer ) : TDodaci;

    procedure UvolniPamat;
  public
    { Public declarations }
    SpolocnyText : TStringList;

    CestaDef : string;
    Aktivny : TAktivny;
    Dodaci : TDodaci;

    Vybrana : integer; {index vybranej polozky - jej vyrobne cisla su vypisane}
  end;

var
  HlavneOkno: THlavneOkno;

implementation

uses ClassTlac, DialogDodaciKFakture, FormText;

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                  Constrcutor
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.Inicializacia;
var Sirka : integer;
    I : integer;
    F : TextFile;
begin
  StatusBar.Panels[0].Text := '';
  CisloDodacieho.Caption := '';

  //String grid spodok
  Sirka := (StringGridSpodok.Width div StringGridSpodok.ColCount) - 2;
  for I := 0 to StringGridSpodok.ColCount-1 do
    StringGridSpodok.ColWidths[I] := Sirka;
  with StringGridSpodok do
    begin
      Rows[0].Strings[0] := '⁄kon';
      Rows[0].Strings[1] := 'Vystavil';
      Rows[0].Strings[2] := 'Schv·lil';
      Rows[0].Strings[3] := 'Prijal';
      Cols[0].Strings[1] := 'D·tum';
      Cols[0].Strings[2] := 'Podpis';

      Rows[1].Strings[1] := DateToStr( Now );
      Rows[1].Strings[2] := DateToStr( Now );
      Rows[1].Strings[3] := DateToStr( Now );
    end;

  Dodaci.Cislo := '';
  Dodaci.Faktura := nil;

  Vybrana := -1;

  Aktivny.Subor := '';
  Aktivny.Ulozeny := True;

  PlatneUdaje := False;

  GetDir( 0 , CestaDef );
  AssignFile( F , CestaDef+'\cesta.txt' );
  {$I-}
  Reset( F );
  {$I+}
  if IOResult <> 0 then CestaSave := CestaDef
                   else
                     begin
                       Readln( F , CestaSave );
                       CloseFile( F );
                     end;
end;

procedure THlavneOkno.FormCreate(Sender: TObject);
begin
  Inicializacia;

  SpolocnyText := TStringList.Create;
  Tlac := TTlac.Create;
  Faktury := TFaktury.Create;
end;

//==============================================================================
//==============================================================================
//
//                                  Destructor
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.FormClose(Sender: TObject; var Action: TCloseAction);
var I : integer;
    F : TextFile;
begin
  if not Aktivny.Ulozeny then
    if MessageDlg( 'DodacÌ list nie je uloûen˝! Naozaj chcete skonËiù?' , mtWarning , [mbYES , mbNO] , 0 ) <> mrYES then
      begin
        Action := caNone;
        exit;
      end;

  if Dodaci.Otvoreny then
    begin
      TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa.Free;
      TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa.Free;
      for I := 0 to TFaktura( Dodaci.Faktura^ ).Polozky.Count-1 do
        begin
          TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Vyrobne.Free;
          Dispose( PPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I] ) );
        end;
      TFaktura( Dodaci.Faktura^ ).Polozky.Free;
      Dispose( PFaktura( Dodaci.Faktura ) );
    end;

  AssignFile( F , CestaDef+'\cesta.txt' );
  {$I-}
  Rewrite( F );
  {$I+}
  if IOResult <> 0 then
    begin
      MessageDlg( 'Nemoûno vytvoriù s˙bor ''cesta.txt''', mtError , [mbOk] , 0 );
      exit;
    end;

  while CestaSave[Length(CestaSave)] <> '\' do
    Delete( CestaSave , Length(CestaSave) , 1 );

  Writeln( F , CestaSave );

  CloseFile( F );

  Tlac.Free;
  Faktury.Free;
  SpolocnyText.Free;
end;


//==============================================================================
//==============================================================================
//
//                                  Main menu
//
//==============================================================================
//==============================================================================


procedure THlavneOkno.ProgramKoniecClick(Sender: TObject);
begin
  Close;
end;

procedure THlavneOkno.DodacieNovyClick(Sender: TObject);
var CisloFaktury : integer;
begin
  if not Aktivny.Ulozeny then
    if MessageDlg( 'DodacÌ list nie je uloûen˝! Chcete pokraûovaù?' , mtWarning , [mbYES , mbNO] , 0 ) <> mrYES then exit;
  CisloFaktury := DodaciKFakture.ShowModal-1;
  if CisloFaktury > -1 then
    begin
      if Dodaci.Otvoreny then UvolniPamat;

      Dodaci.Otvoreny := False;

      Aktivny.Subor := '';
      UrobZmenu;

      Dodaci := FakturaToDodaci( CisloFaktury );

      NahadzDataDoFormu;

      DodacieUlozit.Enabled := True;
      DodacieUlozitAko.Enabled := True;
      ProgramTlacit.Enabled := True;

      PlatneUdaje := True;
    end;
end;

procedure THlavneOkno.DodacieUlozitClick(Sender: TObject);
begin
  if Aktivny.Subor = '' then DodacieUlozitAkoClick(Sender)
    else
      begin
        DodacieUlozit.Enabled := False;

        if ActiveControl = Memo then MemoExit(nil);

        StatusBar.Panels[0].Text := '';
        Aktivny.Ulozeny := True;

        NacitajDataZFormu;
        NahadzDodaciDoSuboru;
      end;
end;

procedure THlavneOkno.DodacieUlozitAkoClick(Sender: TObject);
begin
  SaveDialog.FileName := Dodaci.Cislo;
  SaveDialog.InitialDir := CestaSave;
  if SaveDialog.Execute then
    begin
      DodacieUlozit.Enabled := False;

      Aktivny.Subor := SaveDialog.FileName;
      CestaSave := Aktivny.Subor;

      if ActiveControl = Memo then MemoExit(nil);

      Aktivny.Ulozeny := True;
      StatusBar.Panels[0].Text := '';

      NacitajDataZFormu;
      NahadzDodaciDoSuboru;
    end;
end;

procedure THlavneOkno.DodacieOtvoritClick(Sender: TObject);
begin
  if not Aktivny.Ulozeny then
    if MessageDlg( 'DodacÌ list nie je uloûen˝! Chcete pokraûovaù?' , mtWarning , [mbYES , mbNO] , 0 ) <> mrYES then exit;
  OpenDialog.InitialDir := CestaSave;

  if OpenDialog.Execute then
    begin
      Aktivny.Subor := OpenDialog.FileName;
      CestaSave := Aktivny.Subor;

      //Alokuje pamat pre fakturu k dodaciemu listu :
      if Dodaci.Otvoreny then UvolniPamat;

      Dodaci.Otvoreny := True;
      New( Dodaci.Faktura );
      TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa := TStringList.Create;
      TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa := TStringList.Create;
      TFaktura( Dodaci.Faktura^ ).Polozky := TList.Create;

      NacitajDataZoSuboru;
      NahadzDataDoFormu;

      StatusBar.Panels[0].Text := '';

      DodacieUlozit.Enabled := False;
      DodacieUlozitAko.Enabled := True;
      ProgramTlacit.Enabled := True;

      PlatneUdaje := True;

      Aktivny.Ulozeny := True;
    end;
end;

procedure THlavneOkno.Spolontext1Click(Sender: TObject);
begin
  DialogSpolocnyText.Show;
end;

//==============================================================================
//==============================================================================
//
//                                  Praca s datami
//
//==============================================================================
//==============================================================================

function THlavneOkno.FakturaToDodaci( iCislo : integer ) : TDodaci;
begin
  Result.Faktura := PFaktura( Faktury.Zoznam[ iCislo ] );
  Result.Cislo := 'D' + Copy( TFaktura( Faktury.Zoznam[ iCislo ]^ ).Cislo , 2 , 20 );
end;

procedure THlavneOkno.NahadzDataDoFormu;
var I : integer;
    NewItem : TListItem;
begin
  Vybrana := -1;

  //Cislo :
  CisloDodacieho.Caption := Dodaci.Cislo;

  //Dodavatel :
  MemoDodavatel.Clear;
  MemoDodavatel.Lines.Assign( TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa );
  EditDodavatel.Text := TFaktura( Dodaci.Faktura^ ).Dodavatel.ICO;

  //Odberatel :
  MemoOdberatel.Clear;
  MemoOdberatel.Lines.Assign( TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa );
  EditOdberatel.Text := TFaktura( Dodaci.Faktura^ ).Odberatel.ICO;

  //Polozky :
  ListView.Items.Clear;
  for I := 0 to TFaktura( Dodaci.Faktura^ ).Polozky.Count-1 do
    begin
      NewItem := ListView.Items.Add;

      NewItem.Caption := TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Text;
      NewItem.SubItems.Add( TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).J );
      NewItem.SubItems.Add( TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Mnozstvo );
    end;

  //Seriove cisla :
  Memo.Clear;

  //Tabulka :
  if Dodaci.Vystavil.Datum <> '' then StringGridSpodok.Cells[ 1 , 1 ] := Dodaci.Vystavil.Datum
                                 else StringGridSpodok.Cells[ 1 , 1 ] := DateToStr( Now );
  StringGridSpodok.Cells[ 1 , 2 ] := Dodaci.Vystavil.Osoba;

  if Dodaci.Schvalil.Datum <> '' then StringGridSpodok.Cells[ 2 , 1 ] := Dodaci.Schvalil.Datum
                                 else StringGridSpodok.Cells[ 2 , 1 ] := DateToStr( Now );
  StringGridSpodok.Cells[ 2 , 2 ] := Dodaci.Schvalil.Osoba;

  if Dodaci.Prijal.Datum <> '' then StringGridSpodok.Cells[ 3 , 1 ] := Dodaci.Prijal.Datum
                               else StringGridSpodok.Cells[ 3 , 1 ] := DatetoStr( Now );
                               
  StringGridSpodok.Cells[ 3 , 2 ] := Dodaci.Prijal.Osoba;
end;

procedure THlavneOkno.NahadzVyrobneDoMema;
begin
  Memo.Clear;
  Memo.Lines.Assign( TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[ Vybrana ]^ ).Vyrobne );
end;

procedure THlavneOkno.NahadzDodaciDoSuboru;
var F : TextFile;
    I, J : integer;
begin
  AssignFile( F , Aktivny.Subor );
  Rewrite( F );

  //Cislo :
  Writeln( F , Dodaci.Cislo );

  //Dodavatel :
  Writeln( F , IntToStr( TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa.Count ) );
  for I := 0 to TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa.Count-1 do
    Writeln( F , TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa[I] );
  Writeln( F , TFaktura( Dodaci.Faktura^ ).Dodavatel.ICO );

  //Odberatel :
  Writeln( F , IntToStr( TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa.Count ) );
  for I := 0 to TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa.Count-1 do
    Writeln( F , TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa[I] );
  Writeln( F , TFaktura( Dodaci.Faktura^ ).Odberatel.ICO );

  //Polozky :
  Writeln( F , IntToStr( TFaktura( Dodaci.Faktura^ ).Polozky.Count ) );
  for I := 0 to TFaktura( Dodaci.Faktura^ ).Polozky.Count-1 do
    begin
      Writeln( F , TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Text );
      Writeln( F , TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).J );
      Writeln( F , TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Mnozstvo );
      Writeln( F , TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Zaruka );
    end;

  //Seriove cisla :
  for I := 0 to TFaktura( Dodaci.Faktura^ ).Polozky.Count-1 do
    begin
      Writeln( F , IntToStr( TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Vyrobne.Count ) );
      for J := 0 to TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Vyrobne.Count-1 do
        Writeln( F , TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Vyrobne[J] );        
    end;

  //Tabulka :
  Writeln( F , Dodaci.Vystavil.Datum );
  Writeln( F , Dodaci.Vystavil.Osoba );

  Writeln( F , Dodaci.Schvalil.Datum );
  Writeln( F , Dodaci.Schvalil.Osoba );

  Writeln( F , Dodaci.Prijal.Datum );
  Writeln( F , Dodaci.Prijal.Osoba );

  CloseFile( F );
end;

procedure THlavneOkno.NacitajDataZFormu;
begin
  if not PlatneUdaje then exit;

  //Dodavatel :
  TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa.Assign( MemoDodavatel.Lines );
  TFaktura( Dodaci.Faktura^ ).Dodavatel.ICO := EditDodavatel.Text;

  //Odberatel :
  TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa.Assign( MemoOdberatel.Lines );
  TFaktura( Dodaci.Faktura^ ).Odberatel.ICO := EditOdberatel.Text;

  //Tabulka :
  Dodaci.Vystavil.Datum := StringGridSpodok.Cells[ 1 , 1 ];  
  Dodaci.Vystavil.Osoba := StringGridSpodok.Cells[ 1 , 2 ];

  Dodaci.Schvalil.Datum := StringGridSpodok.Cells[ 2 , 1 ];
  Dodaci.Schvalil.Osoba := StringGridSpodok.Cells[ 2 , 2 ];

  Dodaci.Prijal.Datum := StringGridSpodok.Cells[ 3 , 1 ];
  Dodaci.Prijal.Osoba := StringGridSpodok.Cells[ 3 , 2 ];
end;

procedure THlavneOkno.NacitajDataZoSuboru;
var F : TextFile;
    I, J, Cislo : integer;
    S : string;
    PNewPolozka : PPolozka;
begin
  AssignFile( F , Aktivny.Subor );
  Reset( F );

  //Cislo :
  Readln( F , Dodaci.Cislo );
  TFaktura( Dodaci.Faktura^ ).Cislo := Dodaci.Cislo;
  Delete( TFaktura( Dodaci.Faktura^ ).Cislo , 1 , 1 );
  TFaktura( Dodaci.Faktura^ ).Cislo := 'F' + TFaktura( Dodaci.Faktura^ ).Cislo;

  //Dodavatel :
  Readln( F , Cislo );
  for I := 1 to Cislo do
    begin
      Readln( F , s );
      TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa.Add( s );
    end;
  Readln( F , TFaktura( Dodaci.Faktura^ ).Dodavatel.ICO );

  //Odberatel :
  Readln( F , Cislo );
  for I := 1 to Cislo do
    begin
      Readln( F , s  );
      TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa.Add( s );
    end;
  Readln( F , TFaktura( Dodaci.Faktura^ ).Odberatel.ICO );

  //Polozky :
  Readln( F , Cislo );
  for I := 0 to Cislo-1 do
    begin
      New( PNewPolozka );
      TFaktura( Dodaci.Faktura^ ).Polozky.Add( PNewPolozka );

      Readln( F , TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Text );
      Readln( F , TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).J );
      Readln( F , TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Mnozstvo );
      Readln( F , TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Zaruka );

      TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Vyrobne := TStringList.Create;
    end;

  //Seriove cisla :
  for I := 0 to TFaktura( Dodaci.Faktura^ ).Polozky.Count-1 do
    begin
      Readln( F , Cislo );
      if Cislo > 0 then
        TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Vyrobne := TStringList.Create;
      for J := 1 to Cislo do
        begin
          Readln( F , s );
          TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Vyrobne.Add( s );
        end;
    end;

  //Tabulka :
  Readln( F , Dodaci.Vystavil.Datum );
  Readln( F , Dodaci.Vystavil.Osoba );

  Readln( F , Dodaci.Schvalil.Datum );
  Readln( F , Dodaci.Schvalil.Osoba );

  Readln( F , Dodaci.Prijal.Datum );
  Readln( F , Dodaci.Prijal.Osoba );

  CloseFile( F );
end;

//==============================================================================
//==============================================================================
//
//                               Praca s komponentami
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.ListViewSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if (not Selected) or
     (Item.Index = Vybrana) then exit;

  Vybrana := Item.Index;
  NahadzVyrobneDoMema;
  EditZaruka.Text := TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[ Vybrana ]^ ).Zaruka;
end;

procedure THlavneOkno.MemoExit(Sender: TObject);
var I : integer;
begin
  if Vybrana = -1 then exit;
  I := 0;
  repeat
    if Memo.Lines[I] = '' then Memo.Lines.Delete( I )
                          else Inc( I );
  until I > Memo.Lines.Count-1;
  TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[ Vybrana ]^ ).Vyrobne.Clear;
  TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[ Vybrana ]^ ).Vyrobne.Assign( Memo.Lines );
end;

procedure THlavneOkno.EditZarukaExit(Sender: TObject);
begin
  if Vybrana = -1 then exit;

  try
    StrToInt( EditZaruka.Text );
  except
    on EConvertError do
      begin
        MessageDlg( 'Hodnota z·ruky nie je celÈ ËÌslo.' , mtError , [mbOK] , 0 );
        EditZaruka.SelectAll;
        exit;
      end;
  end;

  if Length( EditZaruka.Text ) > 2 then
    begin
      MessageDlg( 'Hodnota z·ruky nie je dvojcifernÈ ËÌslo.' , mtError , [mbOK] , 0 );
      EditZaruka.SelectAll;
      exit;
    end;

  TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[ Vybrana ]^ ).Zaruka := EditZaruka.Text;
end;

//==============================================================================
//==============================================================================
//
//                                  Zmena udajov
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.UrobZmenu;
begin
  StatusBar.Panels[0].Text := 'NEULOéEN…';
  Aktivny.Ulozeny := False;
  DodacieUlozit.Enabled := True;
end;

procedure THlavneOkno.MemoDodavatelChange(Sender: TObject);
begin
  UrobZmenu
end;

procedure THlavneOkno.EditDodavatelChange(Sender: TObject);
begin
  UrobZmenu
end;

procedure THlavneOkno.MemoOdberatelChange(Sender: TObject);
begin
  UrobZmenu
end;

procedure THlavneOkno.EditOdberatelChange(Sender: TObject);
begin
  UrobZmenu
end;

procedure THlavneOkno.MemoChange(Sender: TObject);
begin
  UrobZmenu
end;

procedure THlavneOkno.StringGridSpodokSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  UrobZmenu
end;

procedure THlavneOkno.EditZarukaChange(Sender: TObject);
begin
  UrobZmenu
end;

//==============================================================================
//==============================================================================
//
//                                  Ostatne
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.UvolniPamat;
var I : integer;
begin
  TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa.Free;
  TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa.Free;
  for I := 0 to TFaktura( Dodaci.Faktura^ ).Polozky.Count-1 do
    begin
      TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Vyrobne.Free;
      Dispose( PPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I] ) );
    end;
  TFaktura( Dodaci.Faktura^ ).Polozky.Free;
end;

//==============================================================================
//==============================================================================
//
//                                  TlaË
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.ProgramTlacitClick(Sender: TObject);
begin
  if not PlatneUdaje then exit;
  if PrintDialog.Execute then
    begin
      NacitajDataZFormu;
      Tlac.Vytlac( @Dodaci );
    end;
end;

end.
