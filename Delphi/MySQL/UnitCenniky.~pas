unit UnitCenniky;

interface

uses UnitCennik, ClassUpdate;

type TCenniky = class
     private
       FOldData    : TCennikData;
       FNewData    : TCennikData;
       FDir        : string;

       procedure   LoadFromDirectory( Dir : string );
       function    GetUnusedName( Data : PCennikData ) : string;

     public
       constructor Create( Dir : string );
       destructor  Destroy; override;

       procedure   AddTable( FriendlyName : string );                    // Adds table
       procedure   DeleteTable( Index : integer );                       // Deletes table
       procedure   Update;                                               // Updates all tables to server
       procedure   DeleteOld;                                            // Deletes all old data
       procedure   ExportToFile( FileName : string );

       property    Data : TCennikData read FNewData;
     end;

implementation

uses SysUtils, DB;

// Constructor
constructor TCenniky.Create( Dir : string );
begin
  inherited Create;

  SetLength( FOldData , 0 );
  SetLength( FNewData , 0 );

  CreateDir( Dir );
  FDir := Dir;

  LoadFromDirectory( Dir );
end;

// Destructor
destructor TCenniky.Destroy;
var I : integer;
begin
  for I := 0 to Length( FOldData )-1 do
    FOldData[I].Destroy;
  SetLength( FOldData , 0 );

  for I := 0 to Length( FNewData )-1 do
    FNewData[I].Destroy;
  SetLength( FNewData , 0 );

  inherited;
end;

//==============================================================================
//  P R I V A T E
//==============================================================================

// Loads data from file to data
procedure TCenniky.LoadFromDirectory( Dir : string );
var SR : TSearchRec;
    I : integer;
    Count : integer;
begin
  // Get count of old data files
  Count := 0;
  if (FindFirst( Dir+'\*'+OLD_CENNIK_EXT , faAnyFile , SR ) = 0) then
    repeat
      Inc( Count );
    until (FindNext( SR ) <> 0);
  FindClose( SR );

  // Get old data
  I := 0;
  SetLength( FOldData , Count );
  if (FindFirst( Dir+'\*'+OLD_CENNIK_EXT , faAnyFile , SR ) = 0) then
    repeat
      FOldData[I] := TCennik.Create( '' , '' , Dir+'\'+SR.Name );
      Inc( I );
    until (FindNext( SR ) <> 0);
  FindClose( SR );

  // Get count of new data files
  Count := 0;
  if (FindFirst( Dir+'\*'+NEW_CENNIK_EXT , faAnyFile , SR ) = 0) then
    repeat
      Inc( Count );
    until (FindNext( SR ) <> 0);
  FindClose( SR );

  // Get new data
  I := 0;
  SetLength( FNewData , Count );
  if (FindFirst( Dir+'\*'+NEW_CENNIK_EXT , faAnyFile , SR ) = 0) then
    repeat
      FNewData[I] := TCennik.Create( '' , '' , Dir+'\'+SR.Name );
      Inc( I );
    until (FindNext( SR ) <> 0);
  FindClose( SR );
end;

function TCenniky.GetUnusedName( Data : PCennikData ) : string;
var I, J : integer;
    Found : boolean;
begin
  for I := 0 to 100 do
    begin
      Found := false;
      for J := 0 to Length( Data^ )-1 do
        if (Data^[J].Name = 'Table' + IntToStr( I )) then
          begin
            Found := true;
            break;
          end;
      if not (Found) then
        begin
          Result := 'Table' + IntToStr( I );
          break;
        end;
    end;
end;

//==============================================================================
//  P U B L I C
//==============================================================================

// Adds table
procedure TCenniky.AddTable( FriendlyName : string );
var Name : string;
begin
  Name := GetUnusedName( @FNewData );

  SetLength( FNewData , Length( FNewData )+1 );
  FNewData[Length( FNewData )-1] := TCennik.Create( FriendlyName , Name , FDir+'\'+Name+NEW_CENNIK_EXT );
end;

// Deletes table
procedure TCenniky.DeleteTable( Index : integer );
var F : TextFile;
    I : integer;
    FileName : string;
begin
  // Backup file name
  FileName := FNewData[Index].FileName;

  // Free memory
  FNewData[Index].Destroy;

  // Delete file
  AssignFile( F , FileName );
  Erase( F );

  // Remove from the list
  for I := Index to Length( FNewData )-2 do
    FNewData[I] := FNewData[I+1];
  SetLength( FNewData , Length( FNewData )-1 );
end;

procedure TCenniky.Update;
begin

{  with TUpdate.Create( 'db.host.sk' , 'pcprompt' , 'evjlls' , 'pcprompt' , 3306 , FDir ) do
    Update( @FOldData , @FNewData );}

{  with TUpdate.Create( 'r6a4t8' , 'rburansky' , 'evjlls' , 'pcprompt' , 3306 , FDir ) do
    Update( @FOldData , @FNewData );}

  with TUpdate.Create( 'sultan.webpriestor.sk' , 'pcpromptsk' , '6ep2h4te' , 'pcpromptsk' , 3306 , FDir ) do
    Update( @FOldData , @FNewData );
end;

// Deletes all old data
procedure TCenniky.DeleteOld;
var F : TextFile;
    I : integer;
    FileName : string;
begin
  for I := 0 to Length( FOldData )-1 do
    begin
      // Backup file name
      FileName := FOldData[I].FileName;

      // Free memory
      FOldData[I].Destroy;

      // Delete file
      AssignFile( F , FileName );
      Erase( F );
    end;

  SetLength( FOldData , 0 );
end;

procedure TCenniky.ExportToFile( FileName : string );
var F : TextFile;
    I, J, K : integer;
begin
  AssignFile( F , FileName );
  Rewrite( F );

  for I := 0 to Length( FNewData )-1 do
    begin
      Write( F , '@' );
      Write( F , FNewData[I].FriendlyName );
      Write( F , '|' );
      Write( F , IntToStr( FIELDS_MAX ) );
      Write( F , '|' );
      Write( F , IntToStr( Length( FNewData[I].Data ) ) );
      Write( F , '|' );

      for J := 0 to Length( FNewData[I].Data )-1 do
        for K := 0 to FIELDS_MAX-1 do
          begin
            if (FNewData[I].Data[J,K] = '') then
              Write( F , ' ' )
            else
              Write( F , FNewData[I].Data[J,K] );

            Write( F , '|' );
          end;
    end;
  Write( F , '%' );

  CloseFile( F );
end;

end.
