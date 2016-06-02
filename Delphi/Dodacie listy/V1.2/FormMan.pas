unit FormMan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids;

type
  TOpenFile = procedure( FileName : string ) of object;

  TFormManager = class(TForm)
    ButtonOK: TButton;
    StringGrid: TStringGrid;
    SaveDialog: TSaveDialog;
    GroupBox1: TGroupBox;
    Memo: TMemo;
    Label1: TLabel;
    ButtonOddel: TButton;
    ComboBoxF: TComboBox;
    ComboBoxP: TComboBox;
    ButtonSpoj: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure StringGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure StringGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ButtonOddelClick(Sender: TObject);
    procedure ComboBoxFChange(Sender: TObject);
    procedure ButtonSpojClick(Sender: TObject);
    procedure ComboBoxPChange(Sender: TObject);
    procedure StringGridDblClick(Sender: TObject);
  private
    { Private declarations }
    Spojene : array of boolean;
    Path : array[0..3] of array of string;

    SlctF, SlctP : integer;

    procedure NacitajTabulku;
    procedure PrekresliTabulku;
    procedure UlozTabulku;

    procedure PridajPolozku;
    procedure ZoradPodla( Col : integer );
  public
    { Public declarations }
    OtvorPonuku : TOpenFile;
    OtvorDodPon : TOpenFile;
    OtvorDod : TOpenFile;

    procedure PridajDodaci( Faktura, Dodaci : string );
    procedure PridajDodPon( Ponuka, DodPon : string );
    procedure PridajPonuku( Ponuka : string );
  end;

var
  FormManager: TFormManager;

implementation

uses Ini, ClassFaktury, Typy, Registry;

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                  Constructor
//
//==============================================================================
//==============================================================================

procedure TFormManager.FormCreate(Sender: TObject);
var I : integer;
    Sirka : integer;
begin
  Sirka := StringGrid.ClientWidth div StringGrid.ColCount - 5;
  with StringGrid do
    begin
      Cells[0,0] := 'Fakt˙ra';
      Cells[1,0] := 'DodacÌ list';
      Cells[2,0] := 'DodacÌ k ponuke';
      Cells[3,0] := 'Ponuka';

      for I := 0 to ColCount-1 do
        ColWidths[I] := Sirka;
    end;

  SlctF := -1;
  SlctP := -1;

  SetLength( Spojene , 0 );
  for I := 0 to 3 do
    SetLength( Path[I] , 0 );

  NacitajTabulku;
  PrekresliTabulku;
end;

//==============================================================================
//==============================================================================
//
//                                  Destructor
//
//==============================================================================
//==============================================================================

procedure TFormManager.FormDestroy(Sender: TObject);
begin
  UlozTabulku;
end;

//==============================================================================
//==============================================================================
//
//                                    Events
//
//==============================================================================
//==============================================================================

procedure TFormManager.ButtonOKClick(Sender: TObject);
begin
  ModalResult := 1;
end;

procedure TFormManager.StringGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var I : integer;
    Col, Row : integer;
begin
  StringGrid.MouseToCell( X , Y , Col , Row );
  if (Row = -1) and
     (Col = -1) then exit;

  SlctF := -1;
  SlctP := -1;

  if (Row = 0) then
    begin
      with StringGrid do
        begin
          Cells[0,0] := 'Fakt˙ra';
          Cells[1,0] := 'DodacÌ list';
          Cells[2,0] := 'DodacÌ k ponuke';
          Cells[3,0] := 'Ponuka';
        end;

      case Col of
        0 : StringGrid.Cells[0,0] := 'Fakt˙ra*';
        1 : StringGrid.Cells[1,0] := 'DodacÌ list*';
        2 : StringGrid.Cells[2,0] := 'DodacÌ k ponuke*';
        3 : StringGrid.Cells[3,0] := 'Ponuka*';
      end;

      ZoradPodla( Col );
    end
      else
    begin
      if Spojene[Row-1] then ButtonOddel.Enabled := TRUE
                        else
                          begin
                            ButtonOddel.Enabled := FALSE;

                            if Col < 2 then
                              begin
                                for I := 0 to ComboBoxF.Items.Count-1 do
                                  if ComboBoxF.Items[I] = StringGrid.Cells[0,Row] then
                                    begin
                                      ComboBoxF.ItemIndex := I;
                                      SlctF := Row-1;
                                      break;
                                    end;
                              end
                                else
                              begin
                                for I := 0 to ComboBoxP.Items.Count-1 do
                                  if ComboBoxP.Items[I] = StringGrid.Cells[3,Row] then
                                    begin
                                      ComboBoxP.ItemIndex := I;
                                      SlctP := Row-1;
                                      break;
                                    end;
                              end
                          end;

    end;
end;

procedure TFormManager.StringGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);

procedure AdrDod;
var I, J : integer;
    S : string;
begin
  if Path[1][ARow-1] = '' then exit;

  AssignFile( Input , Path[1][ARow-1] );
  {$I-}
  Reset( Input );
  {$I+}
  if IOResult <> 0 then
    begin
      Memo.Lines.Add( 'S˙bor '+Path[1][ARow-1]+' sa ned· otvoriù!' );
      exit;
    end;

  Readln;

  //Dodavatel :
  Readln( J );
  for I := 1 to J+1 do Readln;

  //Odberatel :
  Readln( J );
  for I := 1 to J do
    begin
      Readln( S  );
      Memo.Lines.Add( S );
    end;

  CloseFile( Input );
end;

procedure AdrDodPon;
var I, J, Count : integer;
    S : string;
begin
  if Path[2][ARow-1] = '' then exit;

  AssignFile( Input , Path[2][ARow-1] );
  {$I-}
  Reset( Input );
  {$I+}
  if IOResult <> 0 then
    begin
      Memo.Lines.Add( 'S˙bor '+Path[2][ARow-1]+' sa ned· otvoriù!' );
      exit;
    end;

  Readln;
  Readln( Count );
  for I := 1 to Count do
    for J := 0 to 3 do
      Readln( S );

  while not EoF( Input ) do
    begin
      Readln( S );
      Memo.Lines.Add( S );
    end;

  CloseFile( Input );
end;

procedure AdrPon;
var I, J, Count : integer;
    S : string;
begin
  if Path[3][ARow-1] = '' then exit;

  AssignFile( Input , Path[3][ARow-1] );
  {$I-}
  Reset( Input );
  {$I+}
  if IOResult <> 0 then
    begin
      Memo.Lines.Add( 'S˙bor '+Path[3][ARow-1]+' sa ned· otvoriù!' );
      exit;
    end;

  Readln;
  Readln;
  Readln( Count );
  for I := 1 to Count do
    for J := 1 to 5 do
      Readln;

  Readln;
  Readln;

  while not EoF( Input ) do
    begin
      Readln( S );
      Memo.Lines.Add( S );
    end;

  CloseFile( Input );
end;

begin
  if Length( Spojene ) > 0 then CanSelect := True
                           else
                             begin
                               CanSelect := False;
                               exit;
                             end;

  Memo.Clear;
  case ACol of
    1 : AdrDod;
    2 : AdrDodPon;
    3 : AdrPon;
  end;
end;

procedure TFormManager.ButtonOddelClick(Sender: TObject);
begin
  PridajPolozku;

  Path[2][Length( Path[2] )-1] := Path[2][StringGrid.Row-1];
  Path[3][Length( Path[3] )-1] := Path[3][StringGrid.Row-1];
  Spojene[Length( Spojene )-1] := FALSE;

  Path[2][StringGrid.Row-1] := '';
  Path[3][StringGrid.Row-1] := '';
  Spojene[StringGrid.Row-1] := FALSE;

  PrekresliTabulku;

  ButtonOddel.Enabled := FALSE;
end;

procedure TFormManager.ComboBoxFChange(Sender: TObject);
begin
  SlctF := -1;
end;

procedure TFormManager.ComboBoxPChange(Sender: TObject);
begin
  SlctP := -1;
end;

procedure TFormManager.ButtonSpojClick(Sender: TObject);
var I, J : integer;
begin
  if (ComboBoxF.ItemIndex = -1) or
     (ComboBoxP.ItemIndex = -1) then
       exit;

  if SlctF = -1 then
    for I := 0 to Length( Path[0] )-1 do
      if Path[0][I] = ComboBoxF.Items[ ComboBoxF.ItemIndex ] then
        begin
          SlctF := I;
          break;
        end;

  if SlctP = -1 then
    for I := 0 to Length( Path[3] )-1 do
      if ExtractFileName( Path[3][I] ) = ComboBoxP.Items[ ComboBoxP.ItemIndex ] then
        begin
          SlctP := I;
          break;
        end;

  if (SlctF = -1) or
     (SlctP = -1) then
       exit;

  Path[2][SlctF] := Path[2][SlctP];
  Path[3][SlctF] := Path[3][SlctP];
  Spojene[SlctF] := True;

  for I := SlctP to Length( Path[0] )-2 do
    begin
      for J := 0 to 3 do
        Path[J][I] := Path[J][I+1];
      Spojene[I] := Spojene[I+1];
    end;

  for J := 0 to 3 do
    SetLength( Path[J] , Length( Path[J] )-1 );
  SetLength( Spojene , Length( Spojene )-1 );

  ComboBoxF.Items.Delete( ComboBoxF.ItemIndex );
  ComboBoxP.Items.Delete( ComboBoxP.ItemIndex );

  PrekresliTabulku;
end;

procedure TFormManager.StringGridDblClick(Sender: TObject);
begin
  if (StringGrid.Row = -1 ) and
     (StringGrid.Col = -1 ) then
       exit;

  case StringGrid.Col of
    1 : begin
          if (Path[1][StringGrid.Row-1] <> '') and
             Assigned( OtvorDod ) then
            begin
              Close;
              OtvorDod( Path[1][StringGrid.Row-1] );
            end;
        end;
    2 : begin
          if (Path[2][StringGrid.Row-1] <> '') and
             Assigned( OtvorDodPon ) then
            begin
              Close;
              OtvorDodPon( Path[2][StringGrid.Row-1] );
            end;
        end;
    3 : begin
          if (Path[3][StringGrid.Row-1] <> '') and
             Assigned( OtvorPonuku ) then
            begin
              Close;
              OtvorPonuku( Path[3][StringGrid.Row-1] );
            end;
        end;
  end;
end;

//==============================================================================
//==============================================================================
//
//                             Praca so suborom
//
//==============================================================================
//==============================================================================

procedure TFormManager.NacitajTabulku;
var I, J, K, N : integer;
    Rec : array[0..4] of string;
    Nasiel : boolean;
begin
  with StringGrid do
    begin
      RowCount := 1;
      RowCount := 2;
      FixedRows := 1;
    end;

  if manager = '' then exit;

  for I := 0 to 3 do
    SetLength( Path[I] , Faktury.Zoznam.Count );
  SetLength( Spojene , Faktury.Zoznam.Count );

  for I := 0 to Faktury.Zoznam.Count-1 do
    begin
      Spojene[I] := FALSE;
      Path[0][I] := TFaktura( Faktury.Zoznam[I]^ ).Cislo;
    end;

  AssignFile( Input , manager );
  {$I-}
  Reset( Input );
  {$I+}
  if IOResult <> 0 then exit;

  Readln( N );
  for I := 0 to N-1 do
    begin
      for J := 0 to 4 do
        Readln( Rec[J] );

      Nasiel := False;
      if Rec[1] <> '' then
        for J := 0 to Length( Path[0] )-1 do
          if Path[0][J] = Rec[1] then
            begin
              for K := 1 to 4 do
                Path[K-1][J] := Rec[K];
              if Rec[0] = 'NIE' then Spojene[J] := FALSE
                                else Spojene[J] := TRUE;

              Nasiel := True;
              break;
            end;

      if not Nasiel then
        begin
          PridajPolozku;
          for J := 1 to 4 do
            Path[J-1][Length( Path[0] )-1] := Rec[J];
          if Rec[0] = 'NIE' then Spojene[Length( Path[0] )-1] := FALSE
                            else Spojene[Length( Path[0] )-1] := TRUE;
        end;
    end;

  CloseFile( Input );
end;

procedure TFormManager.UlozTabulku;
var I, J : integer;
    Regs : TRegistry;
begin
  if manager = '' then
    begin
      SaveDialog.InitialDir := data_dir;
      if SaveDialog.Execute then manager := SaveDialog.FileName
                            else exit;
    end;

  AssignFile( Output , manager );
  {$I-}
  Rewrite( Output );
  {$I+}
  if IOResult <> 0 then
    begin
      MessageDlg( 'Ned· sa zapisovaù do s˙boru '+manager, mtError , [mbOK] , 0 );
      exit;
    end;

  Writeln( Length( Path[0] ) );
  for I := 0 to Length( Path[0] )-1 do
    begin
      if Spojene[I] then Writeln( 'ANO' )
                    else Writeln( 'NIE' );
      for J := 0 to 3 do
        Writeln( Path[J][I] );
    end;

  CloseFile( Output );

  Regs := TRegistry.Create;
  try
    Regs.RootKey := HKEY_LOCAL_MACHINE;
    Regs.OpenKey( '\Software\Dodacie' , False );

    Regs.WriteString( 'manager' , manager );
  finally
    Regs.Free;
  end;
end;

//==============================================================================
//==============================================================================
//
//                             Pomocne funkcie
//
//==============================================================================
//==============================================================================

procedure TFormManager.PrekresliTabulku;
var I, J : integer;
begin
  if Length( Path[0] ) = 0 then exit;
  StringGrid.RowCount := Length( Path[0] )+1;
  for I := 0 to Length( Path[0] )-1 do
    begin
      StringGrid.Cells[0,1+I] := Path[0,I];
      for J := 1 to 3 do
        StringGrid.Cells[J,1+I] := ExtractFileName( Path[J,I] );
    end;

  ComboBoxF.Clear;
  for I := 0 to Length( Path[0] )-1 do
    if (not Spojene[I]) and
       (Path[0][I] <> '') then
      ComboBoxF.Items.Add( Path[0][I] );
  if ComboBoxF.Items.Count > 0 then
    ComboBoxF.ItemIndex := 0;

  ComboBoxP.Clear;
  for I := 0 to Length( Path[3] )-1 do
    if (not Spojene[I]) and
       (Path[3][I] <> '') then
      ComboBoxP.Items.Add( ExtractFileName( Path[3][I] ) );
  if ComboBoxP.Items.Count > 0 then
    ComboBoxP.ItemIndex := 0;
end;

procedure TFormManager.PridajPolozku;
var I : integer;
begin
  for I := 0 to 3 do
    begin
      SetLength( Path[I] , Length( Path[I] )+1 );
      Path[I][Length( Path[I] )-1] := '';
    end;
  SetLength( Spojene , Length( Spojene )+1 );
  Spojene[Length( Spojene )-1] := FALSE;
end;

procedure TFormManager.ZoradPodla( Col : integer );

procedure Vymen( I, J : integer );
var K : integer;
    Zaloha : array[0..3] of string;
    Z : boolean;
begin
  for K := 0 to 3 do
    Zaloha[K] := Path[K][I];

  for K := 0 to 3 do
    Path[K][I] := Path[K][J];

  for K := 0 to 3 do
    Path[K][J] := Zaloha[K];

  Z := Spojene[I];
  Spojene[I] := Spojene[J];
  Spojene[J] := Z;
end;

procedure Sort;
var I, J : integer;
begin
  for I := 0 to Length( Path[0] )-1 do
    for J := I+1 to Length( Path[0] )-1 do
      if ((Path[Col][I] = '') and
          (Path[Col][J] <> '')) or
         ((Path[Col][I] <> '') and
          (Path[Col][J] <> '') and
          (Path[Col][I] > Path[Col][J])) then Vymen( I , J );
end;

begin
  if Length( Spojene ) = 0 then exit;
  Sort;
  PrekresliTabulku;
end;

//==============================================================================
//==============================================================================
//
//                             I N T E R F A C E
//
//==============================================================================
//==============================================================================

procedure TFormManager.PridajDodaci( Faktura, Dodaci : string );
var I : integer;
begin
  for I := 0 to Length( Path[0] )-1 do
    if Path[0][I] = Faktura then
      begin
        Path[0][I] := Faktura;
        Path[1][I] := Dodaci;

        Faktura := '';
        break;
      end;

  if Faktura <> '' then
    begin
      PridajPolozku;
      Path[0][Length( Path[0] )-1] := Faktura;
      Path[1][Length( Path[1] )-1] := Dodaci;
    end;

  PrekresliTabulku; 
end;

procedure TFormManager.PridajDodPon( Ponuka, DodPon : string );
var I : integer;
begin
  if Ponuka <> '' then
    for I := 0 to Length( Path[3] )-1 do
      if Path[3][I] = Ponuka then
        begin
          Path[2][I] := DodPon;
          Path[3][I] := Ponuka;
          PrekresliTabulku;
          exit;
        end;

  PridajPolozku;

  Path[2][Length( Path[2] )-1] := DodPon;
  Path[3][Length( Path[3] )-1] := Ponuka;

  PrekresliTabulku;
end;

procedure TFormManager.PridajPonuku( Ponuka : string );
begin
  PridajPolozku;

  Path[3][Length( Path[3] )-1] := Ponuka;

  PrekresliTabulku;
end;

end.
