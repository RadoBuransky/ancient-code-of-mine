program Calculator;

uses
  Forms,
  FormMain in 'FormMain.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
