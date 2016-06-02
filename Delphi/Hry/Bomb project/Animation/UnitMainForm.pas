unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TMainForm = class(TForm)
    Image: TImage;
    ButtonStart: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses Constants, ClassAnimation;

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Animation := TAnimation.Create( Image , CREATURES_DIR+'Creature1.bmb' );
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Animation.Free;
end;

end.
