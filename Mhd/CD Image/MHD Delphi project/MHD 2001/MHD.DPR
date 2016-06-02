program MHD;
{%ToDo 'MHD.todo'}

uses
  Forms,
  ClassData in 'ClassData.pas',
  ClassHladanie in 'ClassHladanie.pas',
  ClassMapa in 'ClassMapa.pas',
  DialogProgress in 'DialogProgress.pas' {DlgProgress},
  FormHlavneOkno in 'FormHlavneOkno.pas' {HlavneOkno},
  FrmAddTicket in 'FrmAddTicket.pas' {FormAddTicket},
  FrmDetail in 'FrmDetail.pas' {FormDetail},
  FrmHotovo in 'FrmHotovo.pas' {FormHotovo},
  FrmNastavenieCasu in 'FrmNastavenieCasu.pas' {FormNastavenieCasu},
  FrmSynchro in 'FrmSynchro.pas' {FormSynchro},
  Konstanty in 'Konstanty.pas',
  ClassMHDclient in 'ClassMHDclient.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MHD 2001';
  Application.HelpFile := '';
  Application.CreateForm(THlavneOkno, HlavneOkno);
  Application.CreateForm(TFormAddTicket, FormAddTicket);
  Application.CreateForm(TFormDetail, FormDetail);
  Application.CreateForm(TFormHotovo, FormHotovo);
  Application.CreateForm(TFormNastavenieCasu, FormNastavenieCasu);
  Application.CreateForm(TFormSynchro, FormSynchro);
  Application.Run;
end.
