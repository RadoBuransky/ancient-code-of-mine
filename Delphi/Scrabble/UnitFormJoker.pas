unit UnitFormJoker;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFormJoker = class(TForm)
    Label1: TLabel;
    Edit: TEdit;
    Button1: TButton;
    procedure EditChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormJoker: TFormJoker;

implementation

{$R *.DFM}

procedure TFormJoker.EditChange(Sender: TObject);
begin
  if (Length( Edit.Text ) > 1) then
    Edit.Text := Edit.Text[1];
end;

procedure TFormJoker.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
