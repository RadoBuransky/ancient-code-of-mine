program redANDblue;

uses
  Forms,
  FormHlavneOkno in 'FormHlavneOkno.pas' {HlavneOkno},
  ClassHraciaPlocha in 'ClassHraciaPlocha.pas',
  ClassHrac in 'ClassHrac.pas',
  Typy in 'Typy.pas',
  ClassClovek in 'ClassClovek.pas',
  ClassPocitac in 'ClassPocitac.pas',
  FormVictory in 'FormVictory.pas' {Victory};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(THlavneOkno, HlavneOkno);
  Application.CreateForm(TVictory, Victory);
  Application.Run;
end.
