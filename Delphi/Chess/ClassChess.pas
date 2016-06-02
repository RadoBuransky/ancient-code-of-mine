unit ClassChess;

interface

uses ClassBoard, ClassPlayer, Types, ExtCtrls;

type TChess = class
     private
       Figures : TFigures;
       Board : TBoard;

       Players : array[1..2] of TPlayer;

       procedure InitBoard;
       function IsMat( Move : TMove ) : boolean;
       procedure MakeMove( Move : TMove );
     public
       function Play : integer;

       constructor Create( BoardImage : TImage );
       destructor Destroy; override;
     end;

var Chess : TChess;

implementation

uses ClassComputer;

//==============================================================================
//  Constructor
//==============================================================================

procedure TChess.InitBoard;
var I, J : integer;
begin
  for I := 1 to 8 do
    for J := 1 to 8 do
      Figures[I,J] := 0;

  for I := 1 to 8 do
    Figures[I,7] := 1;
  for I := 1 to 5 do
    Figures[I,8] := I+1;
  Figures[6,8] := 4;
  Figures[7,8] := 3;
  Figures[8,8] := 2;

  for I := 1 to 2 do
    for J := 1 to 8 do
      Figures[J,I] := -Figures[J,9-I];

  Board.Repaint( Figures );
end;

constructor TChess.Create( BoardImage : TImage );
begin
  inherited Create;
  Board := TBoard.Create( BoardImage );
  Players[1] := TComp.Create;
  Players[2] := TComp.Create;
  InitBoard;
end;

//==============================================================================
//  Destructor
//==============================================================================

destructor TChess.Destroy;
begin
  Players[1].Free;
  Players[2].Free;
  Board.Free;
  inherited;
end;

//==============================================================================
//  Chess play
//==============================================================================

function TChess.IsMat( Move : TMove ) : boolean;
begin
  Result := False;
end;

procedure TChess.MakeMove( Move : TMove );
begin
  Figures[Move.B.X,Move.B.Y] := Figures[Move.A.X,Move.A.Y];
  Figures[Move.A.X,Move.A.Y] := 0;
  Board.Repaint( Figures );
end;

//==============================================================================
//  I N T E R F A C E
//==============================================================================

function TChess.Play : integer;
var I : integer;
    NewMove : TMove;
begin
  Result := 0;
  repeat
    for I := 1 to 2 do
      begin
        NewMove := Players[I].MakeMove( Figures );
        if (not IsMat( NewMove )) then MakeMove( NewMove )
                                  else
                                    begin
                                      Result := I;
                                      break;
                                    end;
      end;
    break;
  until (Result <> 0);
end;

end.
