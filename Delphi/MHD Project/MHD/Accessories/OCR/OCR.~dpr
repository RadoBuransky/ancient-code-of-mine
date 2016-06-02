program OCR;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  ClassOCR in 'ClassOCR.pas',
  ClassChars in 'ClassChars.pas',
  UnitChars in 'UnitChars.pas' {FormChars},
  UnitAddChar in 'UnitAddChar.pas' {FormAddChar};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormChars, FormChars);
  Application.CreateForm(TFormAddChar, FormAddChar);
  Application.Run;
end.
