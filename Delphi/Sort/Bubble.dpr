program Bubble;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
