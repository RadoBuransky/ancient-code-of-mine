unit UnitEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, lgmPanel, ComCtrls, Menus, ClassUpdates;

type
  TFormEdit = class(TForm)
    lgmPanel1: TlgmPanel;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    ListViewRozvrhy: TListView;
    lgmPanel2: TlgmPanel;
    ListViewListky: TListView;
    lgmPanel3: TlgmPanel;
    EditZastavky: TEdit;
    ButtonZastavky: TButton;
    PopupMenuRoz: TPopupMenu;
    PopupMenuList: TPopupMenu;
    RozAddfiles: TMenuItem;
    RozRemovefile: TMenuItem;
    LisAddticket: TMenuItem;
    LisRemoveticket: TMenuItem;
    OpenDialog: TOpenDialog;
    OpenDialogZast: TOpenDialog;
    procedure PopupMenuRozPopup(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure LisAddticketClick(Sender: TObject);
    procedure PopupMenuListPopup(Sender: TObject);
    procedure LisRemoveticketClick(Sender: TObject);
    procedure RozAddfilesClick(Sender: TObject);
    procedure RozRemovefileClick(Sender: TObject);
    procedure ButtonZastavkyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure Edit( Item : TUpdateItem );
  end;

var
  FormEdit: TFormEdit;

implementation

uses Konstanty, UnitAddTicket;

{$R *.DFM}

procedure TFormEdit.Edit( Item : TUpdateItem );

procedure DataToForm;
var I : integer;
    NewLI : TListItem;
begin
  ListViewRozvrhy.Items.Clear;
  for I := 0 to Item.RozvrhyFiles.Count-1 do
    ListViewRozvrhy.Items.Add.Caption := Item.RozvrhyFiles[I];

  ListViewListky.Items.Clear;
  for I := 0 to Length( Item.Listky )-1 do
    begin
      NewLI := ListViewListky.Items.Add;
      NewLI.Caption := IntToStr( Item.Listky[I].Min );
      NewLI.SubItems.Add( IntToStr( Item.Listky[I].Norm ) );
      NewLI.SubItems.Add( IntToStr( Item.Listky[I].Zlav ) );
    end;

  EditZastavky.Text := Item.ZastavkyFile;
end;

procedure FormToData;
var I : integer;
begin
  Item.RozvrhyFiles.Clear;

  for I := 0 to ListViewRozvrhy.Items.Count-1 do
    Item.RozvrhyFiles.Add( ListViewRozvrhy.Items[I].Caption );

  SetLength( Item.Listky , ListViewListky.Items.Count );
  for I := 0 to ListViewListky.Items.Count-1 do
    begin
      Item.Listky[I].Min := StrToInt( ListViewListky.Items[I].Caption );
      Item.Listky[I].Norm := StrToInt( ListViewListky.Items[I].SubItems[0] );
      Item.Listky[I].Zlav := StrToInt( ListViewListky.Items[I].SubItems[1] );
    end;

  Item.ZastavkyFile := EditZastavky.Text;
end;

begin
  DataToForm;
  if (ShowModal = 1) then
    begin
      FormToData;
      Item.Save;
      if (Assigned( Updates.OnTreeChange )) then Updates.OnTreeChange( Updates );
    end;
end;

procedure TFormEdit.PopupMenuRozPopup(Sender: TObject);
begin
  if (ListViewRozvrhy.Selected = nil) then RozRemovefile.Enabled := False
                                      else RozRemovefile.Enabled := True;
end;

procedure TFormEdit.ButtonCancelClick(Sender: TObject);
begin
  ModalResult := -1;
end;

procedure TFormEdit.ButtonOKClick(Sender: TObject);
begin
  ModalResult := 1;
end;

procedure TFormEdit.LisAddticketClick(Sender: TObject);
begin
  if (FormAddTicket.ShowModal = 1) then
    with ListViewListky.Items.Add do
      begin
        Caption := IntToStr( FormAddTicket.NewTicket.Min );
        SubItems.Add( IntToStr( FormAddTicket.NewTicket.Norm ) );
        SubItems.Add( IntToStr( FormAddTicket.NewTicket.Zlav ) );
      end;
end;

procedure TFormEdit.PopupMenuListPopup(Sender: TObject);
begin
  if (ListViewListky.Selected = nil) then LisRemoveticket.Enabled := False
                                     else LisRemoveticket.Enabled := True;
end;

procedure TFormEdit.LisRemoveticketClick(Sender: TObject);
begin
  if (MessageDlg( 'Do you really want to remove the selected ticket?' , mtConfirmation , [mbYes,mbNo] , 0 ) = mrYes) then
    ListViewListky.Items.Delete( ListViewListky.Selected.Index );
end;

procedure TFormEdit.RozAddfilesClick(Sender: TObject);
var I : integer;
begin
  if (OpenDialog.Execute) then
    for I := 0 to OpenDialog.Files.Count-1 do
      ListViewRozvrhy.Items.Add.Caption := OpenDialog.Files[I];
end;

procedure TFormEdit.RozRemovefileClick(Sender: TObject);
begin
  if (MessageDlg( 'Do you really want to remove the selected files?' , mtConfirmation , [mbYes,mbNo] , 0 ) <> mrYes) then exit;

  while (ListViewRozvrhy.Selected <> nil) do
    ListViewRozvrhy.Items.Delete( ListViewRozvrhy.Selected.Index );
end;

procedure TFormEdit.ButtonZastavkyClick(Sender: TObject);
begin
  if (OpenDialogZast.Execute) then
    EditZastavky.Text := OpenDialogZast.FileName;
end;

end.
