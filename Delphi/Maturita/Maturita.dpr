program Maturita;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  ClassUlohy in 'ClassUlohy.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
