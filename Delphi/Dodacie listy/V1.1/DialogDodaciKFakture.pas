unit DialogDodaciKFakture;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TDodaciKFakture = class(TForm)
    Label1: TLabel;
    ComboBox: TComboBox;
    ButtonOK: TButton;
    ButtonZrusit: TButton;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonZrusitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DodaciKFakture: TDodaciKFakture;

implementation

uses FormHlavneOkno, ClassFaktury, Typy;

{$R *.DFM}

procedure TDodaciKFakture.ButtonOKClick(Sender: TObject);
begin
  ModalResult := ComboBox.ItemIndex+1;
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
end;

end.
