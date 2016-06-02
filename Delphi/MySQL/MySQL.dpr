program MySQL;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {FormMain},
  UnitCennik in 'UnitCennik.pas',
  UnitCenniky in 'UnitCenniky.pas',
  ClassUpdate in 'ClassUpdate.pas',
  UnitFormUpdate in 'UnitFormUpdate.pas' {FormUpdate};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormUpdate, FormUpdate);
  Application.Run;
end.
