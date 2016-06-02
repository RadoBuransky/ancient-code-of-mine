unit DialogDodaciKFakture;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TDodaciKFakture = class(TForm)
    ComboBox: TComboBox;
    ButtonOK: TButton;
    ButtonZrusit: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ListView: TListView;
    ButtonAdr: TButton;
    RadioButton3: TRadioButton;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonZrusitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure ButtonAdrClick(Sender: TObject);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListViewDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateList( Path : string );
  public
    { Public declarations }
    Path : string;
    FileName : string;
  end;

var
  DodaciKFakture: TDodaciKFakture;

implementation

uses Ini, FormHlavneOkno, ClassFaktury, Typy, FormAdresar;

{$R *.DFM}

procedure TDodaciKFakture.ButtonOKClick(Sender: TObject);
begin
  if (RadioButton1.Checked) then
    ModalResult := ComboBox.ItemIndex+1;

  if (RadioButton2.Checked) then
    if (FileName = '') then
      ModalResult := 0
    else
      ModalResult := 1;

  if (RadioButton3.Checked) then
    ModalResult := 1;
end;

procedure TDodaciKFakture.ButtonZrusitClick(Sender: TObject);
begin
  ModalResult := -1;
end;

procedure TDodaciKFakture.FormCreate(Sender: TObject);
var I : integer;
begin
  ComboBox.Clear;
  if Faktury = nil then exit;
  for I := 0 to Faktury.Zoznam.Count-1 do
    ComboBox.Items.Add( TFaktura( Faktury.Zoznam[I]^ ).Cislo );
  ComboBox.ItemIndex := ComboBox.Items.Count-1;

  Path := ponuky_dir;
  FileName := '';

  UpdateList( ponuky_dir );
end;

procedure TDodaciKFakture.RadioButton1Click(Sender: TObject);
begin
  ComboBox.Enabled := True;

  ListView.Enabled := False;
  ButtonAdr.Enabled := False;
  ButtonOK.Enabled := True;
end;

procedure TDodaciKFakture.RadioButton2Click(Sender: TObject);
begin
  ComboBox.Enabled := False;

  ListView.Enabled := True;
  ButtonAdr.Enabled := True;
  ButtonOK.Enabled := True;
end;

procedure TDodaciKFakture.RadioButton3Click(Sender: TObject);
begin
  ComboBox.Enabled := False;

  ListView.Enabled := False;
  ButtonAdr.Enabled := False;
  ButtonOK.Enabled := True;
end;


procedure TDodaciKFakture.UpdateList( Path : string );
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

procedure TDodaciKFakture.ButtonAdrClick(Sender: TObject);
begin
  if FormAdr.ShowModal = 1 then
    begin
      UpdateList( FormAdr.Path+'\' );
      Path := FormAdr.Path;
    end;
end;

procedure TDodaciKFakture.ListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then FileName := Path+Item.Caption
              else FileName := '';
  ButtonOK.Enabled := Selected;
end;

procedure TDodaciKFakture.ListViewDblClick(Sender: TObject);
begin
  if ListView.Selected <> nil then ModalResult := 1;
end;

procedure TDodaciKFakture.FormShow(Sender: TObject);
begin
  Path := ponuky_dir;
  UpdateList( Path );
end;

end.
