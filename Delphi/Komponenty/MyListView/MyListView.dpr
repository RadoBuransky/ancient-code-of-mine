program MyListView;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  ClassMyListView in 'ClassMyListView.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
