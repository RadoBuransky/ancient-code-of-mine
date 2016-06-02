unit ClassNewImage;

interface

uses Controls, Classes, ExtCtrls, Messages, Graphics;

type TNewImage = class( TImage )
     private
       FAutoChange : boolean;
       FAllowPress : boolean;
       FBitmapOn : TBitmap;
       FBitmapOff : TBitmap;
       FPressed : boolean;

       FOnMouseEnter : TNotifyEvent;
       FOnMouseLeave : TNotifyEvent;

       procedure SetBitmapOn( Bitmap : TBitmap );
       procedure SetBitmapOff( Bitmap : TBitmap );
       procedure SetPressed( Value : boolean );

       procedure Enter( var Message : TMessage ); message CM_MOUSEENTER;
       procedure Leave( var Message : TMessage ); message CM_MOUSELEAVE;
     protected
       procedure Click( var Message : TMessage ); reintroduce; message WM_LBUTTONDOWN;
     public
       constructor Create( AOwner : TComponent ); override;
       destructor Destroy; override;
     published
       property AutoChange : boolean read FAutoChange write FAutoChange default FALSE;
       property AllowPress : boolean read FAllowPress write FAllowPress default FALSE;
       property BitmapOn : TBitmap read FBitmapOn write SetBitmapOn;
       property BitmapOff : TBitmap read FBitmapOff write SetBitmapOff;
       property Pressed : boolean read FPressed write SetPressed default FALSE;

       property OnMouseEnter : TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
       property OnMouseLeave : TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
     end;

procedure Register;

implementation

//==============================================================================
//==============================================================================
//
//                                  Register
//
//==============================================================================
//==============================================================================

procedure Register;
begin
  RegisterComponents( 'My' , [TNewImage] );
end;

//==============================================================================
//==============================================================================
//
//                                  Constructor
//
//==============================================================================
//==============================================================================

constructor TNewImage.Create( AOwner : TComponent );
begin
  inherited;
  FBitmapOn := TBitmap.Create;
  FBitmapOff := TBitmap.Create
end;

//==============================================================================
//==============================================================================
//
//                                  Destructor
//
//==============================================================================
//==============================================================================

destructor TNewImage.Destroy;
begin
  FBitmapOff.Free;
  FBitmapOn.Free;
  inherited;
end;

//==============================================================================
//==============================================================================
//
//                                  Events
//
//==============================================================================
//==============================================================================

procedure TNewImage.Enter( var Message : TMessage );
begin
  if (AutoChange) and not
     (Pressed) then
    Picture.Bitmap := FBitmapOn;
  inherited;
  if Assigned( FOnMouseEnter ) then
    FOnMouseEnter( Self );
end;

procedure TNewImage.Leave( var Message : TMessage );
begin
  if (AutoChange) and not
     (Pressed) then
    Picture.Bitmap := FBitmapOff;
  inherited;
  if Assigned( FOnMouseLeave ) then
    FOnMouseLeave( Self );
end;

procedure TNewImage.Click( var Message : TMessage );
begin
  if (AllowPress) then Pressed := not Pressed;
  inherited;
end;

procedure TNewImage.SetBitmapOn( Bitmap : TBitmap );
begin
  FBitmapOn.Assign( Bitmap );
end;

procedure TNewImage.SetBitmapOff( Bitmap : TBitmap );
begin
  FBitmapOff.Assign( Bitmap );
  Picture.Bitmap.Assign( Bitmap );
end;

procedure TNewImage.SetPressed( Value : boolean );
begin
  if not AllowPress then exit;

  FPressed := Value;
  if FPressed then Picture.Bitmap := FBitmapOn
              else Picture.Bitmap := FBitmapOff;
end;

end.
