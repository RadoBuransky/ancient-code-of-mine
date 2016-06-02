program Adresy;

uses
  Forms,
  UnitMainWnd in 'UnitMainWnd.pas' {MainForm},
  ClassAdresy in 'ClassAdresy.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
