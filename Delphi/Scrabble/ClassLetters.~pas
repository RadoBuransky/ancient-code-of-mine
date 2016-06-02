unit ClassLetters;

interface

type TLetter = record
       C     : char;
       Value : integer;
     end;

     TLetterInfo = record
       Letter : TLetter;
       Count  : integer;
     end;

     TNewLetters = array of TLetter;

const CLetterInfo : array[1..27] of TLetterInfo =
      ( ( Letter:( C:'a' ; Value:1) ; Count:9 ),
        ( Letter:( C:'b' ; Value:3) ; Count:2 ),
        ( Letter:( C:'c' ; Value:3) ; Count:2 ),
        ( Letter:( C:'d' ; Value:2) ; Count:4 ),
        ( Letter:( C:'e' ; Value:1) ; Count:12 ),
        ( Letter:( C:'f' ; Value:4) ; Count:2 ),
        ( Letter:( C:'g' ; Value:2) ; Count:3 ),
        ( Letter:( C:'h' ; Value:4) ; Count:2 ),
        ( Letter:( C:'i' ; Value:1) ; Count:9 ),
        ( Letter:( C:'j' ; Value:8) ; Count:1 ),
        ( Letter:( C:'k' ; Value:5) ; Count:1 ),
        ( Letter:( C:'l' ; Value:1) ; Count:4 ),
        ( Letter:( C:'m' ; Value:3) ; Count:2 ),
        ( Letter:( C:'n' ; Value:1) ; Count:6 ),
        ( Letter:( C:'o' ; Value:1) ; Count:8 ),
        ( Letter:( C:'p' ; Value:3) ; Count:2 ),
        ( Letter:( C:'q' ; Value:10) ; Count:1 ),
        ( Letter:( C:'r' ; Value:1) ; Count:6 ),
        ( Letter:( C:'s' ; Value:1) ; Count:4 ),
        ( Letter:( C:'t' ; Value:1) ; Count:6 ),
        ( Letter:( C:'u' ; Value:1) ; Count:4 ),
        ( Letter:( C:'v' ; Value:4) ; Count:2 ),
        ( Letter:( C:'w' ; Value:4) ; Count:2 ),
        ( Letter:( C:'x' ; Value:8) ; Count:1 ),
        ( Letter:( C:'y' ; Value:4) ; Count:2 ),
        ( Letter:( C:'z' ; Value:10) ; Count:1 ),
        ( Letter:( C:'?' ; Value:0) ; Count:2 ));

type TLetters = class
     private
       FStack : array of TLetterInfo;
     public
       constructor Create;
       destructor  Destroy; override;

       procedure   Reset;
       function    GetLetter : TLetter;
       function    ChangeLetters( Ltrs : array of TLetter ) : TNewLetters;
     end;

implementation

//==============================================================================
// Constructor/destructor
//==============================================================================

constructor TLetters.Create;
begin
  inherited;
  SetLength( FStack , 0 );
  Randomize;
end;

destructor TLetters.Destroy;
begin
  SetLength( FStack , 0 );
  inherited;
end;

//==============================================================================
// P U B L I C
//==============================================================================

procedure TLetters.Reset;
var I  : integer;
begin
  SetLength( FStack , Length( CLetterInfo ) );
  for I := 0 to Length( CLetterInfo )-1 do
    FStack[I] := CLetterInfo[I+1];
end;

function TLetters.GetLetter : TLetter;
var I : integer;
begin
  if (Length( FStack ) = 0) then
    begin
      Result.C       := #0;
      Result.Value   := 0;
      exit;
    end;

  I      := Random( Length( FStack ) );
  Result := FStack[I].Letter;

  Dec( FStack[I].Count );

  if (FStack[I].Count = 0) then
    begin
      for I := I to High( FStack )-1 do
        FStack[I] := FStack[I+1];
      SetLength( FStack , Length( FStack )-1 );
    end;
end;

function TLetters.ChangeLetters( Ltrs : array of TLetter ) : TNewLetters;
var New : array of TLetter;
    I, J   : integer;
    L   : TLetter;
    Found : boolean;
begin
  SetLength( New , 0 );
  for I := Low( Ltrs ) to High( Ltrs ) do
    begin
      L := GetLetter;
      if (L.C <> #0) then
        begin
          SetLength( New , Length( New )+1 );
          New[Length( New )-1] := L;
        end
      else
        break;
    end;

  for I := Low( Ltrs ) to High( Ltrs ) do
    begin
      Found := false;
      for J := Low( FStack ) to High( FStack ) do
        if (FStack[J].Letter.C = Ltrs[I].C) then
          begin
            Found := true;
            Inc( FStack[J].Count );
            break;
          end;

      if (not Found) then
        begin
          SetLength( FStack , Length( FStack )+1 );
          FStack[Length( FStack )-1].Letter := Ltrs[I];
          FStack[Length( FStack )-1].Count  := 1;
        end;
    end;

  SetLength( Result , Length( New ) );
  for I := Low( New ) to High( New ) do
    Result[I] := New[I]; 
end;

end.
