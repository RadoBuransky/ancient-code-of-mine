program tridee;

uses
  Forms,
  FHlavneOkno in 'FHlavneOkno.pas' {HlavneOkno},
  Operacie in 'Operacie.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(THlavneOkno, HlavneOkno);
  Application.Run;
end.
