unit ClassMapa;

interface

uses ExtCtrls, Classes, Controls, Windows;

type PBod = ^TPoint;
     TMapa = class
     private
       MiniMapa, Mapa : TImage;

       //vlastnosti MiniMapa :
       MiniPozicia : TPoint;
       MiniPolSirka, MiniPolVyska : integer;
       MiniPovodny : TImage;

       //vlastnosti Mapa :
       LavyHorny : TPoint;
       Pozicia : TPoint;
       Povodny : TImage;
       PolSirka, PolVyska : integer;

       Prevod : Integer;

       //metody MiniMapa :
       procedure MiniOnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
       procedure MiniUkazVyber;

       //metody Mapa :
       procedure UkazPolygon;
       procedure UkazVyber;
       procedure MapaOnMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
     public
       //vlastnosti Polygon :
       Body : TList;

       constructor Create( iMiniMapa , iMapa : TImage );
       destructor Destroy; override;

       procedure MiniNastavPoziciu( X , Y : integer );
       procedure NastavPoziciu( X , Y : integer );
     end;

implementation

uses Graphics, Konstanty;

//==============================================================================
//==============================================================================
//
//                                    Constructor
//
//==============================================================================
//==============================================================================

constructor TMapa.Create( iMiniMapa , iMapa : TImage );
begin
  inherited Create;
  Body := TList.Create;
  MiniMapa := iMiniMapa;
  Mapa := iMapa;

  //Mapa
  Povodny := TImage.Create( nil );
  Povodny.Picture.Bitmap.LoadFromFile( MAP_DIR+'Mapa.bmp' );
  Mapa.Picture.Bitmap.Assign( Povodny.Picture.Bitmap );
  PolSirka := Mapa.Width div 2;
  PolVyska := Mapa.Height div 2;
  Mapa.OnMouseDown := MapaOnMouseDown;

  Prevod := Povodny.Picture.Bitmap.Width div MiniMapa.Picture.Bitmap.Width;

  //MiniMapa
  MiniPovodny := TImage.Create( nil );
  MiniPovodny.Picture.Bitmap.Assign( MiniMapa.Picture.Bitmap );
  MiniMapa.OnMouseMove := MiniOnMouseMove;
  MiniPozicia.X := 0;
  MiniPozicia.Y := 0;
  MiniPolSirka := Mapa.Width div (2*Prevod);
  MiniPolVyska := Mapa.Height div (2*Prevod);

  MiniNastavPoziciu( MiniMapa.Width div 2 , MiniMapa.Height div 2 );
end;

//==============================================================================
//==============================================================================
//
//                                     Destructor
//
//==============================================================================
//==============================================================================

destructor TMapa.Destroy;
begin
  Body.Free;
  Povodny.Free;
  MiniPovodny.Free;
  inherited;
end;

//==============================================================================
//==============================================================================
//
//                                   Mini M A P A
//
//==============================================================================
//==============================================================================

procedure TMapa.MiniOnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if not (ssLeft in Shift) then exit;
  MiniNastavPoziciu( X , Y );
end;

procedure TMapa.MiniUkazVyber;
begin
  MiniMapa.Picture.Bitmap.Assign( MiniPovodny.Picture.Bitmap );
  with MiniMapa.Picture.Bitmap.Canvas do
    begin
      Pen.Color := clWhite;
      Brush.Style := bsClear;
      Rectangle( MiniPozicia.X - MiniPolSirka , MiniPozicia.Y - MiniPolVyska ,
                 MiniPozicia.X + MiniPolSirka , MiniPozicia.Y + MiniPolVyska );
    end;
end;

//==============================================================================
//==============================================================================
//
//                                   M A P A
//
//==============================================================================
//==============================================================================

procedure TMapa.UkazPolygon;
var I : integer;
    Points : array[1..100] of TPoint;
begin
  for I := 0 to Body.Count-1 do
    begin
      Points[I+1].X := TPoint( Body[I]^ ).X - LavyHorny.X;
      Points[I+1].Y := TPoint( Body[I]^ ).Y - LavyHorny.Y;
    end;

  with Mapa.Canvas do
    begin
      Pen.Color := clGray;
      Brush.Color := clGray;
      Brush.Style := bsDiagCross;
      Polygon( Slice( Points , Body.Count ) );
    end;
end;

procedure TMapa.UkazVyber;
var Co : TRect;
begin
  with Co do
    begin
      Left := Pozicia.X - PolSirka;
      Right := Pozicia.X + PolSirka;
      Top := Pozicia.Y - PolVyska;
      Bottom := Pozicia.Y + PolVyska;
    end;

  LavyHorny := Co.TopLeft;
  Mapa.Picture.Bitmap.Canvas.CopyRect( Mapa.ClientRect , Povodny.Picture.Bitmap.Canvas , Co );
  UkazPolygon;
end;

procedure TMapa.MapaOnMouseDown( Sender: TObject; Button: TMouseButton;
                                 Shift: TShiftState; X, Y: Integer);
var NovyBod : PBod;
begin
  if (Button = mbRight) then
    begin
      if Body.Count = 0 then exit;
      Dispose( PBod( Body[Body.Count-1] ) );
      Body.Delete( Body.Count-1 );

      UkazVyber;
      exit;
    end;
  if (Button <> mbLeft) then exit;

  GetMem( NovyBod , SizeOf( NovyBod^ ) );
  NovyBod.X := X + LavyHorny.X;
  NovyBod.Y := Y + LavyHorny.Y;
  Body.Add( NovyBod );

  UkazVyber;
end;

//==============================================================================
//==============================================================================
//
//                                I N T E R F A C E
//
//==============================================================================
//==============================================================================

procedure TMapa.MiniNastavPoziciu( X , Y : integer );
begin
  MiniPozicia.X := X;
  MiniPozicia.Y := Y;

  if MiniPozicia.X < MiniPolSirka then MiniPozicia.X := MiniPolSirka;
  if MiniPozicia.Y < MiniPolVyska then MiniPozicia.Y := MiniPolVyska;
  if MiniPozicia.X > (MiniMapa.Width - MiniPolSirka) then MiniPozicia.X := MiniMapa.Width - MiniPolSirka;
  if MiniPozicia.Y > (MiniMapa.Height - MiniPolVyska) then MiniPozicia.Y := MiniMapa.Height - MiniPolVyska;

  MiniUkazVyber;
  NastavPoziciu( MiniPozicia.X*Prevod , MiniPozicia.Y*Prevod );
end;

procedure TMapa.NastavPoziciu( X , Y : integer );
begin
  if X < PolSirka then X := PolSirka;
  if X > Povodny.Picture.Bitmap.Width - PolSirka then
    X := Povodny.Picture.Bitmap.Width - PolSirka;
  if Y < PolVyska then Y := PolVyska;
  if Y > Povodny.Picture.Bitmap.Height - PolVyska then
    Y := Povodny.Picture.Bitmap.Height - PolVyska;

  Pozicia.X := X;
  Pozicia.Y := Y;

  UkazVyber;
end;

end.
