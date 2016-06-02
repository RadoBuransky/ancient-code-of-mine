unit lgmPanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, IniFiles;

type
  TGlyphPos    = (gpLeft, gpRight);

  TTitle = class(TPersistent)
  private
    FOwner     : TWinControl;
    FCaption   : String;
    FBGColor,
    FTextColor : TColor;
    FGlyphPos  : TGlyphPos;
    FGlyph     : TBitmap;
  protected
    procedure SetCaption(Value: String);
    procedure SetBGColor(Value: TColor);
    procedure SetTextColor(Value: TColor);
    procedure SetGlyphPos(Value: TGlyphPos);
    procedure SetGlyph(Value: TBitmap);
  public
    constructor Create(aOwner: TWinControl);
    destructor Destroy; override;
  published
    property Caption   : String read FCaption write SetCaption;
    property BGColor   : TColor read FBGColor write SetBGColor;
    property TextColor : TColor read FTextColor write SetTextColor;
    property GlyphPos  : TGlyphPos read FGlyphPos write SetGlyphPos;
    property Glyph     : TBitmap read FGlyph write SetGlyph;
  end;

  TFakeCaption = class(TCustomControl)
  private
    FPaintTitle : procedure of Object;
  protected
    procedure PaintWindow(DC: HDC); override;
  public
    property Canvas;
  end;

  TlgmPanel = class(TCustomPanel)
  private
    FAllowMin,
    FMoveable    : Boolean;
    FTitle       : TTitle;
    FCaption     : TFakeCaption;
    aCaptHeight  : Integer;
    aOldPos      : TRect;
    aIniName     : String;
    aIniFile     : TIniFile;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure PaintTitle;
    procedure Paint; override;
    procedure SetTitle(Values: TTitle);
    procedure SetMoveable(Value: Boolean);
    function GetPanelAlign : TAlign;
    procedure SetPanelAlign(Value: TAlign);
    procedure SetAllowMin(Value: Boolean);
    property Align;
    procedure TitleMouseDown(Sender: TObject;
                             Button: TMouseButton;
                             Shift: TShiftState;
                             X, Y: Integer);
    procedure TitleDblClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Caption;
    procedure Minimize;
    procedure Restore;
  published
    property AlignPanel    : TAlign read GetPanelAlign write SetPanelAlign;
    property AllowMinimize : Boolean read FAllowMin write SetAllowMin;
    property Anchors;
    property Left;
    property Top;
    property Height;
    property Width;
    property Color;
    property Moveable      : Boolean read FMoveable write SetMoveable;
    property Title         : TTitle read FTitle write SetTitle;
  end;

procedure Register;

implementation

constructor TTitle.Create(aOwner: TWinControl);
begin
  inherited Create;
  FOwner := aOwner;
  Caption := '';
  BGColor := clGreen;
  TextColor := clWhite;
  FGlyphPos := gpLeft;
  FGlyph := TBitmap.Create;
end;

destructor TTitle.Destroy;
begin
  FGlyph.Free;
  inherited Destroy;
end;

procedure TTitle.SetCaption(Value: String);
begin
  FCaption := Value;
  FOwner.Repaint;
end;

procedure TTitle.SetBGColor(Value: TColor);
begin
  FBGColor := Value;
  FOwner.Repaint;
end;

procedure TTitle.SetTextColor(Value: TColor);
begin
  FTextColor := Value;
  FOwner.Repaint;
end;

procedure TTitle.SetGlyphPos(Value: TGlyphPos);
begin
  FGlyphPos := Value;
  FOwner.Repaint;
end;

procedure TTitle.SetGlyph(Value: TBitmap);
begin
  FGlyph.Assign(Value);
  FOwner.Repaint;
end;

procedure TFakeCaption.PaintWindow(DC: HDC);
begin
  FPaintTitle;
end;

constructor TlgmPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMoveable := False;
  Caption := '';
  aCaptHeight := GetSystemMetrics(SM_CYSMCAPTION) + 1;
  Height := aCaptHeight + 48;
  aIniName := ChangeFileExt(Application.ExeName, '_lgmPanels.ini');
  FTitle := TTitle.Create(TWinControl(Self));
  FCaption := TFakeCaption.Create(Self);
  with FCaption do
  begin
    Parent := Self;
    FPaintTitle := PaintTitle;
    Align := alTop;
    Height := aCaptHeight;
    OnMouseDown := TitleMouseDown;
    OnDblClick := TitleDblClick;
  end;
end;

destructor TlgmPanel.Destroy;
begin
  if FMoveable and not (csDesigning in ComponentState) then
  Try
    aIniFile := TIniFile.Create(aIniName);
    with aIniFile do
    begin
      WriteInteger(Name, 'Left', Left);
      WriteInteger(Name, 'Top', Top);
    end;
  Finally
    aIniFile.Free;
  end;
  FTitle.Free;
  FCaption.Free;
  inherited Destroy;
end;

procedure TlgmPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW or WS_EX_STATICEDGE;
  if FMoveable and not (csDesigning in ComponentState) then
  Try
    aIniFile := TIniFile.Create(aIniName);
    with aIniFile do
    begin
      Params.X := ReadInteger(Name, 'Left', Params.X);
      Params.Y := ReadInteger(Name, 'Top', Params.Y);
    end;
  Finally
    aIniFile.Free;
  end;
  with aOldPos do
  begin
    Left := Params.X;
    Top := Params.Y;
    Right := Params.Width;
    Bottom := Params.Height;
  end;
end;

procedure TlgmPanel.PaintTitle;

var
  X       : Integer;
  Rect    : TRect;

begin
  with Rect do
  begin
    Left := 0;
    Top := 0;
    Right := Width - 4;
    Bottom := aCaptHeight - 1;
  end;
  with FCaption.Canvas do
  begin
    Lock;
    Brush.Color := FTitle.BGColor;
    FillRect(Rect);
    X := 5;
    with FTitle do
      if not FGlyph.Empty then
        if FGlyphPos = gpLeft then
          begin
            X := FGlyph.Width + 5;
            Draw(3, 2, FGlyph);
          end
        else
          Draw(Width - FGlyph.Width - 5, 2, FGlyph);
    TextFlags := ETO_OPAQUE;
    Font.Color := FTitle.TextColor;
    TextOut(X, 1, FTitle.Caption);
    UnLock;
  end;
end;

procedure TlgmPanel.SetTitle(Values: TTitle);
begin
  FTitle := Values;
end;

procedure TlgmPanel.SetMoveable(Value: Boolean);
begin
  FMoveable := Value;
  if Value then
  begin
    Align := alNone;
    AllowMinimize := False;
  end;
end;

procedure TlgmPanel.Minimize;
begin
  TitleDblClick(Nil);
end;

procedure TlgmPanel.Restore;
begin
  TitleDblClick(Nil);
end;

function TlgmPanel.GetPanelAlign : TAlign;
begin
  Result := Align;
end;

procedure TlgmPanel.SetPanelAlign(Value: TAlign);
begin
  Align := Value;
  if Value <> alNone then
  begin
    Moveable := False;
    AllowMinimize := False;
  end;
end;

procedure TlgmPanel.SetAllowMin(Value: Boolean);
begin
  FAllowMin := Value;
  if Value then
  begin
    Moveable := False;
    AlignPanel := alNone;
  end;
end;

procedure TlgmPanel.Paint;
begin
  inherited Paint;
  PaintTitle;
end;

procedure TlgmPanel.TitleMouseDown(Sender: TObject;
                                   Button: TMouseButton;
                                   Shift: TShiftState;
                                   X, Y: Integer);
begin
  if FMoveable and (Button = mbLeft) then
  begin
    ReleaseCapture;
    Self.Perform(WM_SYSCOMMAND, $F012, 1);  //  Undocumented magic numbers
  end;
end;

procedure TlgmPanel.TitleDblClick(Sender: TObject);

var Y : Integer;

begin
  if (AlignPanel <> alNone) or (csDesigning in ComponentState) then
    Exit;
  if (Left = aOldPos.Left) and (Top = aOldPos.Top) then
    if FAllowMin then
      begin
        if Parent is TlgmPanel then
          Y := 4
        else
          Y := 24;
        Height := aCaptHeight;
        Top := Parent.Height - aCaptHeight - Y;
      end
    else
  else
    begin
      Left := aOldPos.Left;
      Top := aOldPos.Top;
      Height := aOldPos.Bottom;
    end;
end;

procedure Register;
begin
  RegisterComponents('LGM', [TlgmPanel]);
end;

end.
