program Chess;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  ClassChess in 'ClassChess.pas',
  ClassBoard in 'ClassBoard.pas',
  Types in 'Types.pas',
  ClassPlayer in 'ClassPlayer.pas',
  ClassComputer in 'ClassComputer.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
