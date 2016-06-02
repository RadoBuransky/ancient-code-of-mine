program Bomb;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  ClassLevel in 'ClassLevel.pas',
  Constants in 'Constants.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
