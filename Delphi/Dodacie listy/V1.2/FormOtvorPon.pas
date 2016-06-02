unit FormOtvorPon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TFormOtvoritPon = class(TForm)
    LabelAdr: TLabel;
    ButtonAdr: TButton;
    ButtonOK: TButton;
    ButtonZrusit: TButton;
    ListView: TListView;
    procedure FormCreate(Sender: TObject);
    procedure ButtonAdrClick(Sender: TObject);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonZrusitClick(Sender: TObject);
    procedure ListViewDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateList( Path : string );
  public
    { Public declarations }
    FileName : string;
  end;

var
  FormOtvoritPon: TFormOtvoritPon;

implementation

uses Ini, FormAdresar;

{$R *.DFM}

procedure TFormOtvoritPon.FormCreate(Sender: TObject);
begin
  LabelAdr.Caption := ponuky_dir;
  UpdateList( ponuky_dir );
  FileName := '';
end;

procedure TFormOtvoritPon.ButtonAdrClick(Sender: TObject);
begin
  if FormAdr.ShowModal = 1 then
    begin
      LabelAdr.Caption := FormAdr.Path+'\';
      UpdateList( FormAdr.Path+'\' );
    end;
end;

procedure TFormOtvoritPon.UpdateList( Path : string );
var I, J, N : integer;
    SR : TSearchRec;
    NewListItem : TListItem;
    Adr, S, Dodaci, Datum : string;
begin
  ListView.Items.Clear;

  if FindFirst( Path+'*.pnk' , faAnyFile , SR ) <> 0 then exit;
  repeat
    NewListItem := ListView.Items.Add;
    NewListItem.Caption := SR.Name;

    AssignFile( Input , Path+SR.Name );
    Reset( Input );

    Readln( Dodaci );

    Readln( Datum );

    Readln( N );
    for I := 1 to N do
      for J := 1 to 5 do
        Readln;
    Readln;
    Readln;

    Adr := '';
    while not EoF( Input ) do
      begin
        Readln( S );
        Adr := Adr+S+', ';
      end;
    Delete( Adr , Length( Adr )-1 , 2 );

    NewListItem.SubItems.Add( Adr );

    NewListItem.SubItems.Add( Datum );
    NewListItem.SubItems.Add( Dodaci );

    CloseFile( Input );

  until (FindNext( SR ) <> 0);
  FindClose( SR );
end;

procedure TFormOtvoritPon.ListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    begin
      ButtonOK.Enabled := True;
      FileName := LabelAdr.Caption+Item.Caption;
    end
      else
    begin
      ButtonOK.Enabled := False;
      FileName := '';
    end;
end;

procedure TFormOtvoritPon.ButtonOKClick(Sender: TObject);
begin
  ModalResult := 1;
end;

procedure TFormOtvoritPon.ButtonZrusitClick(Sender: TObject);
begin
  ModalResult := -1;
end;

procedure TFormOtvoritPon.ListViewDblClick(Sender: TObject);
begin
  if ListView.Selected <> nil then ModalResult := 1;
end;

procedure TFormOtvoritPon.FormShow(Sender: TObject);
begin
  LabelAdr.Caption := ponuky_dir;
  UpdateList( ponuky_dir );
end;

end.
