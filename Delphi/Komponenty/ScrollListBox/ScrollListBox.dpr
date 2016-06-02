program ScrollListBox;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  ClassSListBox in 'ClassSListBox.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
