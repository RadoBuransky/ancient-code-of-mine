unit ClassObdlznikova;

interface

uses ClassMetoda;

type TObdlznikova = class( TMetoda )
     public
       procedure NakresliInterval( A, B : real; n : longint ); override;
       function Ries( A, B : real; n : longint ) : TVysledok; override;
     end;

var Obdlznikova : TObdlznikova;

implementation

uses Graphics, Windows;

procedure TObdlznikova.NakresliInterval( A, B : real; n : longint );
var I : longint;
    Left, Right : real;
    k, l, o, p : real;
    X1, X2, Y1, Y2 : integer;
    Lichobeznik : array[1..5] of TPoint;
begin
  Left := A;
  Right := B;

  Image.Canvas.Pen.Color := clRed;
  for I := 1 to N do
    begin
       k := Left;
       l := Left+((Right-Left)/((N+1)-I));

       o := Funkcia( k );
       p := Funkcia( l );

       X1 := Stred.X+Round( k );
       X2 := Stred.X+Round( l );

       Y1 := Stred.Y-Round( o );
       Y2 := Stred.Y-Round( p );

       if Abs(o) > Abs(p) then Y1 := Y2
                          else Y2 := Y1;

       Lichobeznik[1].x := X1;
       Lichobeznik[1].y := Stred.Y;

       Lichobeznik[2].x := X2;
       Lichobeznik[2].y := Stred.Y;

       Lichobeznik[3].x := X2;
       Lichobeznik[3].y := Y2;

       Lichobeznik[4].x := X1;
       Lichobeznik[4].y := Y1;

       Lichobeznik[5] := Lichobeznik[1];

      Image.Canvas.Polyline( Lichobeznik );

      Left := l;
    end;
end;

function TObdlznikova.Ries( A, B : real; n : longint ) : TVysledok;
var I : integer;
    Left, Right : real;
    k, l, o, p : real;
begin
  Left := A;
  Right := B;

  Result.Plocha := 0;

  for I := 1 to N do
    begin
      k := Left;
      l := Left+((Right-Left)/((N+1)-I));

      o := Funkcia( k );
      p := Funkcia( l );

      if Abs(o) > Abs(p) then o := p;

      Result.Plocha := Result.Plocha + (l-k)*o;

      Left := l;
    end;

  Result.Integral := Integral( B ) - Integral( A );
end;

end.
