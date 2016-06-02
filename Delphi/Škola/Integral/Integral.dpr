program Integral;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  ClassMetoda in 'ClassMetoda.pas',
  ClassObdlznikova in 'ClassObdlznikova.pas',
  ClassLicho in 'ClassLicho.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
