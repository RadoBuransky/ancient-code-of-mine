unit ClassComputer;

interface

uses ClassPlayer, Types;

const MAX_DEPTH = 1;

type TTable = array[0..63] of integer;
     TCompMove = record
       Value : integer;
       A, B : integer;
     end;
     TMoves = record
       Items : array[1..200] of record
                 Move, Best : TCompMove;
               end;
       Count : integer;
     end;

     TComp = class( TPlayer )
     private
       function InitTable( Figures : TFigures ) : TTable;

       procedure PohniPesiaka( Table : TTable; NaTahu : integer; Moves : TMoves; Pos : integer );
       procedure PohniVezu( Table : TTable; NaTahu : integer; Moves : TMoves; Pos : integer );
       procedure PohniKona( Table : TTable; NaTahu : integer; Moves : TMoves; Pos : integer );
       procedure PohniStrelca( Table : TTable; NaTahu : integer; Moves : TMoves; Pos : integer );
       procedure PohniDamu( Table : TTable; NaTahu : integer; Moves : TMoves; Pos : integer );
       procedure PohniKrala( Table : TTable; NaTahu : integer; Moves : TMoves; Pos : integer );

       procedure OhodnotTahy( Moves : TMoves; NaTahu : integer );

       function FindBestMove( Table : TTable; NaTahu, Depth : integer ) : TCompMove;
       function GenerateMoves( Table : TTable; NaTahu : integer ) : TMove;
     public
       function MakeMove( Figures : TFigures ) : TMove; override;
     end;

implementation

//==============================================================================
//  Chess
//==============================================================================

function TComp.InitTable( Figures : TFigures ) : TTable;
var I, J : integer;
begin
  for I := 1 to 8 do
    for J := 1 to 8 do
      Result[(J-1)+(I-1)*8] := Figures[J,I];
end;

procedure TComp.PohniPesiaka( Table : TTable; NaTahu : integer; Moves : TMoves; Pos : integer );
begin
end;

procedure TComp.PohniVezu( Table : TTable; NaTahu : integer; Moves : TMoves; Pos : integer );
begin
end;

procedure TComp.PohniKona( Table : TTable; NaTahu : integer; Moves : TMoves; Pos : integer );
begin
end;

procedure TComp.PohniStrelca( Table : TTable; NaTahu : integer; Moves : TMoves; Pos : integer );
begin
end;

procedure TComp.PohniDamu( Table : TTable; NaTahu : integer; Moves : TMoves; Pos : integer );
begin
end;

procedure TComp.PohniKrala( Table : TTable; NaTahu : integer; Moves : TMoves; Pos : integer );
begin
end;

procedure TComp.OhodnotTahy( Moves : TMoves; NaTahu : integer );
begin
end;

function TComp.FindBestMove( Table : TTable; NaTahu, Depth : integer ) : TCompMove;
var Moves : TMoves;
    I : integer;
begin
  Moves.Count := 0;
  for I := 0 to 63 do
    if (Table[I]*NaTahu > 0) then
      case Abs(Table[I]) of
        1 : PohniPesiaka( Table , NaTahu , Moves , I );
        2 : PohniVezu( Table , NaTahu , Moves , I );
        3 : PohniKona( Table , NaTahu , Moves , I );
        4 : PohniStrelca( Table , NaTahu , Moves , I );
        5 : PohniDamu( Table , NaTahu , Moves , I );
        6 : PohniKona( Table , NaTahu , Moves , I );
      end;

  OhodnotTahy( Moves , NaTahu );

  for I := 0 to Moves.Count-1 do
    Moves.Items[I].Value :=
end;

function TComp.GenerateMoves( Table : TTable; NaTahu : integer ): TMove;
var CompMove : TCompMove;
begin
  CompMove := FindBestMove( Table , NaTahu , 0 );
  with Result do
    begin
      A.X := (CompMove.A mod 8)+1;
      A.Y := (CompMove.A div 8)+1;
      B.X := (CompMove.B mod 8)+1;
      B.Y := (CompMove.B div 8)+1;
    end;
end;

//==============================================================================
//  I N T E R F A C E
//==============================================================================

function TComp.MakeMove( Figures : TFigures ) : TMove;
begin
  Result := GenerateMoves( InitTable( Figures ) , 1 );
end;

end.
