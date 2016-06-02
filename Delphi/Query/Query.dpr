program Query;

uses
  Forms,
  FormHlavneOkno in 'FormHlavneOkno.pas' {HlavneOkno};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(THlavneOkno, HlavneOkno);
  Application.Run;
end.
