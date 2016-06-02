program AEditor;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  ClassOCR in '..\OCR\ClassOCR.pas',
  ClassChars in '..\OCR\ClassChars.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MHD 2001 Server - editor rozvrhov';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
