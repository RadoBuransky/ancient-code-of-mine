unit FormHlavneOkno;

interface

uses
  Windows, Messages, Classes, SysUtils, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ClassFaktury, StdCtrls, Grids, Typy, ToolWin, ImgList,
  ExtCtrls;

type
  THlavneOkno = class(TForm)
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    DodacieTlacit: TMenuItem;
    ProgramKoniec: TMenuItem;
    MainDodacieListy: TMenuItem;
    DodacieNovy: TMenuItem;
    DodacieOtvorit: TMenuItem;
    DodacieUlozit: TMenuItem;
    DodacieUlozitAko: TMenuItem;
    PrintDialog: TPrintDialog;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    MainKomponenty: TMenuItem;
    NovaPon: TMenuItem;
    OtvoritPon: TMenuItem;
    UlozitPon: TMenuItem;
    UlozitAkoPon: TMenuItem;
    StringGridPon: TStringGrid;
    PopupMenuPon: TPopupMenu;
    Ulozit: TMenuItem;
    OtvoritSablonu: TMenuItem;
    Vloiriadok1: TMenuItem;
    Zmazariadok1: TMenuItem;
    Label7: TLabel;
    EditKoef: TEdit;
    Label8: TLabel;
    EditDPH: TEdit;
    ButtonAkt: TButton;
    EditBezDPH: TEdit;
    EditSDPH: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    MemoAdr: TMemo;
    Label11: TLabel;
    ButtonPrev: TButton;
    ButtonNext: TButton;
    ComboBoxA: TComboBox;
    Label12: TLabel;
    EditDatum: TEdit;
    TlacitPon: TMenuItem;
    Program1: TMenuItem;
    Moznosti: TMenuItem;
    ToolBar: TToolBar;
    ToolButtonNew: TToolButton;
    ImageList: TImageList;
    ToolButtonOpen: TToolButton;
    ToolButtonPrint: TToolButton;
    ToolButtonSave: TToolButton;
    ToolBarDod: TToolBar;
    ToolButtonNewDod: TToolButton;
    ToolButtonOpenDod: TToolButton;
    ToolButtonPrnDod: TToolButton;
    ToolButtonSaveDod: TToolButton;
    CisloDodacieho: TLabel;
    Notebook: TNotebook;
    GroupBoxDodavatel: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MemoDodavatel: TMemo;
    EditDodavatel: TEdit;
    GroupBoxOdberatel: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    MemoOdberatel: TMemo;
    EditOdberatel: TEdit;
    GroupBoxPolozky: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    ListView: TListView;
    Memo: TMemo;
    EditZaruka: TEdit;
    StringGridSpodok: TStringGrid;
    GroupBox2: TGroupBox;
    Label15: TLabel;
    MemoAdr2: TMemo;
    Label13: TLabel;
    EditDatumDod: TEdit;
    StringGridPol: TStringGrid;
    MainManager: TMenuItem;
    PonukaExport: TMenuItem;
    ToolButtonExport: TToolButton;
    ComboBoxAD: TComboBox;
    PopupMenuPol: TPopupMenu;
    Vloiriadok2: TMenuItem;
    Zmazariadok2: TMenuItem;
    Uloiablnu1: TMenuItem;
    Otvoriablnu1: TMenuItem;
    Zkazkovlist1: TMenuItem;
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
    procedure DodacieTlacitClick(Sender: TObject);
    procedure EditZarukaChange(Sender: TObject);
    procedure EditZarukaExit(Sender: TObject);
    procedure MainDodacieListyClick(Sender: TObject);
    procedure UlozitClick(Sender: TObject);
    procedure StringGridPonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Vloiriadok1Click(Sender: TObject);
    procedure Zmazariadok1Click(Sender: TObject);
    procedure StringGridPonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MainKomponentyClick(Sender: TObject);
    procedure ButtonAktClick(Sender: TObject);
    procedure ButtonNextClick(Sender: TObject);
    procedure ButtonPrevClick(Sender: TObject);
    procedure ComboBoxAChange(Sender: TObject);
    procedure OtvoritSablonuClick(Sender: TObject);
    procedure EditKoefExit(Sender: TObject);
    procedure EditDPHExit(Sender: TObject);
    procedure UlozitPonClick(Sender: TObject);
    procedure UlozitAkoPonClick(Sender: TObject);
    procedure NovaPonClick(Sender: TObject);
    procedure OtvoritPonClick(Sender: TObject);
    procedure MoznostiClick(Sender: TObject);
    procedure TlacitPonClick(Sender: TObject);
    procedure ToolButtonNewClick(Sender: TObject);
    procedure ToolButtonOpenClick(Sender: TObject);
    procedure ToolButtonSaveClick(Sender: TObject);
    procedure ToolButtonPrintClick(Sender: TObject);
    procedure StringGridPolKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemoAdr2Enter(Sender: TObject);
    procedure EditDatumDodEnter(Sender: TObject);
    procedure StringGridPolGetEditText(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure MainManagerClick(Sender: TObject);
    procedure PonukaExportClick(Sender: TObject);
    procedure ToolButtonExportClick(Sender: TObject);
    procedure ComboBoxADChange(Sender: TObject);
    procedure Vloiriadok2Click(Sender: TObject);
    procedure Zmazariadok2Click(Sender: TObject);
    procedure Uloiablnu1Click(Sender: TObject);
    procedure Otvoriablnu1Click(Sender: TObject);
    procedure Zkazkovlist1Click(Sender: TObject);
  protected
    { Protected declarations }

  private
    { Private declarations }
    Adr2Active : integer;
    PlatneUdaje : boolean;
    OtvPonuka : string;

    procedure RegIni;
    procedure Inicializacia;

    procedure UrobZmenu;

    procedure NahadzDataDoFormu;
    procedure NahadzVyrobneDoMema;
    procedure NahadzDodaciDoSuboru;

    procedure NacitajDataZFormu;
    procedure NacitajDataZoSuboru;

    function FakturaToDodaci( iCislo : integer ) : TDodaci;

    procedure UvolniPamat;

    //M A N A G E R
    procedure OtvorPonuku( FileName : string );
    procedure OtvorDodPon( FileName : string );
    procedure OtvorDod( FileName : string );

    //P O N U K A
    procedure NacitajSablonu( Cesta : string; StringGrid : TStringGrid);
    procedure UlozSablonu( Cesta : string; StringGrid : TStringGrid );
  public
    { Public declarations }
    CestaDef : string;
    Aktivny : TAktivny;
    Dodaci : TDodaci;

    Vybrana : integer; {index vybranej polozky - jej vyrobne cisla su vypisane}
  end;

var
  HlavneOkno: THlavneOkno;

implementation

uses ClassTlacDod, DialogDodaciKFakture, ClassPonuka, ClassAdresy,
     Clipbrd, Ini, FormOtvorPon, FormMoznosti, ClassDodPon, Generuj,
	 Registry, FormChooseAdr, FormMan, FormZakList;

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                  Constructor
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.RegIni;
var I : integer;
    Regs : TRegistry;
begin
  //  Registers
  Regs := TRegistry.Create;
  try
    Regs.RootKey := HKEY_LOCAL_MACHINE;
    Regs.OpenKey( '\Software\Dodacie' , False );

    exe_dir := Regs.ReadString( 'exe_dir' );

    if Regs.ReadString( 'FirstTime' ) = 'TRUE' then
      begin
        Regs.WriteString( 'FirstTime' , 'FALSE' );

        with TFormChAdr.Create( nil ) do
          try
            I := ShowModal;
            data_dir := DirectoryListBox.Directory;
          finally
            Free;
          end;

        if I = 1 then
          begin
            CreateDir( data_dir+'\Ponuky' );
            CreateDir( data_dir+'\Dodacie' );
            CreateDir( data_dir+'\HlaviËky' );
            CreateDir( data_dir+'\Texty' );
			CreateDir( data_dir+'\äablÛny' );
			CreateDir( data_dir+'\Z·kazky' );

            Regs.WriteString( 'data_dir' , data_dir+'\' );
            Regs.WriteString( 'ponuky_dir' , data_dir+'\Ponuky\' );
			Regs.WriteString( 'dodacie_dir' , data_dir+'\Dodacie\' );
            Regs.WriteString( 'hlavicky_dir' , data_dir+'\HlaviËky\' );
            Regs.WriteString( 'texty_dir' , data_dir+'\Texty\' );
			Regs.WriteString( 'sablony_dir' , data_dir+'\äablÛny\' );
			Regs.WriteString( 'zakazky_dir' , data_dir+'\Z·kazky\' );

            Regs.WriteString( 'sablona' , '' );
            Regs.WriteString( 'text' , '' );
            Regs.WriteString( 'hlavicka' , '' );
			Regs.WriteString( 'manager' , '' );
          end;
      end;
  finally
    Regs.Free;
  end;
end;

procedure THlavneOkno.Inicializacia;
var Sirka : integer;
    I : integer;
    c : char;
    Regs : TRegistry;
begin
  Sablona := '';
  StatusBar.Panels[0].Text := '';
  CisloDodacieho.Caption := '';

  Regs := TRegistry.Create;
  try
    Regs.RootKey := HKEY_LOCAL_MACHINE;
    Regs.OpenKey( '\Software\Dodacie' , False );

    dodacie_dir := Regs.ReadString( 'dodacie_dir' );
    ponuky_dir := Regs.ReadString( 'ponuky_dir' );
    sablony_dir := Regs.ReadString( 'sablony_dir' );
    texty_dir := Regs.ReadString( 'texty_dir' );
    hlavicky_dir := Regs.ReadString( 'hlavicky_dir' );
	data_dir := Regs.ReadString( 'data_dir' );
	zakazky_dir := Regs.ReadString( 'zakazky_dir' );

    sablona := Regs.ReadString( 'sablona' );
    spol_text := Regs.ReadString( 'text' );
    hlavicka := Regs.ReadString( 'hlavicka' );
	manager := Regs.ReadString( 'manager' );
  finally
    Regs.Free;
  end;

  //String grid komponenty
  with StringGridPon do
    begin
      Cells[0,0] := 'Komponenty';
      Cells[1,0] := 'Model';
      Cells[2,0] := 'Cena bez DPH';
      Cells[3,0] := 'Cena s DPH';
      Cells[4,0] := 'N·kupn· cena';

      for I := 0 to ColCount-1 do
        ColWidths[I] := (Width div ColCount)-2;

      NovaPonClick( nil );
    end;

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

  //Ponuka
  OtvPonuka := '';

  Adresy.NapisAdresu( MemoAdr , 0 , True );
  c := #0;
  ComboBoxA.Clear;
  ComboBoxAD.Clear;
  for I := 0 to Length( Adresy.Adresy )-1 do
    begin
      if Adresy.Adresy[I][0][1] <> c then
        begin
          c := Adresy.Adresy[I][0][1];
          ComboBoxA.Items.Add( c );
        end;
      ComboBoxAD.Items.Add( Adresy.Adresy[I][0] );
    end;

  ComboBoxAD.ItemIndex := -1;
  if Length( Adresy.Adresy )-1 > 0 then
    begin
      ComboBoxA.ItemIndex := 0;
    end;

  Adr2Active := 0;

  //String grid dodaci z ponuky
  Sirka := (StringGridPol.Width div StringGridPol.ColCount) - 2;
  for I := 0 to StringGridPol.ColCount-1 do
    StringGridPol.ColWidths[I] := Sirka;
  with StringGridPol do
    begin
      Cells[0,0] := 'Komponenty';
      Cells[1,0] := 'Model';
      Cells[2,0] := 'SÈriovÈ ËÌsla';
      Cells[3,0] := 'Z·ruka';
    end;
end;

procedure THlavneOkno.FormCreate(Sender: TObject);
begin
  RegIni;

  TlacDod := TTlacDod.Create;
  Faktury := TFaktury.Create;
  Ponuka := TPonuka.Create;
  Adresy := TAdresy.Create;
  DodPon := TDodPon.Create( PStrings( StringGridPol.Cols[0] ) ,
                            PStrings( StringGridPol.Cols[1] ) ,
                            PStrings( StringGridPol.Cols[2] ) ,
							PStrings( StringGridPol.Cols[3] ) ,
                            PStrings( MemoAdr2.Lines ) ,
                            EditDatumDod ,
                            StringGridPol );
  Inicializacia;
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
    Regs : TRegistry;
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

  if dodacie_dir <> '' then
    while dodacie_dir[Length(dodacie_dir)] <> '\' do
      Delete( dodacie_dir , Length(dodacie_dir) , 1 );

  Regs := TRegistry.Create;
  try
    Regs.RootKey := HKEY_LOCAL_MACHINE;
	Regs.OpenKey( '\Software\Dodacie' , False );

    Regs.WriteString( 'dodacie_dir' , dodacie_dir );
    Regs.WriteString( 'ponuky_dir' , ponuky_dir );
    Regs.WriteString( 'sablony_dir' , sablony_dir );
    Regs.WriteString( 'texty_dir' , texty_dir );
    Regs.WriteString( 'hlavicky_dir' , hlavicky_dir );
    Regs.WriteString( 'zakazky_dir' , zakazky_dir );

    Regs.WriteString( 'sablona' , sablona );
    Regs.WriteString( 'text' , spol_text );
	Regs.WriteString( 'hlavicka' , hlavicka );
  finally
    Regs.Free;
  end;

  DodPon.Free;
  Adresy.Free;
  Ponuka.Free;
  TlacDod.Free;
  Faktury.Free;
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
    Nazov : string;
begin
  if not Aktivny.Ulozeny then
    if MessageDlg( 'DodacÌ list nie je uloûen˝! Chcete pokraûovaù?' , mtWarning , [mbYES , mbNO] , 0 ) <> mrYES then exit;

  CisloFaktury := DodaciKFakture.ShowModal-1;
  if CisloFaktury < 0 then exit;

  if Dodaci.Otvoreny then UvolniPamat;
  Dodaci.Otvoreny := False;

  if DodaciKFakture.RadioButton1.Checked then
    if CisloFaktury > -1 then
      begin
        Notebook.PageIndex := 0;

        Aktivny.Subor := '';
        UrobZmenu;

        Dodaci := FakturaToDodaci( CisloFaktury );

        NahadzDataDoFormu;

        DodacieUlozit.Enabled := True;
        DodacieUlozitAko.Enabled := True;
        DodacieTlacit.Enabled := True;

        ToolButtonSaveDod.Enabled := True;
        ToolButtonPrnDod.Enabled := True;

        PlatneUdaje := True;
      end;

  if DodaciKFakture.RadioButton2.Checked then
    begin
      Notebook.PageIndex := 1;

      if Dodaci.Otvoreny then UvolniPamat;
      Dodaci.Otvoreny := False;
      Aktivny.Subor := '';

      DodacieUlozit.Enabled := True;
      DodacieUlozitAko.Enabled := True;
      DodacieTlacit.Enabled := True;

      ToolButtonSaveDod.Enabled := True;
      ToolButtonPrnDod.Enabled := True;

      PlatneUdaje := True;

      DodPon.OtvorZPon( DodaciKFakture.FileName );

      StringGridPol.RowCount := DodPon.Count+1;

      Nazov := ExtractFileName( DodaciKFakture.FileName );
	  Delete( Nazov , Pos( '.' , Nazov ) , Length( Nazov ) );
      Nazov[1] := 'K';
      CisloDodacieho.Caption := Nazov;
    end;

  if DodaciKFakture.RadioButton3.Checked then
    begin
      Notebook.PageIndex := 1;

      if Dodaci.Otvoreny then UvolniPamat;
      Dodaci.Otvoreny := False;
      Aktivny.Subor := '';

      DodacieUlozit.Enabled := True;
      DodacieUlozitAko.Enabled := True;
      DodacieTlacit.Enabled := True;

      ToolButtonSaveDod.Enabled := True;
      ToolButtonPrnDod.Enabled := True;

      PlatneUdaje := True;

      ComboBoxAD.ItemIndex := -1;
	  MemoAdr2.Clear;
      EditDatumDod.Text := '';
      StringGridPol.RowCount := 2;
      StringGridPol.Cells[0,1] := '';
      StringGridPol.Cells[1,1] := '';
      StringGridPol.Cells[2,1] := '';
      StringGridPol.Cells[3,1] := '';

      CisloDodacieho.Caption := '';
    end;
end;

procedure THlavneOkno.DodacieUlozitClick(Sender: TObject);
begin
  if Aktivny.Subor = '' then DodacieUlozitAkoClick(Sender)
    else
      begin
        DodacieUlozit.Enabled := False;
        ToolButtonSaveDod.Enabled := False;

        if ActiveControl = Memo then MemoExit(nil);

        StatusBar.Panels[0].Text := '';
		Aktivny.Ulozeny := True;

        if Notebook.PageIndex = 0 then
          begin
            NacitajDataZFormu;
            NahadzDodaciDoSuboru;
          end
            else
          DodPon.Uloz( Aktivny.Subor );
      end;
end;

procedure THlavneOkno.DodacieUlozitAkoClick(Sender: TObject);
var SR : TSearchRec;
begin
  if Notebook.PageIndex = 0 then
    with SaveDialog do
      begin
        FileName := Dodaci.Cislo;
        InitialDir := dodacie_dir;
        DefaultExt := 'dod';
        Filter := 'PC PROMPT dodacÌ list|*.dod';
        Title := 'Uloûiù dodacÌ list';
	  end
      else
    with SaveDialog do
      begin
        InitialDir := dodacie_dir;
        DefaultExt := 'dpn';
        Filter := 'PC PROMPT dodacÌ list k ponuke|*.dpn';
        Title := 'Uloûiù dodacÌ list';

        FileName := CisloDodacieho.Caption+'.dpn';
        if (FileName = '.dpn') or
           (FindFirst( dodacie_dir+'\'+FileName , faAnyFile , SR ) = 0) then
          FileName := GenerujNazov( 'K' , 5 , dodacie_dir , 'dpn' );
        FindClose( SR );
      end;

  if SaveDialog.Execute then
    begin
      DodacieUlozit.Enabled := False;
      ToolButtonSaveDod.Enabled := False;

      Aktivny.Subor := SaveDialog.FileName;
      dodacie_dir := ExtractFileDir( Aktivny.Subor )+'\';

      if ActiveControl = Memo then MemoExit( nil );

      Aktivny.Ulozeny := True;
      StatusBar.Panels[0].Text := '';

      if Notebook.PageIndex = 0 then
        begin
          NacitajDataZFormu;
          NahadzDodaciDoSuboru;

          FormManager.PridajDodaci( Dodaci.Faktura^.Cislo , Aktivny.Subor );
        end
          else
        begin
          CisloDodacieho.Caption := ExtractFileName( Aktivny.Subor );
          DodPon.Uloz( Aktivny.Subor ,
                       PStrings( StringGridPol.Cols[0] ) ,
                       PStrings( StringGridPol.Cols[1] ) ,
                       PStrings( StringGridPol.Cols[2] ) ,
                       PStrings( StringGridPol.Cols[3] ) ,
                       PStrings( MemoAdr2.Lines ) ,
                       EditDatumDod );

          FormManager.PridajDodPon( DodPon.ZPonuky , Aktivny.Subor );
        end;
    end;
end;

procedure THlavneOkno.DodacieOtvoritClick(Sender: TObject);
var S : string;
begin
  if not Aktivny.Ulozeny then
    if MessageDlg( 'DodacÌ list nie je uloûen˝! Chcete pokraûovaù?' , mtWarning , [mbYES , mbNO] , 0 ) <> mrYES then exit;

  with OpenDialog do
    begin
      InitialDir := dodacie_dir;
      DefaultExt := '';
      Filter := 'PC PROMPT dodacÌ list|*.dod|PC PROMPT dodacÌ list k ponuke|*.dpn';
      Title := 'Otvoriù dodacÌ list';
    end;

  if OpenDialog.Execute then
    begin
      Aktivny.Subor := OpenDialog.FileName;
	  dodacie_dir := ExtractFileDir( Aktivny.Subor )+'\';

      //Alokuje pamat pre fakturu k dodaciemu listu :
      if Dodaci.Otvoreny then UvolniPamat;

      S := ExtractFileExt( Aktivny.Subor );
      if S = '.dod' then
        begin
          Notebook.PageIndex := 0;

          Dodaci.Otvoreny := True;
          New( Dodaci.Faktura );
          TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa := TStringList.Create;
          TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa := TStringList.Create;
          TFaktura( Dodaci.Faktura^ ).Polozky := TList.Create;

          NacitajDataZoSuboru;
          NahadzDataDoFormu;
        end
          else
        begin
          Dodaci.Otvoreny := False;

		  CisloDodacieho.Caption := ExtractFileName( Aktivny.Subor );

          Notebook.PageIndex := 1;
          ComboBoxAD.ItemIndex := -1;
          DodPon.Otvor( Aktivny.Subor );
        end;

      StatusBar.Panels[0].Text := '';

      DodacieUlozit.Enabled := False;
      DodacieUlozitAko.Enabled := True;
      DodacieTlacit.Enabled := True;

      ToolButtonSaveDod.Enabled := False;
      ToolButtonPrnDod.Enabled := True;

      PlatneUdaje := True;

      Aktivny.Ulozeny := True;
    end;
end;

procedure THlavneOkno.MainDodacieListyClick(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
end;

procedure THlavneOkno.MainKomponentyClick(Sender: TObject);
begin
  PageControl.ActivePageIndex := 1;
end;

procedure THlavneOkno.UlozitPonClick(Sender: TObject);
begin
  if UlozitAkoPon.Enabled then
    begin
      Ponuka.FormToPonuka( StringGridPon , EditKoef , EditDph , EditDatum ,
                           EditSDPH , EditBezDPH , MemoAdr );
      Ponuka.Uloz( OtvPonuka );
    end
      else
    UlozitAkoPonClick( nil );
end;

procedure THlavneOkno.UlozitAkoPonClick(Sender: TObject);
begin
  with SaveDialog do
    begin
      InitialDir := ponuky_dir;
      DefaultExt := '*.pnk';
      Filter := 'PC PROMPT ponuka|*.pnk';
      Title := 'Uloûiù ponuku';

      FileName := GenerujNazov( 'P' , 5 , ponuky_dir , 'pnk' );
    end;

  if SaveDialog.Execute then
    begin
      Ponuka.FormToPonuka( StringGridPon , EditKoef , EditDph , EditDatum ,
                           EditSDPH , EditBezDPH , MemoAdr );
      Ponuka.Uloz( SaveDialog.FileName );

      ponuky_dir := ExtractFileDir( SaveDialog.FileName )+'\';

      OtvPonuka := SaveDialog.FileName;

      UlozitAkoPon.Enabled := True;
      PonukaExport.Enabled := True;
      TlacitPon.Enabled := True;
	  ToolButtonPrint.Enabled := True;
      ToolButtonExport.Enabled := True;

      FormManager.PridajPonuku( OtvPonuka );
    end;
end;

procedure THlavneOkno.OtvoritPonClick(Sender: TObject);
begin
  if FormOtvoritPon.ShowModal = 1 then
    OtvorPonuku( FormOtvoritPon.FileName );
end;

procedure THlavneOkno.NovaPonClick(Sender: TObject);
var I, J : integer;
begin
  if sablona <> '' then
    begin
      NacitajSablonu( sablona , StringGridPon );
    end
      else
    with StringGridPon do
      begin
		RowCount := 1;
        RowCount := 2;
        FixedRows := 1;
      end;

  for I := 1 to StringGridPon.RowCount-1 do
    for J := 1 to StringGridPon.ColCount-1 do
      begin
        if J < StringGridPon.ColCount-1 then StringGridPon.Cells[J,I] := ''
                                        else StringGridPon.Cells[J,I] := '0,00';
      end;

  Adresy.NapisAdresu( MemoAdr , 0 , True );

  EditKoef.Text := '1,1';
  EditDPH.Text := '23';

  EditSDPH.Clear;
  EditBezDPH.Clear;

  OtvPonuka := '';

  EditDatum.Text := DateToStr( Now );

  UlozitAkoPon.Enabled := False;
  PonukaExport.Enabled := False;
  TlacitPon.Enabled := False;
  ToolButtonPrint.Enabled := False;
  ToolButtonExport.Enabled := False;

  ButtonAktClick( nil );
end;

procedure THlavneOkno.TlacitPonClick(Sender: TObject);
begin
  Ponuka.FormToPonuka( StringGridPon , EditKoef , EditDph , EditDatum ,
                       EditSDPH , EditBezDPH , MemoAdr );
  Ponuka.Tlac;
end;

procedure THlavneOkno.MainManagerClick(Sender: TObject);
begin
  FormManager.OtvorPonuku := OtvorPonuku;
  FormManager.OtvorDodPon := OtvorDodPon;
  FormManager.OtvorDod := OtvorDod;
  FormManager.ShowModal;
end;

procedure THlavneOkno.PonukaExportClick(Sender: TObject);
begin
  with SaveDialog do
    begin
      Title := 'Exportovanie ponuky ako s˙bora HTML';
      InitialDir := data_dir;
      FileName := 'export1.html';
      Filter := 'HTML files|*.html';
    end;
  if SaveDialog.Execute then
    begin
      Screen.Cursor := crHourglass;
      try
        Ponuka.FormToPonuka( StringGridPon , EditKoef , EditDph , EditDatum ,
                             EditSDPH , EditBezDPH , MemoAdr );
        Ponuka.ExportToHTML( SaveDialog.FileName );
      finally
        Screen.Cursor := crDefault;
      end;
    end;
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
  ToolButtonSaveDod.Enabled := True;
  ToolButtonPrnDod.Enabled := True;
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
//                                 M A N A G E R
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.OtvorPonuku( FileName : string );
begin
  PageControl.ActivePageIndex := 1;

  Ponuka.Otvor( FileName );
  Ponuka.PonukaToForm( StringGridPon , EditKoef , EditDph , EditDatum,
                       EditSDPH , EditBezDPH , MemoAdr );

  OtvPonuka := FileName;
  UlozitAkoPon.Enabled := True;
  PonukaExport.Enabled := True;
  TlacitPon.Enabled := True;
  ToolButtonPrint.Enabled := True;
  ToolButtonExport.Enabled := True;

  EditSDPH.Clear;
  EditBezDPH.Clear;

  ponuky_dir := ExtractFileDir( FileName )+'\';

  ButtonAktClick( nil );
end;

procedure THlavneOkno.OtvorDodPon( FileName : string );
begin
  if not Aktivny.Ulozeny then
    if MessageDlg( 'DodacÌ list nie je uloûen˝! Chcete pokraûovaù?' , mtWarning , [mbYES , mbNO] , 0 ) <> mrYES then exit;

  PageControl.ActivePageIndex := 0;
  Notebook.PageIndex := 1;

  Aktivny.Subor := FileName;
  dodacie_dir := ExtractFileDir( Aktivny.Subor )+'\';

  //Alokuje pamat pre fakturu k dodaciemu listu :
  if Dodaci.Otvoreny then UvolniPamat;

  Dodaci.Otvoreny := False;
  CisloDodacieho.Caption := ExtractFileName( Aktivny.Subor );
  Notebook.PageIndex := 1;
  DodPon.Otvor( Aktivny.Subor );

  StatusBar.Panels[0].Text := '';

  DodacieUlozit.Enabled := False;
  DodacieUlozitAko.Enabled := True;
  DodacieTlacit.Enabled := True;

  ToolButtonSaveDod.Enabled := False;
  ToolButtonPrnDod.Enabled := True;

  PlatneUdaje := True;

  Aktivny.Ulozeny := True;
end;

procedure THlavneOkno.OtvorDod( FileName : string );
begin
  if not Aktivny.Ulozeny then
    if MessageDlg( 'DodacÌ list nie je uloûen˝! Chcete pokraûovaù?' , mtWarning , [mbYES , mbNO] , 0 ) <> mrYES then exit;

  PageControl.ActivePageIndex := 0;
  Notebook.PageIndex := 0;

  Aktivny.Subor := FileName;
  dodacie_dir := ExtractFileDir( Aktivny.Subor )+'\';

  //Alokuje pamat pre fakturu k dodaciemu listu :
  if Dodaci.Otvoreny then UvolniPamat;

  Notebook.PageIndex := 0;

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
  DodacieTlacit.Enabled := True;

  ToolButtonSaveDod.Enabled := False;
  ToolButtonPrnDod.Enabled := True;

  PlatneUdaje := True;

  Aktivny.Ulozeny := True;
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

procedure THlavneOkno.DodacieTlacitClick(Sender: TObject);
begin
  if not PlatneUdaje then exit;
  if Notebook.PageIndex = 0 then
    begin
      if PrintDialog.Execute then
        begin
          NacitajDataZFormu;
          TlacDod.Vytlac( @Dodaci );
        end;
    end
      else
    begin
      DodPon.Tlac;
    end;
end;

//==============================================================================
//==============================================================================
//
//                                P O N U K A
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.UlozSablonu( Cesta : string; StringGrid : TStringGrid );
var I : integer;
begin
  AssignFile( Output , Cesta );
  {$I-}
  Rewrite( Output );
  {$I+}
  if IOResult <> 0 then exit;

  Writeln( IntToStr( StringGrid.RowCount ) );
  for I := 1 to StringGrid.RowCount-1 do
    Writeln( StringGrid.Cells[0,I] );

  CloseFile( Output );

  Sablona := Cesta;

  sablony_dir := Cesta;
  I := Length( sablony_dir );
  while Cesta[I] <> '\' do
	Dec( I );
  Delete( sablony_dir , I+1 , Length( sablony_dir ) - I );
end;

procedure THlavneOkno.NacitajSablonu( Cesta : string; StringGrid : TStringGrid );
var I, N : integer;
    S : string;
begin
  AssignFile( Input , Cesta );
  {$I-}
  Reset( Input );
  {$I+}
  with StringGrid do
    begin
      RowCount := 2;
    end;
  if IOResult <> 0 then exit;

  Readln( N );
  StringGrid.RowCount := N;
  for I := 1 to N do
    begin
      Readln( S );
	  StringGrid.Cells[0,I] := S;
    end;

  CloseFile( Input );

  Sablona := Cesta;

  sablony_dir := Cesta;
  I := Length( sablony_dir );
  while Cesta[I] <> '\' do
    Dec( I );
  Delete( sablony_dir , I+1 , Length( sablony_dir ) - I );
end;

procedure THlavneOkno.UlozitClick(Sender: TObject);
begin
  with SaveDialog do
    begin
      FileName := GenerujNazov( 'S' , 2 , sablony_dir , 'sbl' );
      InitialDir := sablony_dir;
      DefaultExt := '*.sbl';
      Filter := 'PC PROMPT öablÛna|*.sbl';
      Title := 'Uloûiù öablÛnu';
	end;

  if SaveDialog.Execute then
    UlozSablonu( SaveDialog.FileName , StringGridPon );
end;

procedure THlavneOkno.StringGridPonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var C, R : integer;
begin
  if Button = mbRight then
    with StringGridPon do
      begin
        MouseToCell( X , Y , C , R );
        if (R = 0) or
           (C = -1) or
           (R = -1) then exit;
        Col := C;
        Row := R;
      end;
end;

procedure THlavneOkno.Vloiriadok1Click(Sender: TObject);
var I, J : integer;
begin
  StringGridPon.RowCount := StringGridPon.RowCount + 1;

  for I := StringGridPon.RowCount-1 downto StringGridPon.Row+1 do
    for J := 0 to StringGridPon.ColCount-1 do
      StringGridPon.Cells[J,I] := StringGridPon.Cells[J,I-1];

  for I := 0 to StringGridPon.ColCount-1 do
    StringGridPon.Cells[I,StringGridPon.Row+1] := '';
end;

procedure THlavneOkno.Zmazariadok1Click(Sender: TObject);
var I, J : integer;
begin
  for I := StringGridPon.Row to StringGridPon.RowCount-1 do
    for J := 0 to StringGridPon.ColCount-1 do
      StringGridPon.Cells[J,I] := StringGridPon.Cells[J,I+1];
  StringGridPon.RowCount := StringGridPon.RowCount-1;
  if StringGridPon.RowCount = 1 then
    begin
      StringGridPon.RowCount := 2;
      StringGridPon.FixedRows := 1;
	end;
end;

procedure THlavneOkno.StringGridPonKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var S : string;
    I : integer;
begin
  case Key of
    VK_RETURN : if StringGridPon.Row < StringGridPon.RowCount-1 then
                  StringGridPon.Row := StringGridPon.Row + 1;
    VK_DELETE : if not StringGridPon.EditorMode then
                  StringGridPon.Cells[ StringGridPon.Col , StringGridPon.Row ] := '';
    VK_INSERT : Vloiriadok1Click(nil);
    Ord( 'V' ) : if (ssCtrl in Shift) then
                   begin
                     S := Clipboard.AsText;
                     for I := 1 to Length( S ) do
                       if (S[I] = #13) or
                          (S[I] = #10) then S[I] := ' ';
                     StringGridPon.Cells[ StringGridPon.Col , StringGridPon.Row ] := S;
                   end;
  end;
end;

procedure THlavneOkno.ButtonAktClick(Sender: TObject);
var I : integer;
    Koef, DPH : real;
    CelkomS, CelkomBez : real;
    S : string;
begin
  Koef := StrToFloat( EditKoef.Text );
  DPH := StrToFloat( EditDPH.Text );

  CelkomS := 0;
  CelkomBez := 0;

  for I := 1 to StringGridPon.RowCount-1 do
    begin
      if (StringGridPon.Cells[4,I] = '') then
        StringGridPon.Cells[4,I] := '0,00';

      try
        StrToFloat( StringGridPon.Cells[4,I] );
      except
        if Pos( '(CHYBA)' , StringGridPon.Cells[4,I] ) = 0 then
		  StringGridPon.Cells[4,I] := StringGridPon.Cells[4,I] + '(CHYBA)';
        continue;
      end;
      S := FloatToStr( Round(StrToFloat( StringGridPon.Cells[4,I] )*Koef*10)/10 );
      S := Ponuka.FormatNumber( S );
      StringGridPon.Cells[2,I] := S;

      if (StringGridPon.Cells[2,I] = '') then
        StringGridPon.Cells[2,I] := '0,00';
      try
        StrToFloat( StringGridPon.Cells[2,I] );
      except
        if Pos( '(CHYBA)' , StringGridPon.Cells[2,I] ) = 0 then
          StringGridPon.Cells[2,I] := StringGridPon.Cells[2,I] + '(CHYBA)';
        continue;
      end;
      S := FloatToStr( Round(StrToFloat( StringGridPon.Cells[2,I] )*(1+(DPH/100))*10)/10 );
      S := Ponuka.FormatNumber( S );
      StringGridPon.Cells[3,I] := S;
    end;

  for I := 1 to StringGridPon.RowCount-1 do
    begin
	  try
        CelkomS := CelkomS + StrToFloat( StringGridPon.Cells[3,I] );
      except
        if Pos( '(CHYBA)' , StringGridPon.Cells[3,I] ) = 0 then
          StringGridPon.Cells[3,I] := StringGridPon.Cells[3,I] + '(CHYBA)';
      end;
      try
        CelkomBez := CelkomBez + StrToFloat( StringGridPon.Cells[2,I] );
      except
        if Pos( '(CHYBA)' , StringGridPon.Cells[2,I] ) = 0 then
          StringGridPon.Cells[2,I] := StringGridPon.Cells[2,I] + '(CHYBA)';
      end;
    end;

  EditSDPH.Text := Ponuka.FormatNumber( FloatToStr( CelkomS ) );
  EditBezDPH.Text := Ponuka.FormatNumber( FloatToStr( CelkomBez ) );
end;

procedure THlavneOkno.ButtonNextClick(Sender: TObject);
begin
  Adresy.NapisAdresu( MemoAdr , Adresy.Active+1 , True );
end;

procedure THlavneOkno.ButtonPrevClick(Sender: TObject);
begin
  Adresy.NapisAdresu( MemoAdr , Adresy.Active-1 , True );
end;

procedure THlavneOkno.ComboBoxAChange(Sender: TObject);
var I : integer;
begin
  for I := 0 to Length( Adresy.Adresy )-1 do
    if Adresy.Adresy[I][0][1] = ComboBoxA.Items[ ComboBoxA.ItemIndex ][1] then
      begin
        Adresy.NapisAdresu( MemoAdr , I , True );
        break;
      end;
end;

procedure THlavneOkno.OtvoritSablonuClick(Sender: TObject);
begin
  with OpenDialog do
    begin
      InitialDir := sablony_dir;
      DefaultExt := '*.sbl';
      Filter := 'PC PROMPT öablÛna|*.sbl';
	  Title := 'Otvoriù öablÛnu';
    end;

  if OpenDialog.Execute then
    begin
      sablona := OpenDialog.FileName;
      NovaPonClick( self );
    end;
end;

procedure THlavneOkno.EditKoefExit(Sender: TObject);
begin
  try
    StrToFloat( EditKoef.Text );
  except
    on EConvertError do
      begin
        MessageDlg( 'Zadan· hodnota nie je re·lne ËÌslo!' , mtError , [mbOK] , 0 );
        EditKoef.SetFocus;
        EditKoef.SelectAll;
        exit;
      end;
  end;
end;

procedure THlavneOkno.EditDPHExit(Sender: TObject);
begin
  try
    StrToFloat( EditDPH.Text );
  except
    on EConvertError do
      begin
        MessageDlg( 'Zadan· hodnota nie je re·lne ËÌslo!' , mtError , [mbOK] , 0 );
        EditDPH.SetFocus;
        EditDPH.SelectAll;
        exit;
      end;
  end;
end;

procedure THlavneOkno.MoznostiClick(Sender: TObject);
begin
  FormMozn.ShowModal;
end;

procedure THlavneOkno.ToolButtonNewClick(Sender: TObject);
begin
  NovaPonClick( Sender );
end;

procedure THlavneOkno.ToolButtonOpenClick(Sender: TObject);
begin
  OtvoritPonClick( Sender );
end;

procedure THlavneOkno.ToolButtonSaveClick(Sender: TObject);
begin
  UlozitPonClick( Sender );
end;

procedure THlavneOkno.ToolButtonPrintClick(Sender: TObject);
begin
  TlacitPonClick( Sender );
end;

procedure THlavneOkno.StringGridPolKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var I : integer;
    S : string;
begin
  case Key of
    VK_RETURN : if StringGridPol.Row < StringGridPol.RowCount-1 then
                  StringGridPol.Row := StringGridPol.Row + 1;
    VK_DELETE : StringGridPol.Cells[ StringGridPol.Col , StringGridPol.Row ] := '';
    VK_INSERT : if not StringGridPol.EditorMode then
                  Vloiriadok2Click(nil);
    Ord( 'V' ) : if (ssCtrl in Shift) then
                   begin
                     S := Clipboard.AsText;
                     for I := 1 to Length( S ) do
                       if (S[I] = #13) or
                          (S[I] = #10) then S[I] := ' ';
                     StringGridPol.Cells[ StringGridPol.Col , StringGridPol.Row ] := S;
                   end;
    Ord( 'C' ) : if (ssCtrl in Shift) then
                   Clipboard.AsText := StringGridPol.Cells[ StringGridPol.Col , StringGridPol.Row ];
  end;
end;

procedure THlavneOkno.MemoAdr2Enter(Sender: TObject);
begin
  UrobZmenu;
end;

procedure THlavneOkno.EditDatumDodEnter(Sender: TObject);
begin
  UrobZmenu;
end;

procedure THlavneOkno.StringGridPolGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  UrobZmenu;
end;

procedure THlavneOkno.ToolButtonExportClick(Sender: TObject);
var FileNamePon, FileNameDod : string;
    SR : TSearchRec;
begin
  // Uloûenie ponuky
  with SaveDialog do
    begin
      InitialDir := dodacie_dir;
      DefaultExt := '*.dpn';
      Filter := 'PC PROMPT dodacÌ k ponuke|*.dpn';
	  Title := 'Exportovaù ponuku ako dodacÌ';

      FileNameDod := GenerujNazov( 'P' , 5 , ponuky_dir , 'pnk' );
      FileNameDod[1] := 'K';

      FileName := FileNameDod;
    end;

  if SaveDialog.Execute then
    begin
      Ponuka.FormToPonuka( StringGridPon , EditKoef , EditDph , EditDatum ,
                           EditSDPH , EditBezDPH , MemoAdr );

      FileNamePon := ExtractFileName( SaveDialog.FileName );
      Delete( FileNamePon , Pos( '.' , FileNamePon ) , Length( FileNamePon ) );
      FileNamePon[1] := 'P';
      FileNamePon := FileNamePon + '.pnk';

      if FindFirst( ponuky_dir+'\'+FileNamePon , faAnyFile , SR ) = 0 then
        if MessageDlg( 'Ponuka s n·zvom '+FileNamePon+' uû existuje. Prajete si prepÌsaù tento s˙bor?'
                       , mtWarning , [mbYes,mbNo] , 0 ) = mrNo then
                         begin
                           FindClose( SR );
						   exit;
                         end;
      FindClose( SR );

      Ponuka.Uloz( ponuky_dir+'\'+FileNamePon );

      OtvPonuka := ponuky_dir+'\'+FileNamePon;
      UlozitAkoPon.Enabled := True;

      FormManager.PridajPonuku( OtvPonuka );
    end
      else
    exit;

  // Otvorenie dodacieho z ponuky

  if not Aktivny.Ulozeny then
    if MessageDlg( 'DodacÌ list nie je uloûen˝! Chcete pokraûovaù?' , mtWarning , [mbYES , mbNO] , 0 ) <> mrYES then exit;

  if Dodaci.Otvoreny then UvolniPamat;
  Dodaci.Otvoreny := False;

  Notebook.PageIndex := 1;

  if Dodaci.Otvoreny then UvolniPamat;
  Dodaci.Otvoreny := False;

  DodacieUlozitAko.Enabled := True;
  DodacieTlacit.Enabled := True;

  ToolButtonPrnDod.Enabled := True;

  PlatneUdaje := True;

  DodPon.OtvorZPon( ponuky_dir+'\'+FileNamePon );

  // Uloûenie dodacieho

  StringGridPol.RowCount := DodPon.Count+1;

  DodacieUlozit.Enabled := False;
  ToolButtonSaveDod.Enabled := False;

  StatusBar.Panels[0].Text := '';

  Aktivny.Subor := SaveDialog.FileName;
  DodPon.Uloz( Aktivny.Subor );
  Aktivny.Ulozeny := True;

  PageControl.ActivePageIndex := 0;

  FileNameDod := ExtractFileName( FileNamePon );
  FileNameDod[1] := 'K';
  Delete( FileNameDod , Pos( '.' , FileNameDod ) , Length( FileNameDod ) );
  CisloDodacieho.Caption := FileNameDod;

  FormManager.PridajDodPon( ponuky_dir+'\'+FileNamePon , SaveDialog.FileName );
end;

procedure THlavneOkno.ComboBoxADChange(Sender: TObject);
begin
  Adresy.NapisAdresu( MemoAdr2 , ComboBoxAD.ItemIndex , False );
end;

procedure THlavneOkno.Vloiriadok2Click(Sender: TObject);
var I : integer;
begin
  StringGridPol.RowCount := StringGridPol.RowCount+1;
  for I := StringGridPol.RowCount-1 downto StringGridPol.Row+1 do
	StringGridPol.Rows[I].Assign( StringGridPol.Rows[I-1] );
  for I := 0 to 3 do
    StringGridPol.Cells[I,StringGridPol.Row] := '';
end;

procedure THlavneOkno.Zmazariadok2Click(Sender: TObject);
var I : integer;
    Prazdny : boolean;
begin
  Prazdny := True;
  for I := 0 to 3 do
    if StringGridPol.Cells[I,StringGridPol.Row] <> '' then
      begin
        Prazdny := False;
        break;
      end;
  if (Prazdny) and
     (StringGridPol.RowCount = 2) then exit;

  for I := StringGridPol.Row to StringGridPol.RowCount-2 do
    StringGridPol.Rows[I].Assign( StringGridPol.Rows[I+1] );
  if StringGridPol.RowCount > 2 then
    StringGridPol.RowCount := StringGridPol.RowCount-1
	  else
    for I := 0 to 3 do
      StringGridPol.Cells[I,1] := '';
end;

procedure THlavneOkno.Uloiablnu1Click(Sender: TObject);
begin
  with SaveDialog do
    begin
      FileName := GenerujNazov( 'S' , 2 , sablony_dir , 'sbl' );
      InitialDir := sablony_dir;
      DefaultExt := '*.sbl';
      Filter := 'PC PROMPT öablÛna|*.sbl';
      Title := 'Uloûiù öablÛnu';
    end;

  if SaveDialog.Execute then
    UlozSablonu( SaveDialog.FileName , StringGridPol );
end;

procedure THlavneOkno.Otvoriablnu1Click(Sender: TObject);
begin
    with OpenDialog do
	begin
      InitialDir := sablony_dir;
      DefaultExt := '*.sbl';
      Filter := 'PC PROMPT öablÛna|*.sbl';
      Title := 'Otvoriù öablÛnu';
    end;

  if OpenDialog.Execute then
    begin
      UrobZmenu;
      PlatneUdaje := True;
      NacitajSablonu( OpenDialog.FileName , StringGridPol );
    end;
end;

procedure THlavneOkno.Zkazkovlist1Click(Sender: TObject);
begin
  ZakList.ShowModal;
end;

end.

