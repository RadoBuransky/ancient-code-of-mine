program Ftp;

uses
  Forms,
  UnitFormMain in 'UnitFormMain.pas' {FormMain},
  UnitFormConnect in 'UnitFormConnect.pas' {FormConnect};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormConnect, FormConnect);
  Application.Run;
end.
