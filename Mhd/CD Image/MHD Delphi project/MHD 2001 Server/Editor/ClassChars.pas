unit ClassChars;

interface

uses Controls, Windows, Classes, Graphics;

const clChar = clBlack;

type PData = ^TData;
     TData = record
       Value : char;

       Start : TPoint;

       Area : integer;

       BMP : TBitmap;
     end;

     TChars = class
     private
       procedure NacitajData( ImageList : TImageList );
       procedure SetStart( PSetData : PData );
       function FindSection( Bmp : TBitmap; X , Y : integer ) : TRect;
       procedure AddData( PNewData : PData );
     public
       Data : TList;

       constructor Create( ImageList : TImageList );
       destructor Destroy; override;
     end;

var Chars : TChars;

implementation

uses SysUtils;

//==============================================================================
//==============================================================================
//
//                                   Constructor
//
//==============================================================================
//==============================================================================

constructor TChars.Create( ImageList : TImageList );
begin
  inherited Create;
  Data := TList.Create;
  NacitajData( ImageList );
end;

//==============================================================================
//==============================================================================
//
//                                   Destructor
//
//==============================================================================
//==============================================================================

destructor TChars.Destroy;
var I : integer;
begin
  for I := 0 to Data.Count-1 do
    Dispose( PData( Data[I] ) );

  Data.Free;

  inherited;
end;

//==============================================================================
//==============================================================================
//
//                                  Ostatne
//
//==============================================================================
//==============================================================================

procedure TChars.SetStart( PSetData : PData );
var I, J : integer;
    B : boolean;
begin
  B := False;
  for I := 0 to PSetData^.BMP.Height-1 do
    begin
      for J := 0 to PSetData^.BMP.Width-1 do
        if PSetData^.BMP.Canvas.Pixels[J,I] = clChar then
          begin
            PSetData^.Start.X := J;
            PSetData^.Start.Y := I;
            B := True;
            break;
          end;
      if (B) then break;
    end;

  PSetData^.Area := 0;
  for I := 0 to PSetData^.BMP.Height-1 do
    for J := 0 to PSetData^.BMP.Width-1 do
      if PSetData^.BMP.Canvas.Pixels[J,I] = clChar then
        Inc( PSetData^.Area );
end;

//==============================================================================
//==============================================================================
//
//                                   Praca so suborom
//
//==============================================================================
//==============================================================================

procedure TChars.NacitajData( ImageList : TImageList );
var I : integer;
    PNewData : PData;
begin
  Data.Clear;
  Data.Capacity := ImageList.Count;
  for I := 0 to ImageList.Count-1 do
    begin
      New( PNewData );
      PNewData^.Value := IntToStr( I )[1];
      PNewData^.BMP := TBitmap.Create;
      ImageList.GetBitmap( I , PNewData^.BMP );

      AddData( PNewData );
    end;
end;

//==============================================================================
//==============================================================================
//
//                                I N T E R F A C E
//
//==============================================================================
//==============================================================================

function TChars.FindSection( Bmp : TBitmap; X , Y : integer ) : TRect;

procedure FloodFill( I , J : integer );
begin
  Bmp.Canvas.Pixels[I,J] := clWhite;

  if I < Result.Left then Result.Left := I;
  if I > Result.Right then Result.Right := I;
  if J < Result.Top then Result.Top := J;
  if J > Result.Bottom then Result.Bottom := J;

  //  Doprava
  if (I < Bmp.Width-1) then
    if (Bmp.Canvas.Pixels[I+1,J] = clChar) then
      FloodFill( I+1 , J );

  //  Dolava
  if (I > 0) then
    if (Bmp.Canvas.Pixels[I-1,J] = clChar) then
      FloodFill( I-1 , J );

  //  Dole
  if (J < Bmp.Height-1) then
    if (Bmp.Canvas.Pixels[I,J+1] = clChar) then
      FloodFill( I , J+1 );

  //  Hore
  if (J > 0) then
    if (Bmp.Canvas.Pixels[I,J-1] = clChar) then
      FloodFill( I , J-1 );

  //  Doprava hore
  if (I < Bmp.Width-1) and
     (J > 0) then
    if (Bmp.Canvas.Pixels[I+1,J-1] = clChar) then
      FloodFill( I+1 , J-1 );

  //  Doprava dole
  if (I < Bmp.Width-1) and
     (J < Bmp.Height-1) then
    if (Bmp.Canvas.Pixels[I+1,J+1] = clChar) then
      FloodFill( I+1 , J+1 );

  //  Dolava dole
  if (I > 0) and
     (J < Bmp.Height-1) then
    if (Bmp.Canvas.Pixels[I-1,J+1] = clChar) then
      FloodFill( I-1 , J+1 );

  //  Dolava hore
  if (I > 0) and
     (J > 0) then
    if (Bmp.Canvas.Pixels[I-1,J-1] = clChar) then
      FloodFill( I-1 , J-1 );
end;

begin
  with Result do
    begin
      Left := X;
      Top := Y;
      Right := X;
      Bottom := Y;
    end;

  FloodFill( X , Y );
end;

procedure TChars.AddData( PNewData : PData );
var Rect : TRect;
    Zal : TBitmap;
begin
  Data.Add( PNewData );
  SetStart( PNewData );

  Zal := TBitmap.Create;
  try
    Zal.Assign( PNewData^.BMP );
    Rect := FindSection( Zal , PNewData^.Start.x , PNewData^.Start.y );
  finally
    Zal.Free;
  end;
  PNewData^.BMP.Width := (Rect.Right-Rect.Left)+1;
  PNewData^.BMP.Height := (Rect.Bottom-Rect.Top)+1;
end;

end.
