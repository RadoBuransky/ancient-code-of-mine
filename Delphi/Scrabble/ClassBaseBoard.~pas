unit ClassBaseBoard;

interface

uses ClassLetters, ExtCtrls, Graphics;

const CStoneSize   = 20;
      CBckgndColor = $00000000;
      CEmptyColor  = $00B0FFFF;
      CLtrColor    = $00000000;
      CLtrBckColor = $0080FFFF;
      CMrkColor    = $00FFFFFF;
      CMrkBckColor = $000000FF;

type TBaseBoard = class
     private
       procedure   PaintNumber( X, Y, Number : integer; Color : TColor );
     protected
       FImage      : TImage;

       procedure   PaintEmpty( X, Y : integer; Color : TColor );
       procedure   PaintLetter( Letter : TLetter; X, Y : integer; TextColor, BgColor : TColor );
     public
       constructor Create( Image : TImage );
       destructor  Destroy; override;
     end;

implementation

uses Classes, SysUtils;

//==============================================================================
// Constructor / destructor
//==============================================================================

constructor TBaseBoard.Create( Image : TImage );
begin
  inherited Create;
  FImage := Image;
end;

destructor TBaseBoard.Destroy;
begin
  inherited;
end;

//==============================================================================
// P R I V A T E
//==============================================================================

procedure TBaseBoard.PaintNumber( X, Y, Number : integer; Color : TColor );
type TRome = (rI,rV,rX,rN);
const CRomeNums : array[0..10,1..4] of TRome =
      ((rN,rN,rN,rN),
       (rI,rN,rN,rN),
       (rI,rI,rN,rN),
       (rI,rI,rI,rN),
       (rI,rV,rN,rN),
       (rV,rN,rN,rN),
       (rV,rI,rN,rN),
       (rV,rI,rI,rN),
       (rV,rI,rI,rI),
       (rI,rX,rN,rN),
       (rX,rN,rN,rN));
      CSize = 5;
var I   : integer;
    Pos : integer;
begin
  FImage.Canvas.Pen.Color := Color;
  FImage.Canvas.Pen.Width := 1;

  Pos := 0;
  for I := High( CRomeNums[Number] ) downto Low( CRomeNums[Number] ) do
    case CRomeNums[Number,I] of
      rI : begin
             FImage.Canvas.Polyline( [Point(Pos+X,Y),Point(Pos+X,Y+CSize)] );
             Dec( Pos , 2 );
           end;
      rV : begin
             FImage.Canvas.Polyline( [Point(Pos+X,Y),Point(Pos+X-1,Y+CSize-1),
                                      Point(Pos+X-4,Y-1)] );
             Dec( Pos , 5 );
           end;
      rX : begin
             FImage.Canvas.Polyline( [Point(Pos+X-1,Y),Point(Pos+X-4,Y+CSize)] );
             FImage.Canvas.Polyline( [Point(Pos+X-3,Y),Point(Pos+X,Y+CSize)] );
             Dec( Pos , 8 );
           end;
    end;
end;

//==============================================================================
// P R O T E C T E D
//==============================================================================

procedure TBaseBoard.PaintEmpty( X, Y : integer; Color : TColor );
begin
  FImage.Canvas.Brush.Color := Color;
  FImage.Canvas.Pen.Color   := CBckgndColor;
  FImage.Canvas.Rectangle( X , Y , X + CStoneSize + 2 , Y + CStoneSize + 2 );
end;

procedure TBaseBoard.PaintLetter( Letter : TLetter; X, Y : integer; TextColor, BgColor : TColor );
begin
  with FImage.Canvas do
    begin
      Brush.Color := BgColor;
      Pen.Color   := TextColor;
      Font.Color  := TextColor;

      Font.Size   := 10;
      Font.Style  := [fsBold];

      PaintEmpty( (X-1)*CStoneSize+(X-1) , (Y-1)*CStoneSize+(Y-1) , BgColor );

      TextOut( ((X-1)*CStoneSize) + X + (CStoneSize - TextWidth( UpCase( Letter.C ) )) div 2 - 1 ,
               ((Y-1)*CStoneSize) + Y + 1 , UpCase( Letter.C ) );

      PaintNumber( ((X-1)*CStoneSize) + X + CStoneSize - 2 , Y*CStoneSize + Y - 6 , Letter.Value , TextColor );
    end;
end;

end.

