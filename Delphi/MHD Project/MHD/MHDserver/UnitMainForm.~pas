unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, lgmPanel, Menus, ImgList;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    Server1: TMenuItem;
    Connect1: TMenuItem;
    lgmPanel: TlgmPanel;
    ListViewOnLine: TListView;
    StatusBar: TStatusBar;
    lgmPanelFiles: TlgmPanel;
    TreeView: TTreeView;
    ComboBox: TComboBox;
    Label1: TLabel;
    ButtonNew: TButton;
    ButtonRemove: TButton;
    ButtonEdit: TButton;
    SaveDialog: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Connect1Click(Sender: TObject);
    procedure ButtonNewClick(Sender: TObject);
    procedure ButtonRemoveClick(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
    procedure ComboBoxChange(Sender: TObject);
  private
    { Private declarations }
    FConnected : boolean;
    procedure SetConnected( Value : boolean );

    procedure ListChange( Sender : TObject );
    procedure ListItemChange( Sender : TObject; ClientIndex : integer );
    procedure TreeChange( Sender : TObject );
  public
    { Public declarations }
    property Connected : boolean read FConnected write SetConnected;
  end;

var
  MainForm: TMainForm;

implementation

uses ClassMHDserver, ClassUpdates, Konstanty, UnitFormDate, UnitEdit;

{$R *.DFM}

//==============================================================================
//                                  Constructor
//==============================================================================

procedure TMainForm.FormCreate( Sender: TObject );
begin
  MHDserver := TMHDserver.Create;
  MHDserver.OnListChange := ListChange;
  MHDserver.OnListItemChange := ListItemChange;

  Updates := TUpdates.Create;
  Updates.OnTreeChange := TreeChange;
  Updates.Active := LAST_ACTIVE;
  TreeChange( nil );

  ComboBox.ItemIndex := LAST_ACTIVE;

  FConnected := False;
  Connected := True;
end;

//==============================================================================
//                                  Destructor
//==============================================================================

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Updates.Free;
  MHDserver.Free;
end;

//==============================================================================
//                                   Properties
//==============================================================================

procedure TMainForm.SetConnected( Value : boolean );
begin
  if (FConnected = Value) then exit;

  if (Value = True) and
     (ComboBox.ItemIndex = -1) then
    begin
      MessageDlg( 'You cannot connect without choosing the active update item!' , mtError , [mbOK] , 0 );
      exit;
    end;

  FConnected := Value;

  if FConnected then
    begin
      StatusBar.Panels[0].Text := 'Connected';
      Connect1.Caption := '&Disconnect';
      MHDserver.Active := True;
      ComboBox.Enabled := False;
    end
      else
    begin
      StatusBar.Panels[0].Text := 'Offline';
      Connect1.Caption := '&Connect';
      MHDserver.Active := False;
      ComboBox.Enabled := True;
    end;
end;

//==============================================================================
//                                   Events
//==============================================================================

procedure TMainForm.ListChange( Sender : TObject );
var I : integer;
begin
  ListViewOnLine.Items.Clear;
  for I := 0 to MHDserver.Clients.Count-1 do
    begin
      ListViewOnLine.Items.Add;
      ListItemChange( Sender , I );
    end;
end;

procedure TMainForm.ListItemChange( Sender : TObject; ClientIndex : integer );
var LI : TListItem;
begin
  LI := ListViewOnLine.Items[ClientIndex];
  with LI do
    begin
      Caption := TClient( TMHDServer( Sender ).Clients[ClientIndex] ).ClientInfo.Name;
      SubItems.Clear;
      SubItems.Add( TClient( TMHDServer( Sender ).Clients[ClientIndex] ).ClientInfo.Company );
      SubItems.Add( TClient( TMHDServer( Sender ).Clients[ClientIndex] ).ClientInfo.Serial );
      SubItems.Add( TClient( TMHDServer( Sender ).Clients[ClientIndex] ).ClientInfo.IP );
      SubItems.Add( TClient( TMHDServer( Sender ).Clients[ClientIndex] ).ClientInfo.LastUpdate );
      SubItems.Add( TClient( TMHDServer( Sender ).Clients[ClientIndex] ).ClientInfo.Status );
    end;
end;

procedure TMainForm.TreeChange( Sender : TObject );
var I, J : integer;
    NewTN, RozTN, LisTN, ZasTN : TTreeNode;
    SelObj : TUpdateItem;
begin
  TreeView.Items.Clear;

  SelObj := nil;
  if (ComboBox.ItemIndex <> -1) then
    SelObj := TUpdateItem( ComboBox.Items.Objects[ComboBox.ItemIndex] );

  ComboBox.Clear;
  for I := 0 to Updates.Items.Count-1 do
    begin
      ComboBox.Items.AddObject( TUpdateItem( Updates.Items[I] ).Title , Updates.Items[I] );

      NewTN := TreeView.Items.Add( nil , TUpdateItem( Updates.Items[I] ).Title );
      NewTN.Data := Updates.Items[I];

      RozTN := TreeView.Items.AddChild( NewTN , 'Rozvrhy' );
      LisTN := TreeView.Items.AddChild( NewTN , 'Lístky' );
      ZasTN := TreeView.Items.AddChild( NewTN , 'Zastávky' );

      for J := 0 to TUpdateItem( Updates.Items[I] ).RozvrhyFiles.Count-1 do
        TreeView.Items.AddChild( RozTN , TUpdateItem( Updates.Items[I] ).RozvrhyFiles[J] );

      for J := 0 to Length( TUpdateItem( Updates.Items[I] ).Listky )-1 do
        TreeView.Items.AddChild( LisTN , 'Dåžka : '+IntToStr(TUpdateItem( Updates.Items[I] ).Listky[J].Min)+
                                         ' Normálny : '+IntToStr(TUpdateItem( Updates.Items[I] ).Listky[J].Norm)+' Sk'+
                                         ' Z¾avnený : '+IntToStr(TUpdateItem( Updates.Items[I] ).Listky[J].Zlav)+' Sk' );

      if (TUpdateItem( Updates.Items[I] ).ZastavkyFile <> '') then
        TreeView.Items.AddChild( ZasTN , TUpdateItem( Updates.Items[I] ).ZastavkyFile );
    end;

  ComboBox.ItemIndex := ComboBox.Items.IndexOfObject( SelObj );
end;

//==============================================================================
//                                 Components
//==============================================================================

procedure TMainForm.Connect1Click(Sender: TObject);
begin
  Connected := not Connected;
end;

procedure TMainForm.ButtonNewClick(Sender: TObject);
begin
  if (SaveDialog.Execute) and
     (FormDate.ShowModal = 1) then
    Updates.CreateItem( SaveDialog.FileName , FormDate.Day , FormDate.Month , FormDate.Year );
end;

procedure TMainForm.ButtonRemoveClick(Sender: TObject);
begin
  if (TreeView.Selected = nil) or
     (TreeView.Selected.Level > 0) then exit;

  if (Connected) and
     (ComboBox.ItemIndex <> -1) and
     (TreeView.Selected.Data = ComboBox.Items.Objects[ComboBox.ItemIndex]) then
    begin
      MessageDlg( 'You cannot remove active update item!' , mtError , [mbOK] , 0 );
      exit;
    end;

  if (MessageDlg( 'Do you really want to remove the selected update file?' , mtConfirmation , [mbYes,mbNo] , 0 ) = mrYes) then
    Updates.DeleteItem( TreeView.Selected.Data );
end;

procedure TMainForm.ButtonEditClick(Sender: TObject);
var Parent : TTreeNode;
begin
  if (TreeView.Selected = nil) then exit;

  Parent := TreeView.Selected;
  while (Parent.Level > 0) do
    Parent := Parent.Parent;

  if (Connected) and
     (ComboBox.ItemIndex <> -1) and
     (Parent.Data = ComboBox.Items.Objects[ComboBox.ItemIndex]) then
    begin
      MessageDlg( 'You cannot edit active update item!' , mtError , [mbOK] , 0 );
      exit;
    end;

  FormEdit.Edit( Parent.Data );
end;

procedure TMainForm.ComboBoxChange(Sender: TObject);
begin
  Updates.Active := ComboBox.ItemIndex;
end;

end.
