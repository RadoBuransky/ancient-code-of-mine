unit ClassPack;

interface

uses ClassTree;

type TPack = class
     private
       FTree       : TTree;

       procedure   AddWordToTree( Word : string; Tree : TTree );
       function    ReadWord( var F : TextFile ) : string;
       procedure   CreateTree( Src : string );

       procedure   PackTreeToFile( var F : File; Tree : TTree );
       procedure   PackTree( Dest : string );
     public
       constructor Create;
       destructor  Destroy; override;

       procedure   Pack( Src, Dest : string );
     end;

implementation

//==============================================================================
// Constructor/destructor
//==============================================================================

constructor TPack.Create;
begin
  inherited Create;
  FTree := TTree.Create( #0 , false );
end;

destructor TPack.Destroy;
begin
  FTree.Free;
  inherited;
end;

//==============================================================================
// P R I V A T E
//==============================================================================

procedure TPack.AddWordToTree( Word : string; Tree : TTree );
var T : TTree;
    IsWord : boolean;
begin
  T := Tree.GetTreeByData( Word[1] );

  if (Length( Word ) = 1) then
    IsWord := true
  else
    IsWord := false;

  if (T = nil) then
    begin
      T := TTree.Create( Word[1] , IsWord );
      Tree.AddTree( T );
    end
  else
    if (IsWord) then
      T.SetWord( Word[1] );

  if (not IsWord) then
    begin
      Delete( Word , 1 , 1 );
      AddWordToTree( Word , T );
    end;
end;

function TPack.ReadWord( var F : TextFile ) : string;
var C : char;
begin
  Result := '';
  C      := #0;
  while ((not EoF( F )) and
         (C <> #10)) do
    begin
      Read( F , C );
      if (C <> #10) then
        Result := Result + C;
    end;
end;

procedure TPack.CreateTree( Src : string );
var F : TextFile;
    Word : string;
begin
  AssignFile( F , Src );
  Reset( F );

  while (not EoF( F )) do
    begin
      Word := ReadWord( F );
      if (Word = '') then
        break;

      AddWordToTree( Word , FTree );
    end;

  CloseFile( F );
end;

procedure TPack.PackTreeToFile( var F : File; Tree : TTree );
var I : integer;
    B : byte;
begin
  for I := Low( Tree.FLeaves ) to High( Tree.FLeaves ) do
    begin
      B := Tree.FLeaves[I].Pack;

      if (I = High( Tree.FLeaves )) then
        B := B or LAST_FLAG;
        
      BlockWrite( F , B , SizeOf( B ) );
    end;

  for I := Low( Tree.FLeaves ) to High( Tree.FLeaves ) do
    if (Tree.FLeaves[I] <> nil) then
      PackTreeToFile( F , Tree.FLeaves[I] );
end;

procedure TPack.PackTree( Dest : string );
var F : File;
begin
  AssignFile( F , Dest );
  Rewrite( F , 1 );

  PackTreeToFile( F , FTree );

  CloseFile( F );
end;

//==============================================================================
// P U B L I C
//==============================================================================

procedure TPack.Pack( Src, Dest : string );
begin
  CreateTree( Src );
  PackTree( Dest );
end;

end.
