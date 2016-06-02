unit ImageBtn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TImageBtn = class( TCustomControl )
  private
    FBitmapOn   : TBitmap;
    FBitmapOff  : TBitmap;
    FIsOn       : boolean;
    FHRgn       : HRGN;
    FFirstRgn   : boolean;

    procedure   SetBitmapOn( Bmp : TBitmap );
    procedure   SetBitmapOff( Bmp : TBitmap );

    procedure   WMMouseMove( var Message: TMessage ); message WM_MOUSEMOVE;
  protected
    procedure   Paint; override;
  public
    constructor Create( AOwner : TComponent ); override;
    destructor  Destroy; override;

    procedure   SetRgn( Rgn : HRGN );
    procedure   SetState( IsOn : boolean );
  published
    property    BitmapOn   : TBitmap read FBitmapOn write SetBitmapOn;
    property    BitmapOff  : TBitmap read FBitmapOff write SetBitmapOff;
    property    OnClick;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents( 'Scrabble' , [TImageBtn] );
end;

//==============================================================================
// Constructor / destructor
//==============================================================================

constructor TImageBtn.Create( AOwner : TComponent );
begin
  inherited;

  FBitmapOn   := TBitmap.Create;
  FBitmapOff  := TBitmap.Create;
  FIsOn       := false;

  Parent      := TWinControl( AOwner );
  Width       := 105;
  Height      := 105;

  ControlStyle := ControlStyle + [csOpaque];

  FHRgn     := CreateRectRgn( 0 , 0 , 0 , 0 );
  FFirstRgn := true;
  SetRgn( CreateRectRgn( 0 , 0 , 37 , 33 ) );
end;

destructor TImageBtn.Destroy;
begin
  FBitmapOn.Free;
  FBitmapOff.Free;
  inherited;
end;

//==============================================================================
// P R I V A T E
//==============================================================================

procedure TImageBtn.SetBitmapOn( Bmp : TBitmap );
begin
  FBitmapOn.Assign( Bmp );
end;

procedure TImageBtn.SetBitmapOff( Bmp : TBitmap );
begin
  FBitmapOff.Assign( Bmp );
  Repaint;
end;

//==============================================================================
// P R O T E C T E D
//==============================================================================

procedure TImageBtn.Paint;
begin
  if (FIsOn) then
    begin
      if (FBitmapOn <> nil) then
        Canvas.Draw( 0 , 0 , FBitmapOn );
    end
  else
    begin
      if (FBitmapOff <> nil) then
        Canvas.Draw( 0 , 0 , FBitmapOff )
      else
        Canvas.FillRect( ClientRect );
    end;
end;

//==============================================================================
// P U B L I C
//==============================================================================

procedure TImageBtn.WMMouseMove( var Message : TMessage );
begin
  if (FIsOn) then
    begin
      if (PtInRegion( FHRgn , Message.LParamLo , Message.LParamHi ) = FALSE) then
        begin
          ReleaseCapture;
          FIsOn := false;
          Repaint;
        end;
    end
  else
    begin
      SetCapture( Handle );
      FIsOn := true;
      Repaint;
    end;
end;

procedure TImageBtn.SetRgn( Rgn : HRGN );
begin
  SetWindowRgn( Handle , Rgn , FALSE );
  GetWindowRgn( Handle , FHRgn );
end;

procedure TImageBtn.SetState( IsOn : boolean );
begin
  FIsOn := IsOn;
  Repaint;
end;

end.
