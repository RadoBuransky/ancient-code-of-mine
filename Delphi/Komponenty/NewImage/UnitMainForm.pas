unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ClassNewImage, StdCtrls;

type
  TForm1 = class(TForm)
    NewImage1: TNewImage;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  DlgProgress.ShowModal;
end;

end.
