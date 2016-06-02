unit ClassComputer;

interface

uses ClassPlayer;

const POLTAHY = 3;

type TTah = record
       Pos : TPos;
       Value : integer;
     end;

type TComputer = class( TPlayer )
     private
       function ZistiHodnotu( Table : TTable; NaTahu : integer ) : integer;
       function ZistiNajTah( Table : TTable; NaTahu : integer; Hodnota : integer ) : TPos;
     public
       function MakeMove( Table : TTable ) : TPos; override;
     end;

implementation

function TComputer.ZistiHodnotu( Table : TTable; NaTahu : integer ) : integer;
var I, J : integer;
begin
  Result := 0;
  for I := 1 to XMAX do
    for J := 1 to YMAX do
      if (Table[I,J] = NaTahu) then
        Inc( Result );
end;

function TComputer.ZistiNajTah( Table : TTable; NaTahu : integer; Hodnota : integer ) : TPos;
var I, J : integer;
begin
  for I := 1 to XMAX do
    for J := 1 to YMAX do
      if (Table[I,J] = NaTahu) then
        begin
          
        end;
end;

function TComputer.MakeMove( Table : TTable ) : TPos;
begin
  Result := ZistiNajTah( Table , 1 , ZistiHodnotu( Table , 1 ) );
end;

end.
