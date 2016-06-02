unit ClassFile;

interface

uses ClassStack, Classes, SysUtils;

type TFile = class
     private
       Stack     : TStack;

       function    ReadItem( F : TFileStream ) : TStackItem;
       procedure   ReadFromFile( FileName : string );
       procedure   WriteItem( F : TFileStream; Item : TStackItem );
       procedure   WriteToFile( FileName : string );

     public
       constructor Create;
       destructor  Destroy; override;

       procedure   CreateDictionary( FileNameIn, FileNameOut : string );
     end;

implementation

constructor TFile.Create;
begin
  inherited;

  Stack := TStack.Create;
end;

destructor TFile.Destroy;
begin
  Stack.Free;

  inherited;
end;

//==============================================================================
// P R I V A T E
//==============================================================================

// Read one item from file (both slovak and english words)
function TFile.ReadItem( F : TFileStream ) : TStackItem;
var Count   : integer;
    English : string;
    Slovak  : string;
begin
  // Read slovak word
  F.Read( Count , SizeOf( Count ) );
  SetLength( Slovak , Count );
  F.Read( Slovak[1] , Count );

  // Read english word
  F.Read( Count , SizeOf( Count ) );
  SetLength( English , Count );
  F.Read( English[1] , Count );

  Result := TStackItem.Create( English , Slovak , nil );
end;

// Read all items from file and push them into the stack
procedure TFile.ReadFromFile( FileName : string );
var F : TFileStream;
begin
  F := TFileStream.Create( FileName , fmOpenRead );
  try
    while (F.Position < F.Size) do
      Stack.Push( ReadItem( F ) );
  finally
    F.Free;
  end;
end;

// Write one item to file
procedure TFile.WriteItem( F : TFileStream; Item : TStackItem );
var Count : integer;
begin
  // Write slovak word
  Count := Length( Item.English );
  F.Write( Count , SizeOf( Count ) );
  F.Write( Item.English[1] , Count );

  // Write english word
  Count := Length( Item.Slovak );
  F.Write( Count , SizeOf( Count ) );
  F.Write( Item.Slovak[1] , Count );
end;

// Write all items to file and empty stack
procedure TFile.WriteToFile( FileName : string );
var F : TFileStream;
    S : TStackItem;
begin
  F := TFileStream.Create( FileName , fmCreate );
  try
    S := Stack.Pop;

    while (S <> nil) do
      begin
        WriteItem( F , S );
        S.Free;
        S := Stack.Pop;
      end;

  finally
    F.Free;
  end;
end;

//==============================================================================
// P U B L I C
//==============================================================================

procedure TFile.CreateDictionary( FileNameIn, FileNameOut : string );
begin
  ReadFromFile( FileNameIn );
  WriteToFile( FileNameOut );
end;

end.
