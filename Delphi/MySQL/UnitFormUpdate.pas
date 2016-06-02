unit UnitFormUpdate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls;

type
  TFormUpdate = class(TForm)
    ButtonCancel: TButton;
    Label1: TLabel;
    ProgressBar: TProgressBar;
    procedure ButtonCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CloseUpdate : boolean;

    procedure SetText( Text : string );
  end;

var
  FormUpdate: TFormUpdate;

implementation

{$R *.DFM}

procedure TFormUpdate.SetText( Text : string );
begin
  Label1.Caption := Text;
end;

procedure TFormUpdate.ButtonCancelClick(Sender: TObject);
begin
  CloseUpdate := true;
end;

end.
