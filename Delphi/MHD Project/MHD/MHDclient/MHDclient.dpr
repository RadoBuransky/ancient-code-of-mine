program MHDclient;

uses
  Forms,
  ClassMHDclient in 'ClassMHDclient.pas',
  Konstanty in '..\Konstanty.pas',
  FrmSynchro in '..\FrmSynchro.pas' {FormSynchro};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormSynchro, FormSynchro);
  Application.Run;
end.
