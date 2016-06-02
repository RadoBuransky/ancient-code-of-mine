unit ClassSubWin;

interface

uses Classes, Controls, Messages, ClassNewImage;

type TWinType = (wtNone,wtLeft,wtRight,wtTop,wtBottom);

     TSubWin = class(TCustomControl)
     private
       CloseBtn : TNewImage;
       TypeChanging : boolean;

       FWinType : TWinType;
       procedure SetWinType( NewWinType : TWinType );

       procedure WinPosChanging( var Message : TWMWindowPosChanging ); message WM_WINDOWPOSCHANGING;
     protected
       procedure Paint; override;
     public
       constructor Create( AOwner : TComponent ); override;
       destructor Destroy; override;
     published
       property WinType : TWinType read FWinType write SetWinType default wtNone;
     end;

procedure Register;

implementation

{$R *.RES}

uses Graphics;

//==============================================================================
//==============================================================================
//
//                                 Constructor
//
//==============================================================================
//==============================================================================

constructor TSubWin.Create( AOwner : TComponent );
begin
  inherited;
  CloseBtn := TNewImage.Create( Self );
  CloseBtn.Parent := Self;

  CloseBtn.Width := 15;
  CloseBtn.Height := CloseBtn.Width;

  CloseBtn.BitmapOn.LoadFromResourceName( HInstance , 'CLOSE_ON' );
  CloseBtn.BitmapOff.LoadFromResourceName( HInstance , 'CLOSE_OFF' );
  CloseBtn.AutoChange := True;
  CloseBtn.Picture.Bitmap.Assign( CloseBtn.BitmapOff );

  Anchors := [akLeft,akTop];

  TypeChanging := False;

  Height := 100;
  Width := 100;
end;

//==============================================================================
//==============================================================================
//
//                                  Destructor
//
//==============================================================================
//==============================================================================

destructor TSubWin.Destroy;
begin
  CloseBtn.Free;
  inherited;
end;

//==============================================================================
//==============================================================================
//
//                                  Events
//
//==============================================================================
//==============================================================================

procedure TSubWin.Paint;
begin
  with Canvas do
    begin
      Pen.Color := clBlack;
      Brush.Color := clBtnFace;
      Rectangle( 0 , 0 , Width , Height );
    end;
  inherited;
  CloseBtn.Left := Self.ClientWidth - CloseBtn.Width - 5;
  CloseBtn.Top := 5;
end;

procedure TSubWin.WinPosChanging( var Message : TWMWindowPosChanging );
begin
  if (WinType <> wtNone) and
     (ControlState*[csCreating] = []) and
     (not TypeChanging) then
    begin
      Message.WindowPos^.x := Left;
      Message.WindowPos^.y := Top;
    end;
end;

procedure TSubWin.SetWinType( NewWinType : TWinType );
var I : integer;
    Exist : array[0..3] of TControl;
begin
  FWinType := NewWinType;
  if NewWinType = wtNone then
    begin
      Anchors := [];
      exit;
    end;

  TypeChanging := True;

  for I := 0 to 3 do
    Exist[I] := nil;

  for I := 0 to Parent.ControlCount-1 do
    if (Parent.Controls[I] is TSubWin) and
       (Parent.Controls[I] <> Self) then
      begin
        case (Parent.Controls[I] as TSubWin).WinType of
          wtLeft : Exist[0] := Parent.Controls[I];
          wtBottom : Exist[1] := Parent.Controls[I];
          wtRight : Exist[2] := Parent.Controls[I];
          wtTop : Exist[3] := Parent.Controls[I];
        end;
        if (Parent.Controls[I] as TSubWin).WinType = NewWinType then
          FWinType := wtNone;
      end;

  case FWinType of
    wtLeft : begin
               Left := 3;
               Top := 3;
               if Exist[1] = nil then Height := (Parent.ClientHeight-6)
                                 else Height := Exist[1].Top-2*Top;
             end;
    wtBottom : begin
                 Anchors := [];
                 Left := 3;
                 Top := Parent.ClientHeight-3-Height;
               end;
    wtRight : begin
                Top := 3;
                Left := Parent.ClientWidth-Top-Width;
                if Exist[1] = nil then Height := (Parent.ClientHeight-6)
                                  else Height := Exist[1].Top-2*Top;
              end;
    wtTop : begin
              Top := 3;
              if Exist[0] = nil then Left := 3
                                else Left := Exist[0].Left+Exist[0].Width+3;
              if Exist[2] <> nil then Width := Exist[2].Left-Left-3;
            end;
  end;
  TypeChanging := False;
end;

//==============================================================================
//==============================================================================
//
//                                   Register
//
//==============================================================================
//==============================================================================

procedure Register;
begin
  RegisterComponents( 'Samples' , [TSubWin] );
end;

end.
