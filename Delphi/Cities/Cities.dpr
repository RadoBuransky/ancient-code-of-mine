program Cities;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  ClassCities in 'ClassCities.pas',
  ClassPlayer in 'ClassPlayer.pas',
  ClassHuman in 'ClassHuman.pas',
  ClassComputer in 'ClassComputer.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
