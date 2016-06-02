program DBFFile;

uses
  Forms,
  ClassDBF in 'ClassDBF.pas',
  FormHlavneOkno in 'FormHlavneOkno.pas' {HlavneOkno};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(THlavneOkno, HlavneOkno);
  Application.Run;
end.
