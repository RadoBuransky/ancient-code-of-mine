unit ClassScoreBoard;

interface

uses Windows, Graphics, ExtCtrls, Controls;

const CInterval = 3000; 

type TState = ( sTitle , sPl1 , sPl2 );
     TPlyr = ( pComp1 , pComp2 , pComp3 , pPl1 , pPl2 );

     TScoreBoard = class
     private
       FImage      : TImage;
       FTitle      : TBitmap;
       FState      : TState;
       FScPl1      : integer;
       FScPl2      : integer;
       FPlayer1    : TPlyr;
       FPlayer2    : TPlyr;
       FTimer      : TTimer;

       procedure   OnTimer( Sender : TObject );
       procedure   OnClick( Sender : TObject );
       procedure   SetState( NewState : TState );
       procedure   SetScore1( NewScore : integer );
       procedure   SetScore2( NewScore : integer );

       procedure   PaintPlayer1;
       procedure   PaintPlayer2;
     public
       constructor Create( Image : TImage );
       destructor  Destroy; override;

       procedure   Reset;

       property    Player1 : TPlyr write FPlayer1;
       property    Player2 : TPlyr write FPlayer2;
       property    Score1  : integer write SetScore1;
       property    Score2  : integer write SetScore2;
       property    State   : TState write SetState;
     end;

implementation

uses SysUtils;

//==============================================================================
// Constructor / destructor
//==============================================================================

constructor TScoreBoard.Create( Image : TImage );
begin
  inherited Create;
  FImage   := Image;
  FTitle   := TBitmap.Create;
  FState   := sTitle;
  FPlayer1 := pPl1;
  FPlayer2 := pPl2;
  FTimer   := TTimer.Create( nil );

  FTimer.Interval := CInterval;
  FTimer.OnTimer  := OnTimer;

  FImage.OnClick := OnClick;
  FTitle.Assign( FImage.Picture.Bitmap );
end;

destructor TScoreBoard.Destroy;
begin
  FTimer.Free;
  FTitle.Free;
  inherited;
end;

//==============================================================================
// P R I V A T E
//==============================================================================

procedure TScoreBoard.OnTimer( Sender : TObject );
begin
  State          := sTitle;
  FTimer.Enabled := false;
end;

procedure TScoreBoard.OnClick( Sender : TObject );
begin
  if (FState <> sPl2) then
    State := Succ( FState )
  else
    State := sTitle;
end;

procedure TScoreBoard.SetState( NewState : TState );
begin
  FState := NewState;
  case (FState) of
    sTitle : FImage.Canvas.Draw( 0 , 0 , FTitle );
    sPl1   : PaintPlayer1;
    sPl2   : PaintPlayer2;
  end;
end;

procedure TScoreBoard.SetScore1( NewScore : integer );
begin
  FScPl1          := NewScore;
  State           := sPl1;
  FTimer.Interval := CInterval;
  FTimer.Enabled  := false;
  FTimer.Enabled  := true;
end;

procedure TScoreBoard.SetScore2( NewScore : integer );
begin
  FScPl2          := NewScore;
  State           := sPl2;
  FTimer.Interval := CInterval;
  FTimer.Enabled  := false;
  FTimer.Enabled  := true;
end;

procedure TScoreBoard.PaintPlayer1;
var Bmp : TBitmap;
    S : string;
begin
  Bmp := TBitmap.Create;
  try
    with FImage.Canvas do
      begin
        Brush.Color := RGB( 51 , 102 , 51 );
        FillRect( FImage.ClientRect );

        S := 'Player 1 : '+IntToStr( FScPl1 );

        Font.Name  := 'Arial';
        Font.Size  := 18;
        Font.Color := RGB( 255 , 204 , 0 );
        TextOut( (FImage.Width - TextWidth( S )) div 2  , 10 , S );
      end;
  finally
    Bmp.Free;
  end;
end;

procedure TScoreBoard.PaintPlayer2;
var Bmp : TBitmap;
    S : string;
begin
  Bmp := TBitmap.Create;
  try
    with FImage.Canvas do
      begin
        Brush.Color := RGB( 51 , 102 , 51 );
        FillRect( FImage.ClientRect );

        S := 'Player 2 : '+IntToStr( FScPl2 );

        Font.Name  := 'Arial';
        Font.Size  := 18;
        Font.Color := RGB( 255 , 204 , 0 );
        TextOut( (FImage.Width - TextWidth( S )) div 2  , 10 , S );
      end;
  finally
    Bmp.Free;
  end;
end;

//==============================================================================
// P U B L I C
//==============================================================================

procedure TScoreBoard.Reset;
begin
  FScPl1 := 0;
  FScPl2 := 0;
  State := sTitle;
end;

end.
