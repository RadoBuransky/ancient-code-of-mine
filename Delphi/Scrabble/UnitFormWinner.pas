unit UnitFormWinner;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFormWinner = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWinner: TFormWinner;

implementation

{$R *.DFM}

procedure TFormWinner.Button1Click(Sender: TObject);
begin
  ModalResult := 1;
end;

end.
