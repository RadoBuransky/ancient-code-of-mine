unit ClassUpdates;

interface

uses Classes, ComCtrls, SKonstanty;

type TUpdateItem = class
     private
       procedure LoadFromFile( InfoFile : string );
       procedure LoadListkyFromFile( ListkyFile : string );

       procedure SaveToFile;
       procedure SaveListkyToFile;
     public
       FileName : string;
       ListkyFileName : string;

       Title : string;

       Datum : string;
       ZastavkyFile : string;
       RozvrhyFiles : TStringList;
       Listky : TTickets;

       procedure Save;

       constructor Create( InfoFile : string );
       destructor Destroy; override;
     end;





     TUpdates = class
     private
       FOnTreeChange : TNotifyEvent;
       FActive : integer;

       procedure LoadAllUpdates;
       procedure SaveAllUpdates;
     public
       Items : TList;

       constructor Create;
       destructor Destroy; override;

       procedure CreateItem( FileName : string; Day, Month, Year : integer );
       procedure DeleteItem( Item : TUpdateItem );

       property OnTreeChange : TNotifyEvent read FOnTreeChange write FOnTreeChange;
       property Active : integer read FActive write FActive;
     end;

var Updates : TUpdates;

implementation

uses IniFiles, SysUtils;

//==============================================================================
//==============================================================================
//
//                           U P D A T E    I T E M S
//
//==============================================================================
//==============================================================================

//==============================================================================
//                                  Constructor
//==============================================================================

constructor TUpdateItem.Create( InfoFile : string );
begin
  inherited Create;
  RozvrhyFiles := TStringList.Create;
  LoadFromFile( InfoFile );
end;

//==============================================================================
//                                  Destructor
//==============================================================================

destructor TUpdateItem.Destroy;
begin
  RozvrhyFiles.Free;
  inherited;
end;

//==============================================================================
//                                  Files
//==============================================================================

procedure TUpdateItem.LoadListkyFromFile( ListkyFile : string );
var IniFile : TIniFile;
    Sections : TStringList;
    I : integer;
begin
  ListkyFileName := ListkyFile;

  SetLength( Listky , 0 );
  if (ListkyFile = '') then exit;

  IniFile := TIniFile.Create( ListkyFile );
  try
    Sections := TStringList.Create;
    try
      IniFile.ReadSections( Sections );
      SetLength( Listky , Sections.Count );
      for I := 0 to Sections.Count-1 do
        begin
          Listky[I].Min := StrToInt( Sections[I] );
          Listky[I].Norm := StrToInt( IniFile.ReadString( Sections[I] , 'Norm' , '' ) );
          Listky[I].Zlav := StrToInt( IniFile.ReadString( Sections[I] , 'Zlav' , '' ) );
        end;
    finally
      Sections.Free;
    end;
  finally
    IniFile.Free;
  end;
end;

procedure TUpdateItem.LoadFromFile( InfoFile : string );
var IniFile : TIniFile;
    I : integer;
    S : string;
begin
  FileName := InfoFile;

  IniFile := TIniFile.Create( InfoFile );
  try
    Datum := IniFile.ReadString( 'Datum' , 'Datum' , '??.??.????' );
    ZastavkyFile := IniFile.ReadString( 'Zastavky' , 'File' , '' );
    LoadListkyFromFile( IniFile.ReadString( 'Listky' , 'File' , '' ) );
    IniFile.ReadSectionValues( 'Rozvrhy' , RozvrhyFiles );
    for I := 0 to RozvrhyFiles.Count-1 do
      begin
        S := RozvrhyFiles[I];
        Delete( S , 1 , Pos( '=' , S ) );
        RozvrhyFiles[I] := S;
      end;
  finally
    IniFile.Free;
  end;
end;

procedure TUpdateItem.SaveToFile;
var IniFile : TIniFile;
    Sections : TStringList;
    I : integer;
begin
  IniFile := TIniFile.Create( FileName );
  try
    Sections := TStringList.Create;
    try
      IniFile.ReadSections( Sections );
      for I := 0 to Sections.Count-1 do
        IniFile.EraseSection( Sections[I] );
    finally
      Sections.Free;
    end;

    IniFile.WriteString( 'Datum' , 'Datum' , Datum );
    IniFile.WriteString( 'Zastavky' , 'File' , ZastavkyFile );
    IniFile.WriteString( 'Listky' , 'File' , ListkyFileName );
    IniFile.WriteString( 'Rozvrhy' , 'File1' , '' );

    for I := 0 to RozvrhyFiles.Count-1 do
      IniFile.WriteString( 'Rozvrhy' , 'File'+IntToStr(I+1) , RozvrhyFiles[I] );
  finally
    IniFile.Free;
  end;
end;

procedure TUpdateItem.SaveListkyToFile;
var IniFile : TIniFile;
    Sections : TStringList;
    I : integer;
begin
  if (ListkyFileName = '') then ListkyFileName := ExtractFilePath( FileName )+'Listky.ini';

  IniFile := TIniFile.Create( ListkyFileName );
  try
    Sections := TStringList.Create;
    try
      IniFile.ReadSections( Sections );
      for I := 0 to Sections.Count-1 do
        IniFile.EraseSection( Sections[I] );
    finally
      Sections.Free;
    end;

    for I := 0 to Length( Listky )-1 do
      begin
        IniFile.WriteString( IntToStr( Listky[I].Min ) , 'Norm' , IntToStr( Listky[I].Norm ) );
        IniFile.WriteString( IntToStr( Listky[I].Min ) , 'Zlav' , IntToStr( Listky[I].Zlav ) ); 
      end;
  finally
    IniFile.Free;
  end;
end;

procedure TUpdateItem.Save;
begin
  SaveListkyToFile;
  SaveToFile;
end;

//==============================================================================
//==============================================================================
//
//                                U P D A T E S
//
//==============================================================================
//==============================================================================

//==============================================================================
//                                  Constructor
//==============================================================================

constructor TUpdates.Create;
begin
  inherited;
  Items := TList.Create;
  LoadAllUpdates;
  if (Assigned( OnTreeChange )) then OnTreeChange( Self );
end;

//==============================================================================
//                                  Destructor
//==============================================================================

destructor TUpdates.Destroy;
var I : integer;
begin
  SaveAllUpdates;
  for I := 0 to Items.Count-1 do
    TUpdateItem( Items[I] ).Free;
  Items.Free;
  inherited;
end;

//==============================================================================
//                                  Praca so subormi
//==============================================================================

procedure TUpdates.LoadAllUpdates;
var IniFile : TIniFile;
    Sections : TStringList;
    I : integer;
begin
  IniFile := TIniFile.Create( UPDATES_FILE );
  try
    Sections := TStringList.Create;
    try
      IniFile.ReadSections( Sections );
      for I := 0 to Sections.Count-1 do
        begin
          Items.Add( TUpdateItem.Create( IniFile.ReadString( Sections[I] , 'UpdateInfo' , '' ) ) );
          TUpdateItem( Items[I] ).Title := Sections[I];
        end;
    finally
      Sections.Free;
    end;
  finally
    IniFile.Free;
  end;
end;

procedure TUpdates.SaveAllUpdates;
var IniFile : TIniFile;
    Sections : TStringList;
    I : integer;
begin
  IniFile := TIniFile.Create( UPDATES_FILE );
  try
    Sections := TStringList.Create;
    try
      IniFile.ReadSections( Sections );
      for I := 0 to Sections.Count-1 do
        IniFile.EraseSection( Sections[I] );
    finally
      Sections.Free;
    end;

    for I := 0 to Items.Count-1 do
      IniFile.WriteString( TUpdateItem( Items[I] ).Title , 'UpdateInfo' , TUpdateItem( Items[I] ).FileName );
  finally
    IniFile.Free;
  end;
end;

procedure TUpdates.CreateItem( FileName : string; Day, Month, Year : integer );
var IniFile : TIniFile;
    FormatDate : string;
    I : integer;
    Sections : TStringList;
begin
  FormatDate := '';

  if (Day < 10) then FormatDate := '0';
  FormatDate := FormatDate + IntToStr( Day );

  if (Month < 10) then FormatDate := FormatDate + '0';
  FormatDate := FormatDate + IntToStr( Month );

  FormatDate := FormatDate + IntToStr( Year );

  IniFile := TIniFile.Create( FileName );
  try
    Sections := TStringList.Create;
    try
      IniFile.ReadSections( Sections );
      for I := 0 to Sections.Count-1 do
        IniFile.EraseSection( Sections[I] );
    finally
      Sections.Free;
    end;
    IniFile.WriteString( 'Datum' , 'Datum' , FormatDate );
    IniFile.WriteString( 'Zastavky' , 'File' , '' );
    IniFile.WriteString( 'Listky' , 'File' , '' );
    IniFile.WriteString( 'Rozvrhy' , 'File1' , '' );
  finally
    IniFile.Free;
  end;

  I := Items.Add( TUpdateItem.Create( FileName ) );
  TUpdateItem( Items[I] ).Title := IntToStr( Day )+'.'+IntToStr( Month )+'.'+IntToStr( Year );

  if (Assigned( OnTreeChange )) then OnTreeChange( Self );
end;

procedure TUpdates.DeleteItem( Item : TUpdateItem );
var I : integer;
begin
  I := Items.IndexOf( Item );
  TUpdateItem( Items[I] ).Free;
  Items.Delete( I );

  if (Assigned( OnTreeChange )) then OnTreeChange( Self );
end;

end.
