program MHDeditor;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  ClassOCR in 'ClassOCR.pas',
  ClassChars in 'ClassChars.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MHD 2001 Server - editor rozvrhov';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
