program Project;

uses
  Forms,
  FormHlavneOkno in 'FormHlavneOkno.pas' {HlavneOkno},
  ClassNulovy in 'ClassNulovy.pas',
  MojeTypy in 'MojeTypy.pas',
  ClassTetiva in 'ClassTetiva.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(THlavneOkno, HlavneOkno);
  Application.Run;
end.
