unit Display;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TSegmenty = array[1..7] of Boolean;
  TDisplay = class(TImage)
  private

    // Vlastnosti pre cely DISPLAY
    DigitsColor, PozadieColor : TColor;

    // Vlastnosti pre DISPLAY1
    Cislo : array[1..11] of integer;
    DesatinnaCiarka : byte;

    //Vlastnosti pre DISPLAY2
    Exp : array[1..3] of integer;

    //Vlastnosti pre DISPLAY3
    Text : string[6];

    //Vlastnosti STAVOVYCH PRVKOV
    Stav : boolean;

  protected

    procedure NakresliSevenSeg( X , Y : integer; Segmenty : TSegmenty; Zoom : real );
    procedure NakresliDesatinnuCiarku( X , Y : integer; Farba : TColor );
    procedure NakresliDisplay1;
    procedure NakresliDisplay2;
    procedure NakresliDisplay3;
    procedure NakresliStavovePrvky;

    procedure Paint; override;

    function GetHeight : Integer;
    function GetWidth : Integer;

  public

    procedure SetNumber( Value : Extended );

    constructor Create( AOwner : TComponent ); override;

  published

    property Height : Integer
      read GetHeight;
    property Width : Integer
      read GetWidth;

  end;

procedure Register;

implementation

uses Math;

{/-----------------------------------------------------------------------------\
 |-----------------------------------------------------------------------------|
 |                               P R I V A T E                                 |
 |-----------------------------------------------------------------------------|
 \-----------------------------------------------------------------------------/}

{/-----------------------------------------------------------------------------\
 |-----------------------------------------------------------------------------|
 |                             P R O T E C T E D                               |
 |-----------------------------------------------------------------------------|
 \-----------------------------------------------------------------------------/}

function NumberToSegment( A : integer ) : TSegmenty;
var Vystup : TSegmenty;
begin
  case A of
    -2 : begin
           Vystup[1] := False;
           Vystup[2] := False;
           Vystup[3] := False;
           Vystup[4] := True;
           Vystup[5] := False;
           Vystup[6] := False;
           Vystup[7] := False;
         end;
    -1 : begin
           Vystup[1] := False;
           Vystup[2] := False;
           Vystup[3] := False;
           Vystup[4] := False;
           Vystup[5] := False;
           Vystup[6] := False;
           Vystup[7] := False;
         end;
    0 : begin
          Vystup[1] := True;
          Vystup[2] := True;
          Vystup[3] := True;
          Vystup[4] := False;
          Vystup[5] := True;
          Vystup[6] := True;
          Vystup[7] := True;
        end;
    1 : begin
          Vystup[1] := False;
          Vystup[2] := False;
          Vystup[3] := True;
          Vystup[4] := False;
          Vystup[5] := False;
          Vystup[6] := True;
          Vystup[7] := False;
        end;
    2 : begin
          Vystup[1] := True;
          Vystup[2] := False;
          Vystup[3] := True;
          Vystup[4] := True;
          Vystup[5] := True;
          Vystup[6] := False;
          Vystup[7] := True;
        end;
    3 : begin
          Vystup[1] := True;
          Vystup[2] := False;
          Vystup[3] := True;
          Vystup[4] := True;
          Vystup[5] := False;
          Vystup[6] := True;
          Vystup[7] := True;
        end;
    4 : begin
          Vystup[1] := False;
          Vystup[2] := True;
          Vystup[3] := True;
          Vystup[4] := True;
          Vystup[5] := False;
          Vystup[6] := True;
          Vystup[7] := False;
        end;
    5 : begin
          Vystup[1] := True;
          Vystup[2] := True;
          Vystup[3] := False;
          Vystup[4] := True;
          Vystup[5] := False;
          Vystup[6] := True;
          Vystup[7] := True;
        end;
    6 : begin
          Vystup[1] := True;
          Vystup[2] := True;
          Vystup[3] := False;
          Vystup[4] := True;
          Vystup[5] := True;
          Vystup[6] := True;
          Vystup[7] := True;
        end;
    7 : begin
          Vystup[1] := True;
          Vystup[2] := False;
          Vystup[3] := True;
          Vystup[4] := False;
          Vystup[5] := False;
          Vystup[6] := True;
          Vystup[7] := False;
        end;
    8 : begin
          Vystup[1] := True;
          Vystup[2] := True;
          Vystup[3] := True;
          Vystup[4] := True;
          Vystup[5] := True;
          Vystup[6] := True;
          Vystup[7] := True;
        end;
    9 : begin
          Vystup[1] := True;
          Vystup[2] := True;
          Vystup[3] := True;
          Vystup[4] := True;
          Vystup[5] := False;
          Vystup[6] := True;
          Vystup[7] := True;
        end;
  end;
  NumberToSegment := Vystup;
end;

procedure TDisplay.NakresliSevenSeg( X , Y : integer; Segmenty : TSegmenty; Zoom : real );
type TSegmentPoly = record
                      Body : array[1..6] of TPoint;
                    end;

var SegmentyPoly : array[1..7] of TSegmentPoly;
    I, J : byte;

begin
  {Segment 1 :}
  with SegmentyPoly[1] do
    begin
      Body[1].X := 2;
      Body[1].Y := 2;

      Body[2].X := 4;
      Body[2].Y := 4;

      Body[3].X := 16;
      Body[3].Y := 4;

      Body[4].X := 18;
      Body[4].Y := 2;

      Body[5].X := 16;
      Body[5].Y := 0;

      Body[6].X := 4;
      Body[6].Y := 0;
    end;

  {Segment 2 :}
  with SegmentyPoly[2] do
    begin
      Body[1].X := 2;
      Body[1].Y := 2;

      Body[2].X := 4;
      Body[2].Y := 4;

      Body[3].X := 4;
      Body[3].Y := 16;

      Body[4].X := 2;
      Body[4].Y := 18;

      Body[5].X := 0;
      Body[5].Y := 16;

      Body[6].X := 0;
      Body[6].Y := 4;
    end;

  {Segment 3 :}
  with SegmentyPoly[3] do
    begin
      Body[1].X := 18;
      Body[1].Y := 2;

      Body[2].X := 20;
      Body[2].Y := 4;

      Body[3].X := 20;
      Body[3].Y := 16;

      Body[4].X := 18;
      Body[4].Y := 18;

      Body[5].X := 16;
      Body[5].Y := 16;

      Body[6].X := 16;
      Body[6].Y := 4;
    end;

  {Segment 4 :}
  with SegmentyPoly[4] do
    begin
      Body[1].X := 2;
      Body[1].Y := 18;

      Body[2].X := 4;
      Body[2].Y := 20;

      Body[3].X := 16;
      Body[3].Y := 20;

      Body[4].X := 18;
      Body[4].Y := 18;

      Body[5].X := 16;
      Body[5].Y := 16;

      Body[6].X := 4;
      Body[6].Y := 16;
    end;

  {Segment 5 :}
  with SegmentyPoly[5] do
    begin
      Body[1].X := 2;
      Body[1].Y := 18;

      Body[2].X := 4;
      Body[2].Y := 20;

      Body[3].X := 4;
      Body[3].Y := 32;

      Body[4].X := 2;
      Body[4].Y := 34;

      Body[5].X := 0;
      Body[5].Y := 32;

      Body[6].X := 0;
      Body[6].Y := 20;
    end;

  {Segment 6 :}
  with SegmentyPoly[6] do
    begin
      Body[1].X := 18;
      Body[1].Y := 18;

      Body[2].X := 20;
      Body[2].Y := 20;

      Body[3].X := 20;
      Body[3].Y := 32;

      Body[4].X := 18;
      Body[4].Y := 34;

      Body[5].X := 16;
      Body[5].Y := 32;

      Body[6].X := 16;
      Body[6].Y := 20;
    end;

  {Segment 7 :}
  with SegmentyPoly[7] do
    begin
      Body[1].X := 2;
      Body[1].Y := 34;

      Body[2].X := 4;
      Body[2].Y := 36;

      Body[3].X := 16;
      Body[3].Y := 36;

      Body[4].X := 18;
      Body[4].Y := 34;

      Body[5].X := 16;
      Body[5].Y := 32;

      Body[6].X := 4;
      Body[6].Y := 32;
    end;

  for I := 1 to 7 do
    for J := 1 to 6 do
      begin
        SegmentyPoly[I].Body[J].X := Round( SegmentyPoly[I].Body[J].X*Zoom + X);
        SegmentyPoly[I].Body[J].Y := Round( SegmentyPoly[I].Body[J].Y*Zoom + Y);
      end;

  for I := 1 to 7 do
    with Canvas do
      begin
        if Segmenty[I] then
          begin
            Pen.Color := DigitsColor;
            Brush.Color := DigitsColor;
          end
            else
          begin
            Pen.Color := PozadieColor;
            Brush.Color := PozadieColor;
          end;
        Polygon( SegmentyPoly[I].Body );
      end;
end;

procedure TDisplay.NakresliDesatinnuCiarku( X , Y : integer; Farba : TColor );
var Rect : TRect;
begin
  Rect.Left := X;
  Rect.Top := Y;
  Rect.Right := X+3;
  Rect.Bottom := Y+3;
  with Canvas do
    begin
      Pen.Color := Farba;
      Brush.Color := Farba;
      FillRect( Rect );
    end;
end;

procedure TDisplay.NakresliDisplay1;
var I : byte;
begin
  for I := 1 to 11 do
    begin
      NakresliSevenSeg( 40+((I-1) * 16) , 12 , NumberToSegment( Cislo[12-I] ) , 0.5 );
      if I = 11-DesatinnaCiarka then NakresliDesatinnuCiarku( 52+(I * 16) , 30 , DigitsColor )
                                else NakresliDesatinnuCiarku( 52+(I * 16) , 30 , PozadieColor );
    end;
end;

procedure TDisplay.NakresliDisplay2;
var I : byte;
begin
  for I := 1 to 3 do
    begin
      NakresliSevenSeg( 216+((I-1) * 10 ) , 8 , NumberToSegment( Exp[4-I] ) , 0.3 );
    end;
end;

procedure TDisplay.NakresliDisplay3;
begin
  with Canvas do
     begin
       Pen.Color := DigitsColor;
       Brush.Color := PozadieColor;
       TextOut( 5 , 18 , Text );
     end;
end;

procedure TDisplay.NakresliStavovePrvky;
begin
  with Canvas do
     begin
       Pen.Color := DigitsColor;
       Brush.Color := PozadieColor;
       if Stav then TextOut( 5 , 2 , 'DEG' )
               else TextOut( 5 , 2 , 'RAD' );
     end;
end;

procedure TDisplay.Paint;
begin
  Canvas.Pen.Color := DigitsColor;
  Canvas.Brush.Color := PozadieColor;
  Canvas.FillRect( ClientRect );

  NakresliDisplay1;
  NakresliDisplay2;
  NakresliDisplay3;
  NakresliStavovePrvky;

  inherited Paint;
end;

function TDisplay.GetHeight : Integer;
begin
  GetHeight := 40;
end;

function TDisplay.GetWidth : Integer;
begin
  GetWidth := 250;
end;

{/-----------------------------------------------------------------------------\
 |-----------------------------------------------------------------------------|
 |                              P U B L I C                                    |
 |-----------------------------------------------------------------------------|
 \-----------------------------------------------------------------------------/}

procedure TDisplay.SetNumber( Value : Extended );
var I : byte;
    PocetCelych : integer;
    PocetDesatinnych : integer;
    A : extended;
    B, C : cardinal;
    Zaporne : boolean;
begin
  Zaporne := False;
  if Value < 0 then
    begin
      Zaporne := True;
      Value := Abs( Value );
    end;

  if Value < 1 then
    begin
      PocetCelych := 0;
      PocetDesatinnych := -Round(Int(Log10( Value )))
    end
      else
    begin
      PocetCelych := Round(Int(Log10( Value )+1));
      PocetDesatinnych := -Round(Int(Log10( Frac(Value))-1));
    end;


end;

constructor TDisplay.Create( AOwner : TComponent );
var Value : Extended;
begin
  DigitsColor := clBlack;
  PozadieColor := clWhite;

  inherited Create( AOwner );

  inherited Width := 250;
  inherited Height := 40;

  Value := 0.00000001;
  Value := Value * 0.000001;
  SetNumber( Value );
end;

procedure Register;
begin
  RegisterComponents('Samples', [TDisplay]);
end;

end.
