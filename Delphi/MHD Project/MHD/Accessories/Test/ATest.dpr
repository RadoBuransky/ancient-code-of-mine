program ATest;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {Form1},
  ClassHladanie in '..\..\ClassHladanie.pas',
  ClassData in '..\..\ClassData.pas',
  SKonstanty in '..\..\MHDserver\SKonstanty.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
