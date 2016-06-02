unit FrmHotovo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFormHotovo = class(TForm)
    Image: TImage;
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHotovo: TFormHotovo;

implementation

{$R *.DFM}

procedure TFormHotovo.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
