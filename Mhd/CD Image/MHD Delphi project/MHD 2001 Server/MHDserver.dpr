program MHDserver;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  ClassMHDserver in 'ClassMHDserver.pas',
  SKonstanty in 'SKonstanty.pas',
  UnitAddTicket in 'UnitAddTicket.pas' {FormAddTicket},
  ClassUpdates in 'ClassUpdates.pas',
  UnitEdit in 'UnitEdit.pas' {FormEdit},
  UnitFormDate in 'UnitFormDate.pas' {FormDate};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MHD 2001 server';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormAddTicket, FormAddTicket);
  Application.CreateForm(TFormEdit, FormEdit);
  Application.CreateForm(TFormDate, FormDate);
  Application.Run;
end.
