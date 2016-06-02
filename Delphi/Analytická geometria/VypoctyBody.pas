unit VypoctyBody;

interface

uses Typy, ComCtrls, SysUtils;

  function VzdialenostDvochBodov( A, B : TBod ) : Real;
  function TaziskoBodov( Zoznam : TListItems ) : TBod;

implementation

function VzdialenostDvochBodov( A, B : TBod ) : Real;
begin
  VzdialenostDvochBodov := Sqrt( Sqr(A.X - B.X) + Sqr(A.Y - B.Y) );
end;

function TaziskoBodov( Zoznam : TListItems ) : TBod;
var Vystup : TBod;
    I : word;
begin
  Vystup.X := 0;
  Vystup.Y := 0;

  with Zoznam do
    begin
      for I := 1 to Count do
        begin
          Vystup.X := Vystup.X + StrToFloat( Item[I-1].SubItems[0] );
          Vystup.Y := Vystup.Y + StrToFloat( Item[I-1].SubItems[1] );
        end;
      Vystup.X := Vystup.X / Count;
      Vystup.Y := Vystup.Y / Count;
    end;
  Result := Vystup;
end;

end.
