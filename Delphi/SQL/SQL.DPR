program SQL;

uses
  Forms,
  FrmMain in 'FrmMain.pas' {FormMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
