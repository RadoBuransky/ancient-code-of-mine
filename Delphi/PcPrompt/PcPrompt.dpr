program PcPrompt;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  ClassFaktury in 'ClassFaktury.pas',
  ClassAdresy in 'ClassAdresy.pas',
  Typy in 'Typy.pas',
  ClassDodaci in 'ClassDodaci.pas',
  ClassGlobals in 'ClassGlobals.pas';

{$R *.RES}

begin
  // Create global objects
  Globals := TGlobals.Create;
  Adresy  := TAdresy.Create;
  Faktury := TFaktury.Create;
  Dodaci  := TDodaci.Create;

  // Run application
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

  // Destroy global objects
  Adresy.Free;
  Faktury.Free;
  Dodaci.Free;
  Globals.Free;
end.
