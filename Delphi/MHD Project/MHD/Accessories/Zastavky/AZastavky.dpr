program AZastavky;

uses
  Forms,
  FormHlavneOkno in 'FormHlavneOkno.pas' {HlavneOkno},
  SKonstanty in '..\..\MHDserver\SKonstanty.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(THlavneOkno, HlavneOkno);
  Application.Run;
end.
