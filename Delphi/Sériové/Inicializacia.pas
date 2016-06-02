unit Inicializacia;

interface

Uses Grids, Classes, StdCtrls;

procedure InicializaciaTabulky( Tabulka : TStringGrid );
procedure InicializaciaComboBoxu( Combo : TComboBox );
procedure InicializaciaVyhladavania;
procedure NacitajZoSuboru;

implementation

Uses SysUtils, Data, Dialogs, FormHlavneOkno;

procedure InicializaciaComboBoxu( Combo : TComboBox );
var A : Word;
begin
  Combo.Items.Capacity := PocetSkupin;
  if PocetSkupin > 0 then HlavneOkno.ButtonZmazatSkupinu.Enabled := True;
  for A := 1 to PocetSkupin do
    Combo.Items.Add( Pole[A].NazovSkupiny );
end;

procedure InicializaciaTabulky( Tabulka : TStringGrid );
var SirkaStlpca : Word;
    A : Word;
begin
  SirkaStlpca := (Tabulka.Width div Tabulka.ColCount) - 2;
  for A := 0 to Tabulka.ColCount-1 do
    Tabulka.ColWidths[A] := SirkaStlpca;

  //Hlavicka tabulky :
  with Tabulka do
    begin
      Cells[0,0] := '»Ìslo dokladu';
      Cells[1,0] := 'N·zov tovaru';
      Cells[2,0] := 'SÈriovÈ ËÌslo';
      Cells[3,0] := 'SÈriovÈ ËÌslo PROMPT';
    end;

  if PocetSkupin = 0 then Exit;
  NahadzDataDoTabulky( 1 );
end;

function Verzia : Byte;
var Vysledok : TSearchRec;
begin
  if FindFirst( 'data.dat' , faAnyFile , Vysledok ) = 0 then
    begin
      Verzia := 2;
      Exit;
    end;
  if FindFirst( '*.dat' , faAnyFile , Vysledok ) <> 0 then Verzia := 0
                                                      else Verzia := 1;
end;

procedure NacitajZoSuboru;

procedure NovySubor;
begin
  Assign( Output , 'data.dat' );
  Rewrite( Output );
  Writeln( '0' );
  Close( Output );
end;

procedure Konvertuj;
var Vysledok : TSearchRec;

procedure SpracujSubor( NazovSuboru : String );
var Polozka : TPolozka;
begin
  Inc( PocetSkupin );
  with Pole[PocetSkupin] do
    begin
      Cislo := TStringList.Create;
      Nazov := TStringList.Create;
      Seriove := TStringList.Create;
      Prompt := TStringList.Create;

      Cislo.Capacity := 1000;
      Nazov.Capacity := 1000;
      Seriove.Capacity := 1000;
      Prompt.Capacity := 1000;

      Cislo.Sorted := False;
      Nazov.Sorted := False;
      Seriove.Sorted := False;
      Prompt.Sorted := False;
    end;

  Assign( Input , NazovSuboru );
  Reset( Input );
  Readln( Pole[PocetSkupin].NazovSkupiny );
  while not EoF( Input ) do
    begin
      Readln( Polozka.Cislo );
      Readln( Polozka.Nazov );
      Readln( Polozka.Seriove );
      Polozka.Prompt := '';

      with Pole[PocetSkupin] do
        begin
          Cislo.Add( Polozka.Cislo );
          Nazov.Add( Polozka.Nazov );
          Seriove.Add( Polozka.Seriove );
          Prompt.Add( Polozka.Prompt );
        end;
    end;
  Close( Input );
  Erase( Input );
  with Pole[PocetSkupin] do
    begin
      Cislo.Capacity := Cislo.Count;
      Nazov.Capacity := Nazov.Count;
      Seriove.Capacity := Seriove.Count;
      Prompt.Capacity := Prompt.Count;

      PocetPoloziek := Prompt.Count;
    end;
end;

procedure ZapisDoSuboru;
var A, B : Integer;
begin
  Assign( Output , 'data.dat' );
  Rewrite( Output );
  Writeln( PocetSkupin );
  for A := 1 to PocetSkupin do
    begin
      Writeln( Pole[A].Cislo.Count );
      Writeln( Pole[A].NazovSkupiny );
      for B := 0 to Pole[A].Cislo.Count-1 do
        begin
          Writeln( Pole[A].Cislo.Strings[B] );
          Writeln( Pole[A].Nazov.Strings[B] );
          Writeln( Pole[A].Seriove.Strings[B] );
          Writeln( Pole[A].Prompt.Strings[B] );
        end;
    end;
  Close( Output );
end;

begin
  FindFirst( '*.dat' , faAnyFile , Vysledok );
  SpracujSubor( Vysledok.Name );
  while FindNext( Vysledok ) = 0 do
    SpracujSubor( Vysledok.Name );
  ZapisDoSuboru;
end;

procedure NacitajData;
var A, B : Word;
    PocPoloziek : Word;
    NazovSkupiny : String;
    Polozka : TPolozka;

begin
  Assign( Input , 'data.dat' );
  {$I-}
  Reset( Input );
  {$I+}
  if IOResult <> 0 then
    begin
      ShowMessage( 'S˙bor "data.dat" nie je moûnÈ otvoriù na ËÌtanie' );
      HlavneOkno.Close;
    end;

  Readln( PocetSkupin );
  for A := 1 to PocetSkupin do
    begin
      Readln( PocPoloziek );

      with Pole[A] do
        begin
          Cislo := TStringList.Create;
          Nazov := TStringList.Create;
          Seriove := TStringList.Create;
          Prompt := TStringList.Create;

          Cislo.Capacity := PocPoloziek;
          Nazov.Capacity := PocPoloziek;
          Seriove.Capacity := PocPoloziek;
          Prompt.Capacity := PocPoloziek;

          Cislo.Sorted := False;
          Nazov.Sorted := False;
          Seriove.Sorted := False;
          Prompt.Sorted := False;

          PocetPoloziek := PocPoloziek;
        end;

      Readln( NazovSkupiny );
      Pole[A].NazovSkupiny := NazovSkupiny;

      for B := 1 to PocPoloziek do
        begin
          Readln( Polozka.Cislo );
          Readln( Polozka.Nazov );
          Readln( Polozka.Seriove );
          Readln( Polozka.Prompt );

          with Pole[A] do
            begin
              Cislo.Add( Polozka.Cislo );
              Nazov.Add( Polozka.Nazov );
              Seriove.Add( Polozka.Seriove );
              Prompt.Add( Polozka.Prompt );
            end;
        end;
    end;
  Close( Input );
end;

begin
  case Verzia of
    0 : NovySubor;
    1 : Konvertuj;
    2 : NacitajData;
  end;
end;

procedure InicializaciaVyhladavania;
var A, Sirka : Word;
begin
  Sirka := HlavneOkno.ListViewVyhladavanie.Width div 4;
  for A := 0 to 3 do
    HlavneOkno.ListViewVyhladavanie.Columns[A].Width := Sirka-1;
end;

end.
