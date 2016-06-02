unit UnitFormNewGame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFormNewGame = class(TForm)
    ButtonOK: TButton;
    RadioGroup: TRadioGroup;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNewGame: TFormNewGame;

implementation

{$R *.DFM}

procedure TFormNewGame.ButtonOKClick(Sender: TObject);
begin
  if (RadioGroup.ItemIndex = 0) then
    ModalResult := 11
  else
    ModalResult := 12;
end;

procedure TFormNewGame.ButtonCClick(Sender: TObject);
begin
  ModalResult := -1;
end;

end.
