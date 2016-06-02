unit ClassClovek;

interface

uses Typy, ClassHrac, Graphics;

type TClovek = class(THrac)
     private
       Pole : PPole;
     public
       Farba : TColor;

       constructor Create( iFarba : TColor; iPole : PPole );
     
       function UrobTah : TSur; override;
     end;

implementation

uses FormHlavneOkno;

//==============================================================================
//==============================================================================
//
//                                 Constructor
//
//==============================================================================
//==============================================================================

constructor TClovek.Create( iFarba : TColor; iPole : PPole );
begin
  inherited;
  Farba := iFarba;
  Pole := iPole;
end;

function TClovek.UrobTah : TSur;
var I, J : integer;
    Mozno : boolean;
begin
  Mozno := False;
  for I := 1 to 14 do
    for J := 1 to 14 do
      if Pole[I,J] = 0 then
        if MoznoPolozit( I , J , 1 ) then
           begin
             Mozno := True;
             break;
           end;
  if not Mozno then
    begin
      Result.X := 0;
      Result.Y := 0;
      exit;
    end;
  repeat
    HlavneOkno.CakajNaTah;
  until (MoznoPolozit( HlavneOkno.Sur.X , HlavneOkno.Sur.Y , 1 )) or
        (HlavneOkno.KoniecHry > 0);
  Result := HlavneOkno.Sur;
end;

end.
