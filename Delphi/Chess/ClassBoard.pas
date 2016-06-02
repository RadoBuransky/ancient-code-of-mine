unit ClassBoard;

interface

uses Types, ExtCtrls;

type TBoard = class
     private
       FBoard : TImage;
     public
       procedure Repaint( Figures : TFigures );

       constructor Create( BoardImage : TImage );
       destructor Destroy; override;
     end;

implementation

uses Windows, Graphics, SysUtils;

//==============================================================================
//  Constructor
//==============================================================================

constructor TBoard.Create( BoardImage : TImage );
begin
  inherited Create;
  FBoard := BoardImage;
end;

//==============================================================================
//  Destructor
//==============================================================================

destructor TBoard.Destroy;
begin
  inherited;
end;

//==============================================================================
//  Painting
//==============================================================================

procedure TBoard.Repaint( Figures : TFigures );
const Pismena : array[0..7] of char = ('A','B','C','D','E','F','G','H');
      Figurky : array[0..6] of char = (' ','P','V','J','S','D','K');
var I, J : integer;
    Rect : TRect;
begin
  for I := 0 to 7 do
    for J := 0 to 7 do
      begin
        with Rect do
          begin
            Left := 20+I*( (FBoard.Width-20) div 8 );
            Right := 20+(I+1)*( (FBoard.Width-20) div 8 );
            Top := J*( (FBoard.Height-20) div 8 );
            Bottom := (J+1)*( (FBoard.Height-20) div 8 );
          end;
        with FBoard.Canvas do
          begin
            if (((I+J) mod 2) = 0) then
              begin
                Brush.Color := clWhite;
                Font.Color := clBlack;
              end
                else
              begin
                Brush.Color := clBlack;
                Font.Color := clWhite;
              end;
            FillRect( Rect );

            if (Figures[1+I,8-J] < 0) then Font.Style := [fsBold,fsUnderline]
                                      else Font.Style := [];
            TextOut( 30+I*( (FBoard.Width-20) div 8 ) + 10 , 10+J*( (FBoard.Height-20) div 8 ) + 10 , Figurky[ Abs( Figures[1+I,8-J] ) ] )
          end;
      end;

  with FBoard.Canvas do
    begin
      Font.Style := [];

      Pen.Color := clBlack;
      Brush.Style := bsClear;

      with Rect do
        begin
          Left := 20;
          Right := FBoard.Width;
          Top := 0;
          Bottom := FBoard.Height-20;
        end;

      Rectangle( Rect );

      for I := 0 to 7 do
        TextOut( 6 , ((FBoard.Height-20) div 16)-5+I*((FBoard.Height-20) div 8) , IntToStr( 8-I ) );

      for I := 0 to 7 do
        TextOut( 20+((FBoard.Width-20) div 16)-5+I*((FBoard.Width-20) div 8) , FBoard.Height - 15 , Pismena[I] );
    end;
end;

end.
