program Project;

uses Classes, SysUtils;

type TFile = class
     private
       FFileName   : string;

     public
       constructor Create( FileName : string );
       destructor  Destroy; override;

       procedure   Sort;
     end;

//==============================================================================
// P R I V A T E
//==============================================================================

//==============================================================================
// P U B L I C
//==============================================================================

constructor TFile.Create( FileName : string );
begin
  inherited Create;

  FFileName := FileName;
end;

destructor TFile.Destroy;
begin
  inherited;
end;

procedure TFile.Sort;
var Stream : TFileStream;
    I      : integer;
    J      : integer;
    Count  : integer;
    Min    : integer;
    MinPos : integer;
    First  : integer;
    Number : integer;
begin
  Stream := TFileStream.Create( FFileName , fmOpenReadWrite );
  try
    Count := Stream.Size div 4;
    for I := 0 to Count-1 do
      begin
        Stream.Seek( I*SizeOf( integer ) , soFromBeginning );

        Min    := High( integer );
        MinPos := 0;
        for J := I to Count-1 do
          begin
            Stream.Read( Number , SizeOf( integer ) );

            if (Number < Min) then
              begin
                Min    := Number;
                MinPos := J;
              end;

            if (J = I) then
              First := Number;
          end;

        Stream.Seek( I*SizeOf( integer ) , soFromBeginning );
        Stream.Write( Min , SizeOf( integer ) );

        Stream.Seek( MinPos*SizeOf( integer ) , soFromBeginning );
        Stream.Write( First , SizeOf( integer ) );
      end;
  finally
    Stream.Free;
  end;
end;

//==============================================================================
// Application entry point
//==============================================================================

var Subor : TFile;

begin
  Subor := TFile.Create( 'cisla.txt' );
  try
    Subor.Sort;
  finally
    Subor.Free;
  end;
end.
