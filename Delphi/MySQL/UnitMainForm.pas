unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, MySQLDB, ComCtrls, Menus, Grids, UnitCenniky, ToolWin, ImgList,
  StdCtrls;

type
  TFormMain = class(TForm)
    MySQL: TMySQLDataset;
    PageControl: TPageControl;
    ToolBar: TToolBar;
    EditAddTable: TEdit;
    ToolButtonAddTable: TToolButton;
    ImageList: TImageList;
    ToolButton1: TToolButton;
    ComboBoxTables: TComboBox;
    ToolButtonDeleteTable: TToolButton;
    ToolButton2: TToolButton;
    ToolButtonA: TToolButton;
    ToolButton4: TToolButton;
    MainMenu: TMainMenu;
    Aktualizuj: TMenuItem;
    Koniec: TMenuItem;
    ToolButtonRp: TToolButton;
    ToolButton6: TToolButton;
    ToolButtonRm: TToolButton;
    Exportuj: TMenuItem;
    SaveDialog: TSaveDialog;
    procedure KoniecClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AktualizujClick(Sender: TObject);
    procedure ToolButtonAddTableClick(Sender: TObject);
    procedure ToolButtonDeleteTableClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure ComboBoxTablesChange(Sender: TObject);
    procedure ToolButtonKClick(Sender: TObject);
    procedure ToolButtonAClick(Sender: TObject);
    procedure ToolButtonRpClick(Sender: TObject);
    procedure ToolButtonRmClick(Sender: TObject);
    procedure EditAddTableKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButtonSClick(Sender: TObject);
    procedure ExportujClick(Sender: TObject);
  private
    { Private declarations }
    Cenniky   : TCenniky;

    procedure   CennikyToForm;

    procedure   DeleteAllTables;
    procedure   DeleteTable( Index : integer );
    procedure   AddTable( Text : string );
    procedure   SetEditText( Sender: TObject; ACol, ARow: Longint; const Value: String );
    procedure   SGKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses UnitCennik, Clipbrd;

{$R *.DFM}

procedure TFormMain.KoniecClick(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Cenniky := TCenniky.Create( ExtractFilePath( Application.EXEName ) + 'Data' );
  CennikyToForm;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  Cenniky.Destroy;
end;

procedure TFormMain.AktualizujClick(Sender: TObject);
begin
  Cenniky.Update;
end;

procedure TFormMain.ToolButtonAddTableClick(Sender: TObject);
begin
  if (EditAddTable.Text = '') then
    begin
      MessageDlg( 'Nezadali ste žiaden názov novej tabu¾ky!' , mtError , [mbOK] , 0 );
      EditAddTable.SetFocus;
      exit;
    end;

  AddTable( EditAddTable.Text );
  Cenniky.AddTable( EditAddTable.Text );
end;

procedure TFormMain.ToolButtonDeleteTableClick(Sender: TObject);
begin
  if (ComboBoxTables.ItemIndex = -1) then
    exit;

  if (MessageDlg( 'Naozaj chcete zmaza vybranú tabu¾ku?' , mtWarning , [mbYes,mbNo] , 0 ) = mrYes) then
    begin
      Cenniky.DeleteTable( ComboBoxTables.ItemIndex );
      DeleteTable( ComboBoxTables.ItemIndex );
    end;
end;

procedure TFormMain.DeleteAllTables;
var I : integer;
begin
  for I := 0 to PageControl.PageCount-1 do
    DeleteTable( I );
end;

procedure TFormMain.DeleteTable( Index : integer );
begin
  ComboBoxTables.Items.Delete( Index );
  PageControl.Pages[Index].Destroy;

  ComboBoxTables.ItemIndex := 0
end;

procedure TFormMain.AddTable( Text : string );
var TS : TTabSheet;
    SG : TStringGrid;
    I : integer;
begin
  TS := TTabSheet.Create( Self );
  with TS do
    begin
      Caption     := Text;
      PageControl := Self.PageControl;
    end;

  SG := TStringGrid.Create( TS );
  with SG do
    begin
      Parent  := TS;

      Left    := 10;
      Top     := 10;
      Width   := Parent.Width - 20;
      Height  := Parent.Height - 20;

      Anchors := [akLeft,akTop,akRight,akBottom];

      DefaultRowHeight := 20;

      RowCount  := 2;
      ColCount  := FIELDS_MAX;
      FixedRows := 1;
      FixedCols := 0;

      for I := 0 to FIELDS_MAX-1 do
        ColWidths[I] := (Width-10) div FIELDS_MAX;

      Cells[0,0] := 'Popis tovaru';
      Cells[1,0] := 'Cena';
      Cells[2,0] := 'Záruèná doba';
      Cells[3,0] := 'Poradie';

      Options := [goFixedHorzLine,goFixedVertLine,goVertLine,goHorzLine,goColSizing,goEditing,goThumbTracking];

      OnSetEditText := SetEditText;
      OnKeyDown     := SGKeyDown;

      Visible := true;
    end;

  TS.Tag := Integer( SG );

  // Add item to combo box
  ComboBoxTables.Items.Add( Text );
  if (ComboBoxTables.ItemIndex = -1) then
    ComboBoxTables.ItemIndex := 0;
end;

procedure TFormMain.CennikyToForm;
var I, J, K : integer;
    SG : TStringGrid;
begin
  DeleteAllTables;

  for I := 0 to Length( Cenniky.Data )-1 do
    begin
      AddTable( Cenniky.Data[I].FriendlyName );

      SG := TStringGrid( Pointer( PageControl.Pages[I].Tag ) );

      if (Length( Cenniky.Data[I].Data ) > 0) then
        SG.RowCount := Length( Cenniky.Data[I].Data )+1
      else
        SG.RowCount := 2;

      for J := 0 to Length( Cenniky.Data[I].Data )-1 do
        for K := 0 to FIELDS_MAX-1 do
          SG.Cells[K,J+1] := Cenniky.Data[I].Data[J,K];
    end;
end;

procedure TFormMain.SetEditText( Sender: TObject; ACol, ARow: Longint; const Value: String );
var TS : TTabSheet;
    SG : TStringGrid;
begin
  SG := Sender as TStringGrid;
  TS := SG.Parent as TTabSheet;

  if (TS.TabIndex = -1) then
    exit;

  Cenniky.Data[TS.TabIndex].EditCell( ACol , ARow-1 , Value );
end;

procedure TFormMain.SGKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
var SG : TStringGrid;
    TS : TTabSheet;
    CB : TClipboard;
    Text : string;
    Rows, Cols : integer;
    I, J, K : integer;
    Cell : string;
begin
  // Test if CTRL+C has been pressed
  if ((ssCtrl in Shift) and
      (Key = Ord( 'V' ))) then
    begin
      SG := Sender as TStringGrid;
      TS := SG.Parent as TTabSheet;
      CB := Clipboard;

      // Get pasted text from clipboard
      Text := CB.AsText;

      // Get count of rows and columns
      Rows := 0;
      Cols := 0;
      for I := 1 to Length( Text ) do
        case (Text[I]) of
          #9   : if (Rows = 0) then
                   Inc( Cols );
          #10  :  if ((I > 1) and
                      (Text[I-1] = #13)) then
                    begin
                      if (Rows = 0) then
                        Inc( Cols );

                      Inc( Rows );
                    end;
        end;

      if (SG.ColCount - SG.Col < Cols) then
        exit;

      SG.EditorMode := false;

      if (Length( Cenniky.Data[TS.TabIndex].Data ) - (SG.Row-1) < Rows) then
        begin
          J := Rows - (SG.RowCount - SG.Row);
          SG.RowCount := SG.RowCount + J;

          if (Length( Cenniky.Data[TS.TabIndex].Data ) = 0) then
            Cenniky.Data[TS.TabIndex].AddRow;

          for I := 1 to J do
            Cenniky.Data[TS.TabIndex].AddRow;
        end;

      J := 0;
      K := 0;
      Cell := '';
      for I := 1 to Length( Text ) do
        case (Text[I]) of
          #9   : begin
                   Cenniky.Data[TS.TabIndex].EditCell( SG.Col+J , SG.Row+K-1 , Cell );
                   SG.Cells[SG.Col+J,SG.Row+K] := Cell;
                   Cell := '';
                   Inc( J );
                 end;
          #10  :  if ((I > 1) and
                      (Text[I-1] = #13)) then
                    begin
                      Cenniky.Data[TS.TabIndex].EditCell( SG.Col+J , SG.Row+K-1 , Cell );
                      SG.Cells[SG.Col+J,SG.Row+K] := Cell;
                      Cell := '';
                      J := 0;
                      Inc( K );
                    end;
          else
            if (Text[I] <> #13) then
              Cell := Cell + Text[I];
        end;
    end;
end;

procedure TFormMain.PageControlChange(Sender: TObject);
begin
  ComboBoxTables.ItemIndex := PageControl.ActivePageIndex;
  EditAddTable.Text := ComboBoxTables.Items[ComboBoxTables.ItemIndex];
end;

procedure TFormMain.ComboBoxTablesChange(Sender: TObject);
begin
  PageControl.ActivePageIndex := ComboBoxTables.ItemIndex;
  EditAddTable.Text := ComboBoxTables.Items[ComboBoxTables.ItemIndex];
end;

procedure TFormMain.ToolButtonKClick(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.ToolButtonAClick(Sender: TObject);
begin
  Cenniky.Update;
end;

procedure TFormMain.ToolButtonRpClick(Sender: TObject);
var SG : TStringGrid;
    I : integer;
begin
  if (ComboBoxTables.ItemIndex = -1) then
    exit;

  SG := TStringGrid( Pointer( PageControl.Pages[ComboBoxTables.ItemIndex].Tag ) );
  SG.RowCount := SG.RowCount + 1;
  for I := 0 to FIELDS_MAX-1 do
    SG.Cells[I,SG.RowCount-1] := '';

  Cenniky.Data[ComboBoxTables.ItemIndex].AddRow;
end;

procedure TFormMain.ToolButtonRmClick(Sender: TObject);
var SG : TStringGrid;
    I, J : integer;
begin
  if (ComboBoxTables.ItemIndex = -1) then
    exit;

  SG := TStringGrid( Pointer( PageControl.Pages[ComboBoxTables.ItemIndex].Tag ) );
  SG.EditorMode := false;
  if (SG.RowCount > 2) then
    begin
      for I := SG.Row to SG.RowCount-2 do
        for J := 0 to FIELDS_MAX-1 do
          SG.Cells[J,I] := SG.Cells[J,I+1];

      if (SG.Row > -1) then
        Cenniky.Data[ComboBoxTables.ItemIndex].DeleteRow( SG.Row-1 );

      SG.RowCount := SG.RowCount-1;
    end
  else
    begin
      for I := 0 to FIELDS_MAX-1 do
        SG.Cells[I,1] := '';

      if (Length( Cenniky.Data[ComboBoxTables.ItemIndex].Data ) = 1) then
        Cenniky.Data[ComboBoxTables.ItemIndex].DeleteRow( 0 );
    end;
end;

procedure TFormMain.EditAddTableKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key = VK_RETURN) and
      (PageControl.ActivePageIndex <> -1)) then
    begin
      PageControl.ActivePage.Caption := EditAddTable.Text;
      ComboBoxTables.Items[PageControl.ActivePageIndex] := EditAddTable.Text;
      ComboBoxTables.ItemIndex := PageControl.ActivePageIndex;

      Cenniky.Data[PageControl.ActivePageIndex].Rename( EditAddTable.Text );
    end;
end;

procedure TFormMain.ToolButtonSClick(Sender: TObject);
begin
  Cenniky.DeleteOld;
  Cenniky.Update;
end;

procedure TFormMain.ExportujClick(Sender: TObject);
begin
  if (SaveDialog.Execute) then
    Cenniky.ExportToFile( SaveDialog.FileName );
end;

end.
