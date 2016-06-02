unit ClassWords;

interface

const IS_WORD_FLAG   = 32;
      LAST_FLAG      = 64;
      HAS_CHILD_FLAG = 128;
      CHAR_MASK      = 31;
      END_OF_WORDS   = 'END OF WORDS';

type TWordsCallback = function( Word : string ) : boolean of object;

     TWordsStr = array of string;

     TWords = class
     private
       FFileName   : string;
       FCallback   : TWordsCallback;
       FWords      : array of string;
       FEndSearch  : boolean;

       procedure   UnpackWords( var F : File; Word : string );
       procedure   GetAllWords( Callback : TWordsCallback );
       function    FindWord( Word : string ) : boolean;
     public
       constructor Create( FileName : string );
       destructor  Destroy; override;

       procedure   ExistWords( Words : array of string; var Result : TWordsStr );
       procedure   AllWords( Callback : TWordsCallback );
     end;

implementation

uses Forms, Controls, Windows;

//==============================================================================
// Constructor / destructor
//==============================================================================

constructor TWords.Create( FileName : string );
begin
  inherited Create;
  FFileName   := FileName;
  FCallback   := nil;
  FWords      := nil;
  FEndSearch  := false;
end;

destructor TWords.Destroy;
begin
  inherited;
end;

//==============================================================================
// P R I V A T E
//==============================================================================

procedure TWords.UnpackWords( var F : File; Word : string );
var B : byte;
    C : char;
    Last : boolean;
    Chars : array of record
                       C : char;
                       HasChildren : boolean;
                     end;
    I : integer;
begin
  if (FEndSearch) then
    exit;

  Last := false;
  SetLength( Chars , 0 );
  repeat
    BlockRead( F , B , 1 );

    C := char((B and CHAR_MASK) + Ord( 'a' ));

    SetLength( Chars , Length( Chars )+1 );
    Chars[Length( Chars )-1].C := C;

    if ((B and HAS_CHILD_FLAG) <> 0) then
      Chars[Length( Chars )-1].HasChildren := true
    else
      Chars[Length( Chars )-1].HasChildren := false;

    if ((B and IS_WORD_FLAG) <> 0) then
      if (Assigned( FCallback )) then
        if (FCallback( Word + C )) then
          FEndSearch := true;

    if ((B and LAST_FLAG) <> 0) then
      Last := true;
  until Last;

  for I := 0 to Length( Chars )-1 do
    if (Chars[I].HasChildren) then
      UnpackWords( F , Word + Chars[I].C );
end;

procedure TWords.GetAllWords( Callback : TWordsCallback );
var F : File;
begin
  FCallback := Callback;
  if (not Assigned( FCallback )) then
    exit;

  AssignFile( F , FFileName );
  Reset( F , 1 );

  FEndSearch := false;
  UnpackWords( F , '' );
  FCallback( END_OF_WORDS );

  CloseFile( F );
end;

function TWords.FindWord( Word : string ) : boolean;
var I : integer;
begin
  Result := true;
  for I := 0 to Length( FWords )-1 do
    if (FWords[I] = Word) then
      FWords[I] := ''
    else
      if (FWords[I] <> '') then
        Result := false;
end;

//==============================================================================
// P U B L I C
//==============================================================================

procedure TWords.ExistWords( Words : array of string; var Result : TWordsStr );
var I, J : integer;
    C : TCursor;
begin
  C             := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    if (Length( Words ) = 0) then
      begin
        SetLength( Result , 0 );
        exit;
      end;

    SetLength( FWords , Length( Words ) );
    for I := 0 to Length( Words )-1 do
      begin
        SetLength( FWords[I] , Length( Words[I] ) );
        FWords[I] := Words[I];
      end;

    FEndSearch  := false;

    GetAllWords( FindWord );

    J := 0;
    for I := 0 to Length( FWords )-1 do
      if (FWords[I] <> '') then
        Inc( J );

    SetLength( Result , J );

    J := 0;
    for I := 0 to Length( FWords )-1 do
      if (FWords[I] <> '') then
        begin
          SetLength( Result[J] , Length( FWords[I] ) );
          Result[J] := FWords[I];
          Inc( J );
        end;
  finally
    Screen.Cursor := C;
  end;
end;

procedure TWords.AllWords( Callback : TWordsCallback );
var C : TCursor;
begin
  if (not Assigned( Callback )) then
    exit;
  C             := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    GetAllWords( Callback );
  finally
    Screen.Cursor := C;
  end;
end;

end.
