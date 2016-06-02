unit Sort;

interface
Uses Grids;

procedure Zorad( Stlpec : Integer; Tabulka : TStringGrid );

implementation

Uses Classes;

procedure Zorad( Stlpec : Integer; Tabulka : TStringGrid );

procedure QuickSort( iLo, iHi : Integer);
var A, Lo, Hi : Integer;
    Mid : String;
    C : String;
begin
  Lo := iLo;
  Hi := iHi;
  Mid := Tabulka.Cells[ Stlpec , (Lo + Hi) div 2 ];
  repeat
    while Tabulka.Cells[ Stlpec , Lo ] < Mid do Inc(Lo);
    while Tabulka.Cells[ Stlpec , Hi ] > Mid do Dec(Hi);
    if Lo <= Hi then
      begin
        for A := 0 to 3 do
          begin
            C := Tabulka.Cells[ A , Lo ];
            Tabulka.Cells[ A , Lo ] := Tabulka.Cells[ A , Hi ];
            Tabulka.Cells[ A , Hi ] := C;
          end;

        Inc(Lo);
        Dec(Hi);
      end;
  until Lo > Hi;
  if Hi > iLo then QuickSort( iLo, Hi);
  if Lo < iHi then QuickSort( Lo, iHi);
end;

begin
  QuickSort( 1 , Tabulka.RowCount-1 );
end;

end.
