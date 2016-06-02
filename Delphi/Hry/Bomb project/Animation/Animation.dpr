program Animation;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  ClassAnimation in 'ClassAnimation.pas',
  Constants in '..\Bomb\Constants.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
