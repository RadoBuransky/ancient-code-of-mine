unit FormPridatPolozku;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TPridatPolozku = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditCislo: TEdit;
    EditNazov: TEdit;
    EditSeriove: TEdit;
    EditPrompt: TEdit;
    ButtonPridat: TButton;
    ButtonZrusit: TButton;
    procedure ButtonPridatClick(Sender: TObject);
    procedure ButtonZrusitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PridatPolozku: TPridatPolozku;

implementation

{$R *.DFM}

procedure TPridatPolozku.ButtonPridatClick(Sender: TObject);
begin
  ModalResult := 1;
end;

procedure TPridatPolozku.ButtonZrusitClick(Sender: TObject);
begin
  ModalResult := -1;
end;

end.
