unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, ExtCtrls;

type
  TPage = (pDodaci);

  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    SuborMenu: TMenuItem;
    NovySubor: TMenuItem;
    OtvoritSubor: TMenuItem;
    UlozitSubor: TMenuItem;
    UlozitAkoSubor: TMenuItem;
    Tlacit: TMenuItem;
    Skoncit: TMenuItem;
    NastrojeMenu: TMenuItem;
    MoznostiNastroje: TMenuItem;
    StatusBar: TStatusBar;
    Notebook: TNotebook;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    EditPolNaz: TEdit;
    EditPolJed: TEdit;
    EditPolMno: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EditPolZar: TEdit;
    GroupBox2: TGroupBox;
    ListView: TListView;
    Label1: TLabel;
    MemoPol: TMemo;
    GroupBox3: TGroupBox;
    EditKtoVys: TEdit;
    EditDatVys: TEdit;
    EditKtoSch: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    EditDatSch: TEdit;
    EditKtoPri: TEdit;
    EditDatPri: TEdit;
    GroupBox4: TGroupBox;
    Label12: TLabel;
    MemoOdb: TMemo;
    EditOdbICO: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    ListBoxOdb: TListBox;
    ButtonOdb: TButton;
    CistyDodaciList: TMenuItem;
    DodaciListKFakture: TMenuItem;
    ButtonZozPri: TButton;
    ButtonZozZma: TButton;
    ButtonZozZmaVse: TButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    procedure SkoncitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CistyDodaciListClick(Sender: TObject);
    procedure DodaciListKFaktureClick(Sender: TObject);
    procedure ButtonOdbClick(Sender: TObject);
    procedure ListBoxOdbDblClick(Sender: TObject);
    procedure ListBoxOdbClick(Sender: TObject);
    procedure ButtonZozPriClick(Sender: TObject);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListViewInsert(Sender: TObject; Item: TListItem);
    procedure ListViewDeletion(Sender: TObject; Item: TListItem);
    procedure ButtonZozZmaClick(Sender: TObject);
    procedure ButtonZozZmaVseClick(Sender: TObject);
    procedure UlozitSuborClick(Sender: TObject);
    procedure ListViewEditing(Sender: TObject; Item: TListItem;
      var AllowEdit: Boolean);
    procedure EditKtoVysChange(Sender: TObject);
    procedure EditDatVysChange(Sender: TObject);
    procedure EditKtoSchChange(Sender: TObject);
    procedure EditDatSchChange(Sender: TObject);
    procedure EditKtoPriChange(Sender: TObject);
    procedure EditDatPriChange(Sender: TObject);
    procedure EditPolNazChange(Sender: TObject);
    procedure EditPolJedChange(Sender: TObject);
    procedure EditPolMnoChange(Sender: TObject);
    procedure EditPolZarChange(Sender: TObject);
    procedure MemoPolChange(Sender: TObject);
    procedure MemoOdbChange(Sender: TObject);
    procedure EditOdbICOChange(Sender: TObject);
    procedure ListViewEdited(Sender: TObject; Item: TListItem;
      var S: String);
    procedure UlozitAkoSuborClick(Sender: TObject);
    procedure OtvoritSuborClick(Sender: TObject);
  private
    { Private declarations }
    FActivePage        : TPage;
    FSaved             : boolean;
    FTitle             : string;

    // Properties
    procedure          SetActivePage( NewActivePage : TPage );
    procedure          SetSaved( New : boolean );
    procedure          SetTitle( FileName : string );

    // Spolocne
    procedure          ClearActivePage;
    procedure          AdresyToListBox( ListBox : TListBox );

    // Dodaci
    procedure          EnableZvolPol( Enable : boolean );
    procedure          ClearZvolPol;
    procedure          DodaciToZvolPol( Polozka : pointer );
    procedure          ZvolPolToDodaci( Polozka : pointer );

    procedure          DodaciToForm;
    procedure          FormToDodaci;
  public
    { Public declarations }

    property ActivePage : TPage read FActivePage write SetActivePage;
    property Saved : boolean read FSaved write SetSaved;
    property Title : string read FTitle write SetTitle;
  end;

var
  MainForm: TMainForm;

implementation

uses ClassAdresy, ClassFaktury, ClassDodaci, ClassGlobals;

{$R *.DFM}

// Create
procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Vytvor cisty dodaci list
  CistyDodaciListClick( nil );

  inherited;
end;

// Destroy
procedure TMainForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

//==============================================================================
//  P R I V A T E
//==============================================================================

//==============================================================================
//  P r o p e r t i e s
//==============================================================================

procedure TMainForm.SetActivePage( NewActivePage : TPage );
begin
  FActivePage := NewActivePage;

  // Clear it
  ClearActivePage;

  // Set active and do some initializations
  case (FActivePage) of
    pDodaci : begin
                // Copy data to form
                DodaciToForm;

                // Enable / disable controls
                ButtonZozZma.Enabled    := false;
                ButtonZozZmaVse.Enabled := false;
                ButtonOdb.Enabled       := false;

                // Disable zvolena polozka
                EnableZvolPol( false );

                // Add addresses to list box
                AdresyToListBox( ListBoxOdb );

                // Set active page of notebook
                Notebook.ActivePage := 'Dodaci';

                // Set window title
                Title := Dodaci.FileName;
              end;
  end;
end;

procedure TMainForm.SetSaved( New : boolean );
begin
  FSaved := New;

  if (FSaved) then
    StatusBar.Panels[0].Text := 'Ulo�en�'
  else
    StatusBar.Panels[0].Text := 'Neulo�en�';

  // Update window title
  Title := Title;
end;

//==============================================================================
//  S p o l o c n e
//==============================================================================

procedure TMainForm.ClearActivePage();
begin
  case (ActivePage) of
    pDodaci : begin
                ListView.Items.Clear;
                EditPolNaz.Clear;
                EditPolJed.Clear;
                EditPolMno.Clear;
                EditPolZar.Clear;
                MemoPol.Clear;
                EditKtoVys.Clear;
                EditDatVys.Clear;
                EditKtoSch.Clear;
                EditDatSch.Clear;
                EditKtoPri.Clear;
                EditDatPri.Clear;
                MemoOdb.Clear;
                EditOdbICO.Clear;
                ListBoxOdb.Clear;
              end;
  end;
end;

procedure TMainForm.AdresyToListBox( ListBox : TListBox );
var I, J, Count : integer;
    S : string;
begin
  // Clear it
  ListBox.Clear;

  Count := Adresy.Count;
  for I := 0 to Count-1 do
    begin
      S := Adresy[I,0];
      for J := 1 to Adresy.AdresyCount[I]-1 do
        S := S+', '+Adresy[I,J];

      ListBox.Items.AddObject( S , TObject( I ) );
    end;
end;

procedure TMainForm.SetTitle( FileName : string );
var Typ : string;
begin
  FTitle := FileName;

  case (ActivePage) of
    pDodaci : Typ := 'Dodac� list';
    else
      Typ := '';
  end;

  Text := 'Pc Prompt - '+Typ+' ('+FileName;

  if (Saved) then
    Text := Text + ')'
  else
    Text := Text + '*)';
end;

//==============================================================================
//  D o d a c i e
//==============================================================================

procedure TMainForm.EnableZvolPol( Enable : boolean );
begin
  if (Enable) then
    GroupBox1.Font.Color := clBlack
  else
    GroupBox1.Font.Color := clGrayText;

  EditPolNaz.Enabled := Enable;
  EditPolJed.Enabled := Enable;
  EditPolMno.Enabled := Enable;
  EditPolZar.Enabled := Enable;
  MemoPol.Enabled    := Enable;
  Label1.Enabled     := Enable;
  Label2.Enabled     := Enable;
  Label3.Enabled     := Enable;
  Label4.Enabled     := Enable;
  Label5.Enabled     := Enable;
end;

procedure TMainForm.ClearZvolPol;
begin
  EditPolNaz.Clear;
  EditPolJed.Clear;
  EditPolMno.Clear;
  EditPolZar.Clear;
  MemoPol.Clear;
end;

procedure TMainForm.DodaciToZvolPol( Polozka : pointer );
var I : integer;
begin
  EditPolNaz.Text := Dodaci.Polozky[Polozka].Nazov;
  EditPolJed.Text := Dodaci.Polozky[Polozka].Jednotka;
  EditPolMno.Text := Dodaci.Polozky[Polozka].Mnozstvo;
  EditPolZar.Text := Dodaci.Polozky[Polozka].ZarDoba;

  MemoPol.Clear;
  for I := 0 to Length( Dodaci.Polozky[Polozka].SerCisla )-1 do
    MemoPol.Lines.Add( Dodaci.Polozky[Polozka].SerCisla[I] );
end;

procedure TMainForm.ZvolPolToDodaci( Polozka : pointer );
var I : integer;
    Pol : TDodaciPol;
begin
  Pol.Nazov    := EditPolNaz.Text;
  Pol.Jednotka := EditPolJed.Text;
  Pol.Mnozstvo := EditPolMno.Text;
  Pol.ZarDoba  := EditPolZar.Text;

  SetLength( Pol.SerCisla , MemoPol.Lines.Count );
  for I := 0 to MemoPol.Lines.Count-1 do
    Pol.SerCisla[I] := MemoPol.Lines[I];

  Dodaci.Polozky[Polozka] := Pol;
end;

procedure TMainForm.DodaciToForm;
var I, Count : integer;
    LI       : TListItem;
begin
  // Polozky
  Count := Dodaci.PolozkyCount;
  for I := 0 to Count-1 do
    begin
      LI         := ListView.Items.Add;
      LI.Caption := Dodaci.Polozky[Dodaci.GetPolozka( I )].Nazov;
      LI.Data    := TObject( I );
    end;

  // Ukony
  EditKtoVys.Text := Dodaci.KtoVys;
  EditDatVys.Text := Dodaci.DatVys;
  EditKtoPri.Text := Dodaci.KtoPri;
  EditDatPri.Text := Dodaci.DatPri;
  EditKtoSch.Text := Dodaci.KtoSch;
  EditDatSch.Text := Dodaci.DatSch;

  // Odberatel
  Count := Dodaci.OdberatelCount;
  for I := 0 to Count-1 do
    MemoOdb.Lines.Add( Dodaci.Odberatel[I] );

  // ICO
  EditOdbICO.Text := Dodaci.ICO;
end;

procedure TMainForm.FormToDodaci;
var I : integer;
begin
  // Polozky
  if (ListView.Selected <> nil) then
    ZvolPolToDodaci( ListView.Selected.Data );

  // Ukony
  Dodaci.KtoVys := EditKtoVys.Text;
  Dodaci.DatVys := EditDatVys.Text;
  Dodaci.KtoPri := EditKtoPri.Text;
  Dodaci.DatPri := EditDatPri.Text;
  Dodaci.KtoSch := EditKtoSch.Text;
  Dodaci.DatSch := EditDatSch.Text;

  // Odberatel
  Dodaci.OdberatelCount := MemoOdb.Lines.Count;
  for I := 0 to MemoOdb.Lines.Count-1 do
    Dodaci.Odberatel[I] := MemoOdb.Lines[I];
end;

//==============================================================================
//  Menu
//==============================================================================

procedure TMainForm.SkoncitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.CistyDodaciListClick(Sender: TObject);
var Datum : string;
begin
  // Create empty dodaci
  Dodaci.New;

  // Set active page
  ActivePage := pDodaci;

  // Actual document isn't saved
  Saved := false;

  // Initialize some controls
  DateTimeToString( Datum , 'd.m.yyyy' , Date );

  EditDatVys.Text := Datum;
  EditDatPri.Text := Datum;
  EditDatSch.Text := Datum;
end;

procedure TMainForm.DodaciListKFaktureClick(Sender: TObject);
begin
  // Set active page
  ActivePage := pDodaci;
end;

procedure TMainForm.UlozitSuborClick(Sender: TObject);
begin
  // Save document
  case (ActivePage) of
    pDodaci : begin
                // Copy data from form
                FormToDodaci;

                // Save data do the file
                if (not Dodaci.Save( Dodaci.FileName )) then
                begin
                  MessageDlg( 'S�bor sa ned� ulo�i�!' , mtError , [mbOK] , 0 );
                  exit;
                end;
              end;
  end;

  // Set panel state
  Saved := true;
end;

procedure TMainForm.UlozitAkoSuborClick(Sender: TObject);
var Dir, Name, Ext : string;
begin
  // Save document
  case (ActivePage) of
    pDodaci : begin
                SaveDialog.DefaultExt := Globals.DodacieExt;
                SaveDialog.Filter     := 'Dodac� list|*.'+Globals.DodacieExt;
                SaveDialog.InitialDir := Globals.DodacieDir;
                SaveDialog.Title      := 'Ulo�i� ako';
                if (SaveDialog.Execute) then
                begin
                  Globals.ParseFileName( SaveDialog.FileName , Dir , Name , Ext );

                  Globals.DodacieDir := Dir;

                  // Copy data from form
                  FormToDodaci;

                  // Save data do the file
                  if (not Dodaci.Save( Dir+'\'+Name+'.'+Ext )) then
                  begin
                    MessageDlg( 'S�bor sa ned� ulo�i�!' , mtError , [mbOK] , 0 );
                    exit;
                  end;

                  // Set window title
                  Title := Dodaci.FileName;

                  // Set panel state
                  Saved := true;
                end;
              end;
  end;

  // Set panel state
  Saved := true;
end;

procedure TMainForm.OtvoritSuborClick(Sender: TObject);
var Result : word;
    Dir, Name, Ext : string;
begin
  OpenDialog.Filter     := 'Dodac� list|*.'+Globals.DodacieExt;
  OpenDialog.InitialDir := Globals.LastOpened;

  if (OpenDialog.Execute) then
  begin
    if (not Saved) then
    begin
      Result := MessageDlg( 'Dokument nie je ulo�en�! Chcete ho ulo�i�?' , mtError , [mbYES,mbNO,mbCancel] , 0 );

      if (Result = mrCancel) then
        exit
      else
        if (Result = mrYes) then
          UlozitSuborClick( Sender );
    end;

    Globals.ParseFileName( OpenDialog.FileName , Dir , Name , Ext );

    // Save last opened file
    Globals.LastOpened := Dir;

    // Opened file is dodaci
    if (Ext = Globals.DodacieExt) then
    begin
      Globals.DodacieDir := Dir;

      // Subir sa neda otvorit
      if (not Dodaci.Open( OpenDialog.FileName )) then
      begin
        MessageDlg( 'S�bor sa ned� otvori�!' , mtError , [mbOK] , 0 );
        exit;
      end;

      // Set active page
      ActivePage := pDodaci;

      // Copy data to form
      DodaciToForm;

      // Set window title
      Title := Dodaci.FileName;

      // Set panel state
      Saved := true;
    end;
  end;
end;

//==============================================================================
//  Dodaci controls
//==============================================================================

// ButtonOdb OnClick
procedure TMainForm.ButtonOdbClick(Sender: TObject);
var I, Index : integer;
begin
  // Is some address selected?
  if (ListBoxOdb.ItemIndex = -1) then
    exit;

  // Clear memo
  MemoOdb.Clear;

  // Get index of address
  Index := Integer( ListBoxOdb.Items.Objects[ListBoxOdb.ItemIndex] );

  // Copy strings to the memo
  for I := 0 to 3 do
    MemoOdb.Lines.Add( Adresy[Index,I] );

  // Set saved state
  Saved := false;
end;

// ListBoxOdb OnDblClick
procedure TMainForm.ListBoxOdbDblClick(Sender: TObject);
begin
  // Do the same as if < < < button was pressed
  ButtonOdbClick( Sender );
end;

// ListBoxOdb OnClick
procedure TMainForm.ListBoxOdbClick(Sender: TObject);
begin
  ButtonOdb.Enabled := true;
end;

// ButtonZozPri OnClick
procedure TMainForm.ButtonZozPriClick(Sender: TObject);
var Item : TListItem;
begin
  Item := ListView.Items.Add;
  Item.Data := TObject( Dodaci.AddPolozka );
  Item.EditCaption;
end;

// ListView OnSelectItem
procedure TMainForm.ListViewSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var S : boolean;
begin
  S := Saved;

  // Save data
  if (Selected) then
    DodaciToZvolPol( Item.Data )
  else
    ZvolPolToDodaci( Item.Data );

  ButtonZozZma.Enabled := Selected;

  if (not Selected) then
    ClearZvolPol;
  EnableZvolPol( Selected );

  Saved := S;
end;

// ListView OnInsert
procedure TMainForm.ListViewInsert(Sender: TObject; Item: TListItem);
begin
  if (ListView.Items.Count = 0) then
    ButtonZozZmaVse.Enabled := false
  else
    ButtonZozZmaVse.Enabled := true;

  // Set saved state
  Saved := false;
end;

// ListView OnDeletion
procedure TMainForm.ListViewDeletion(Sender: TObject; Item: TListItem);
begin
  if (ListView.Items.Count = 1) then
    ButtonZozZmaVse.Enabled := false
  else
    ButtonZozZmaVse.Enabled := true;

  // Set saved state
  Saved := false;
end;

// ButtonZozZma OnClick
procedure TMainForm.ButtonZozZmaClick(Sender: TObject);
begin
  if (ListView.Selected = nil) then
    exit;

  // Delete item
  Dodaci.DeletePolozka( ListView.Selected.Data );

  ListView.Selected.Delete;
end;

// ButtonZozZmaVse OnClick
procedure TMainForm.ButtonZozZmaVseClick(Sender: TObject);
begin
  // Delete all items
  Dodaci.DeleteAllPolozky;

  ListView.Items.Clear;
  ButtonZozZmaVse.Enabled := false;

  // Set saved state
  Saved := false;
end;

procedure TMainForm.ListViewEditing(Sender: TObject; Item: TListItem;
  var AllowEdit: Boolean);
begin
  // Set saved state
  Saved := false;
end;

procedure TMainForm.EditKtoVysChange(Sender: TObject);
begin
  // Set saved state
  Saved := false;
end;

procedure TMainForm.EditDatVysChange(Sender: TObject);
begin
  // Set saved state
  Saved := false;
end;

procedure TMainForm.EditKtoSchChange(Sender: TObject);
begin
  // Set saved state
  Saved := false;
end;

procedure TMainForm.EditDatSchChange(Sender: TObject);
begin
  // Set saved state
  Saved := false;
end;

procedure TMainForm.EditKtoPriChange(Sender: TObject);
begin
  // Set saved state
  Saved := false;
end;

procedure TMainForm.EditDatPriChange(Sender: TObject);
begin
  // Set saved state
  Saved := false;
end;

procedure TMainForm.EditPolNazChange(Sender: TObject);
begin
  // Set list view item's caption
  if (ListView.Selected <> nil) then
    ListView.Selected.Caption := EditPolNaz.Text;

  // Set saved state
  Saved := false;
end;

procedure TMainForm.EditPolJedChange(Sender: TObject);
begin
  // Set saved state
  Saved := false;
end;

procedure TMainForm.EditPolMnoChange(Sender: TObject);
begin
  // Set saved state
  Saved := false;
end;

procedure TMainForm.EditPolZarChange(Sender: TObject);
begin
  // Set saved state
  Saved := false;
end;

procedure TMainForm.MemoPolChange(Sender: TObject);
begin
  // Set saved state
  Saved := false;
end;

procedure TMainForm.MemoOdbChange(Sender: TObject);
begin
  // Set saved state
  Saved := false;
end;

procedure TMainForm.EditOdbICOChange(Sender: TObject);
begin
  // Set saved state
  Saved := false;
end;

procedure TMainForm.ListViewEdited(Sender: TObject; Item: TListItem;
  var S: String);
begin
  // Copy data to edit
  EditPolNaz.Text := S;
end;

end.
