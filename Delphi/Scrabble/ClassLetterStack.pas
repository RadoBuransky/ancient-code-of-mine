unit ClassLetterStack;

interface

uses ClassLetters;

type TStack = array[1..7] of TLetter;

     TLetterStack = class
     private
       FLetters : TLetters;
       FStack   : TStack;
     public
       constructor Create( Letters : TLetters );
       destructor  Destroy; override;

       procedure   PopStack( Letters : array of TLetter );
       procedure   TakeNew;
       procedure   ChangeStack;
       procedure   ChangeSomeLetters( Letters : array of TLetter );

       property    Stack : TStack read FStack;
     end;

implementation

//==============================================================================
// Constructor / destructor
//==============================================================================

constructor TLetterStack.Create( Letters : TLetters );
begin
  inherited Create;
  FLetters := Letters;
end;

destructor TLetterStack.Destroy;
begin
  inherited;
end;

//==============================================================================
// P U B L I C
//==============================================================================

procedure TLetterStack.PopStack( Letters : array of TLetter );
var I, J : integer;
begin
  for I := Low( Letters ) to High( Letters ) do
    for J := Low( FStack ) to High( FStack ) do
      if ((FStack[J].C     = Letters[I].C) and
          (FStack[J].Value = Letters[I].Value)) then
        begin
          FStack[J].C     := #0;
          FStack[J].Value := 0;
          break;
        end;

  for I := Low( FStack ) to High( FStack ) do
    if (FStack[I].C = #0) then
      for J := I+1 to High( FStack ) do
        if (FStack[J].C <> #0) then
          begin
            FStack[I].C     := FStack[J].C;
            FStack[I].Value := FStack[J].Value;

            FStack[J].C     := #0;
            FStack[J].Value := 0;

            break;
          end;
end;

procedure TLetterStack.TakeNew;
var I : integer;
begin
  for I := Low( FStack ) to High( FStack ) do
    if (FStack[I].C = #0) then
      begin
        FStack[I] := FLetters.GetLetter;
        if (FStack[I].C = #0) then
          break;
      end;
end;

procedure TLetterStack.ChangeStack;
var New : TNewLetters;
    I : integer;
begin
  New := FLetters.ChangeLetters( FStack );

  for I := 1 to 7 do
    FStack[I].C := #0;

  for I := 0 to Length( New )-1 do
    FStack[I+1] := New[I];
end;

procedure TLetterStack.ChangeSomeLetters( Letters : array of TLetter );
var New : TNewLetters;
    I, J, K : integer;
begin
  New := FLetters.ChangeLetters( Letters );

  K := 0;
  for I := Low( Letters ) to High( Letters ) do
    for J := Low( FStack )to High( FStack ) do
      if (Letters[I].C = FStack[J].C) then
        begin
          FStack[J] := New[K];
          Inc( K );
          if (K > High( New )) then
            exit
          else
            break;
        end;
end;

end.
