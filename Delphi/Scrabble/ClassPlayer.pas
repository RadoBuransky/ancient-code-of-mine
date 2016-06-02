unit ClassPlayer;

interface

uses ClassBoard, ClassLetters, ClassLetterStack;

type TMove = array of TTile;

     TPlayer = class
     protected
       FLtrStack    : TLetterStack;
       FBoard       : TBoard;
       FLastMove    : TMove;
       FScore       : integer;
     public
       constructor Create( Letters : TLetters; Board : TBoard );
       destructor  Destroy; override;

       procedure   MakeMove( FirstMove : boolean ); virtual; abstract;
       function    EndMove : boolean; virtual; abstract;

       procedure   TakeLetters;
       procedure   ChangeLetters;
       procedure   ChangeSomeLetters; virtual; abstract;
       function    GetRest : integer;

       property    Score : integer read FScore write FScore;
       property    LastMove : TMove read FLastMove;
       property    LtrStack : TLetterStack read FLtrStack;
     end;

implementation

//==============================================================================
// Constructor / destructor
//==============================================================================

constructor TPlayer.Create( Letters : TLetters; Board : TBoard );
begin
  inherited Create;
  FLtrStack := TLetterStack.Create( Letters );
  FBoard    := Board;
  FScore    := 0;
  SetLength( FLastMove , 0 );
end;

destructor TPlayer.Destroy;
begin
  FLtrStack.Free;
  inherited;
end;

//==============================================================================
// P R I V A T E
//==============================================================================

//==============================================================================
// P U B L I C
//==============================================================================

procedure TPlayer.TakeLetters;
begin
  FLtrStack.TakeNew;
end;

procedure TPlayer.ChangeLetters;
begin
  FLtrStack.ChangeStack;
end;

function TPlayer.GetRest : integer;
var I : integer;
begin
  Result := 0;

  for I := 1 to 7 do
    if (FLtrStack.Stack[I].C <> #0) then
      Inc( Result , FLtrStack.Stack[I].Value );
end;

end.
