(*

  Popis vstupneho suboru :

  data.dat
    Pocet skupin
    Pocet poloziek v nasledujucej skupine
    Nazov skupiny
    Cislo dokladu
    Nazov tovaru
    Seriove cislo
    Seriove cislo PROMPT

    dalsia skupina

*)

unit Data;

interface

Uses Classes, StdCtrls;

type TPolozka = record
                  Cislo, Nazov, Seriove, Prompt : String;
                end;
     TSkupina = record
                  NazovSkupiny : String;
                  PocetPoloziek : Word;
                  Cislo, Nazov, Seriove, Prompt : TStringList;
                end;

var Pole : array[1..100] of TSkupina;
    PocetSkupin : Word;
    AktivnaSkupina : Word;

procedure InicializaciaDat;

procedure PridajSkupinu( NazovSk : String );
procedure PridajPolozku( Polozka : TPolozka );

procedure ZmazSkupinu;
procedure ZmazPolozku( Cislo : Word );

procedure NahadzDataDoTabulky( CisloSkupiny : Integer );
procedure NahadzDataDoSuboru;
procedure NahadzDataDoPola;

procedure ZoradComboBox( Combo : TComboBox );

implementation

Uses FormHlavneOkno;

procedure InicializaciaDat;
begin
  AktivnaSkupina := 0;
  PocetSkupin := 0;
end;

procedure PridajSkupinu( NazovSk : String );
begin
  Inc( PocetSkupin );
  if PocetSkupin = 1 then
    begin
      HlavneOkno.ButtonZmazatSkupinu.Enabled := True;
      HlavneOkno.Tabulka.Visible := True;

      HlavneOkno.PridatPolozku.Enabled := True;
      HlavneOkno.ZmazatSkupinu.Enabled := True;
    end;
  HlavneOkno.ButtonZmazatSkupinu.Enabled := True;
  AktivnaSkupina := PocetSkupin;
  with Pole[ PocetSkupin ] do
    begin
      NazovSkupiny := NazovSk;
      PocetPoloziek := 0;

      Cislo := TStringList.Create;
      Nazov := TStringList.Create;
      Seriove := TStringList.Create;
      Prompt := TStringList.Create;

      Cislo.Sorted := False;
      Nazov.Sorted := False;
      Seriove.Sorted := False;
      Prompt.Sorted := False;
    end;
  with HlavneOkno.ComboBoxSkupina do
    begin
      Items.Add( NazovSk );
      ItemIndex := PocetSkupin-1;
    end;
  NahadzDataDoTabulky( AktivnaSkupina );
end;

procedure PridajPolozku( Polozka : TPolozka );
begin
 with HlavneOkno.Tabulka do
    begin
      Inc( Pole[AktivnaSkupina].PocetPoloziek );
      if Pole[AktivnaSkupina].PocetPoloziek = 1 then
        HlavneOkno.ZmazatPolozku.Enabled := True;
      if Pole[AktivnaSkupina].PocetPoloziek > 1 then RowCount := RowCount + 1;
      Cells[0,Pole[AktivnaSkupina].PocetPoloziek] := Polozka.Cislo;
      Cells[1,Pole[AktivnaSkupina].PocetPoloziek] := Polozka.Nazov;
      Cells[2,Pole[AktivnaSkupina].PocetPoloziek] := Polozka.Seriove;
      Cells[3,Pole[AktivnaSkupina].PocetPoloziek] := Polozka.Prompt;
    end;
end;

procedure ZmazSkupinu;
var A : Word;
begin
  Dec( PocetSkupin );
  if Pocetskupin = 0 then
    begin
      HlavneOkno.ButtonZmazatSkupinu.Enabled := False;
      HlavneOkno.Tabulka.Visible := False;
      HlavneOkno.ComboBoxSkupina.Items.Delete( AktivnaSkupina-1 );
      HlavneOkno.ComboBoxSkupina.ItemIndex := 0;

      HlavneOkno.ZmazatSkupinu.Enabled := False;
      HlavneOkno.ZmazatPolozku.Enabled := False;
      HlavneOkno.PridatPolozku.Enabled := False;

      Exit;
    end;
  if AktivnaSkupina > PocetSkupin then Aktivnaskupina := PocetSkupin;
  HlavneOkno.ComboBoxSkupina.Items.Delete( AktivnaSkupina-1 );
  HlavneOkno.ComboBoxSkupina.ItemIndex := AktivnaSkupina-1;
  for A := AktivnaSkupina to PocetSkupin do
    Pole[A] := Pole[A+1];
  NahadzDataDoTabulky( AktivnaSkupina );
end;

procedure ZmazPolozku( Cislo : Word );
begin
  HlavneOkno.Tabulka.Rows[Cislo].Clear;
  HlavneOkno.Tabulka.Rows[Cislo] := HlavneOkno.Tabulka.Rows[ Pole[AktivnaSkupina].PocetPoloziek ] ;
  if HlavneOkno.Tabulka.RowCount > 2 then
    HlavneOkno.Tabulka.RowCount := HlavneOkno.Tabulka.RowCount-1;
  Dec( Pole[AktivnaSkupina].PocetPoloziek );
  if Pole[AktivnaSkupina].PocetPoloziek = 0 then
    HlavneOkno.ZmazatPolozku.Enabled := False;
end;

procedure NahadzDataDoTabulky( CisloSkupiny : Integer );
begin
  if CisloSkupiny = 0 then Exit;
  AktivnaSkupina := CisloSkupiny;
  if Pole[CisloSkupiny].PocetPoloziek > 1 then
    HlavneOkno.Tabulka.RowCount := Pole[CisloSkupiny].PocetPoloziek+1
      else
    if Pole[CisloSkupiny].PocetPoloziek = 0 then
      begin
        HlavneOkno.Tabulka.RowCount := 2;
        HlavneOkno.Tabulka.Cells[0,1] := '';
        HlavneOkno.Tabulka.Cells[1,1] := '';
        HlavneOkno.Tabulka.Cells[2,1] := '';
        HlavneOkno.Tabulka.Cells[3,1] := '';
      end
        else
      HlavneOkno.Tabulka.RowCount := 2;
      
  Pole[CisloSkupiny].Cislo.Insert( 0 , 'Èíslo dokladu' );
  Pole[CisloSkupiny].Nazov.Insert( 0 , 'Názov tovaru' );
  Pole[CisloSkupiny].Seriove.Insert( 0 , 'Sériové èíslo' );
  Pole[CisloSkupiny].Prompt.Insert( 0 , 'Sériové èíslo PROMPT' );

  HlavneOkno.Tabulka.Cols[0] := Pole[CisloSkupiny].Cislo;
  HlavneOkno.Tabulka.Cols[1] := Pole[CisloSkupiny].Nazov;
  HlavneOkno.Tabulka.Cols[2] := Pole[CisloSkupiny].Seriove;
  HlavneOkno.Tabulka.Cols[3] := Pole[CisloSkupiny].Prompt;

  Pole[CisloSkupiny].Cislo.Delete( 0 );
  Pole[CisloSkupiny].Nazov.Delete( 0 );
  Pole[CisloSkupiny].Seriove.Delete( 0 );
  Pole[CisloSkupiny].Prompt.Delete( 0 );
end;

procedure NahadzDataDoSuboru;
var A, B : Word;
begin
  Assign( Output , 'data.dat' );
  Rewrite( Output );
  Writeln( PocetSkupin );
  for A := 1 to PocetSkupin do
    begin
      Writeln( Pole[A].PocetPoloziek );
      Writeln( Pole[A].NazovSkupiny );
      for B := 1 to Pole[A].PocetPoloziek do
        begin
          Writeln( Pole[A].Cislo.Strings[B-1] );
          Writeln( Pole[A].Nazov.Strings[B-1] );
          Writeln( Pole[A].Seriove.Strings[B-1] );
          Writeln( Pole[A].Prompt.Strings[B-1] );
        end;
    end;
  Close( Output );
end;

procedure NahadzDataDoPola;
begin
  Pole[ AktivnaSkupina ].Cislo.Assign( HlavneOkno.Tabulka.Cols[0] );
  Pole[ AktivnaSkupina ].Nazov.Assign( HlavneOkno.Tabulka.Cols[1] );
  Pole[ AktivnaSkupina ].Seriove.Assign( HlavneOkno.Tabulka.Cols[2] );
  Pole[ AktivnaSkupina ].Prompt.Assign( HlavneOkno.Tabulka.Cols[3] );

  Pole[ AktivnaSkupina ].Cislo.Delete( 0 );
  Pole[ AktivnaSkupina ].Nazov.Delete( 0 );
  Pole[ AktivnaSkupina ].Seriove.Delete( 0 );
  Pole[ AktivnaSkupina ].Prompt.Delete( 0 );
end;

procedure ZoradComboBox( Combo : TComboBox );

procedure QuickSort( iLo, iHi : Integer);
var Lo, Hi : Integer;
    Mid : String;
    C : TSkupina;
begin
  Lo := iLo;
  Hi := iHi;
  Mid := Combo.Items.Strings[(Lo + Hi) div 2];
  repeat
    while Combo.Items.Strings[Lo] < Mid do Inc(Lo);
    while Combo.Items.Strings[Hi] > Mid do Dec(Hi);
    if Lo <= Hi then
      begin
        Combo.Items.Exchange( Lo , Hi );
        C := Pole[Hi+1];
        Pole[Hi+1] := Pole[Lo+1];
        Pole[Lo+1] := C;
        Inc(Lo);
        Dec(Hi);
      end;
  until Lo > Hi;
  if Hi > iLo then QuickSort( iLo, Hi);
  if Lo < iHi then QuickSort( Lo, iHi);
end;

begin
  Combo.ItemIndex := 0;
  AktivnaSkupina := 1;
  if PocetSkupin < 2 then Exit;
  QuickSort( 0 , PocetSkupin-1 );
  Combo.ItemIndex := 0;
end;

end.
