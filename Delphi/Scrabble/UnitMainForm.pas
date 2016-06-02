unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, ImgList, ClassGame, ImageBtn, StdCtrls;

type
  TMainForm = class(TForm)
    Bckgrnd: TImage;
    BoardIm: TImage;
    StackIm: TImage;
    PlayIm: TImage;
    NewIm: TImage;
    ScoreIm: TImage;
    ImageBtnClose: TImageBtn;
    ImageBtnMin: TImageBtn;
    ChangeIm: TImage;
    TileIm: TImage;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure BckgrndMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BckgrndMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MinBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImageBtnCloseClick(Sender: TObject);
    procedure ImageBtnMinClick(Sender: TObject);
    procedure PlayImClick(Sender: TObject);
    procedure TileImClick(Sender: TObject);
    procedure ChangeImClick(Sender: TObject);
    procedure NewImClick(Sender: TObject);
    procedure LoadImClick(Sender: TObject);
    procedure SaveImClick(Sender: TObject);
  private
    Game      : TGame;
    StartPos  : TPoint;

    procedure MakeSpecialInit;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  MakeSpecialInit;

  DoubleBuffered := true;

  Game := TGame.Create( BoardIm , StackIm , ScoreIm , Label1 );
  Game.New( gtHvsC );
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Game.Free;
end;

//==============================================================================
//  P R I V A T E
//==============================================================================

procedure TMainForm.MakeSpecialInit;
var Rgn1, Rgn2, Rgn3 : HRGN;
    Points : array[0..3] of TPOINT;
begin
  // Set special shape of main form
  Points[0].x := 0;
  Points[0].y := 16;

  Points[1].x := 0;
  Points[1].y := Bckgrnd.Height;

  Points[2].x := Bckgrnd.Width;
  Points[2].y := Bckgrnd.Height;

  Points[3].x := Bckgrnd.Width;
  Points[3].y := 16;

  Rgn1 := CreatePolygonRgn( Points , 4 , WINDING );
  Rgn2 := CreateEllipticRgn( -20 , 0 , Bckgrnd.Width+20 , 62 );
  Rgn3 := CreateRectRgn( 0 , 0 , 0 , 0 );
  CombineRgn( Rgn3 , Rgn1 , Rgn2 , RGN_OR );

  SetWindowRgn( Handle , Rgn3 , true );

  // Set special shape of close button
  Rgn1 := CreateRectRgn( 0 , 0 , ImageBtnClose.Width , ImageBtnClose.Height );
  Rgn2 := CreateEllipticRgn( -195 , -15 , 45 , 155 );
  Rgn3 := CreateRectRgn( 0 , 0 , 0 , 0 );
  CombineRgn( Rgn3 , Rgn1 , Rgn2 , RGN_DIFF );

  ImageBtnClose.SetRgn( Rgn3 );

  // Set special shape of minimize button
  Rgn1 := CreateRectRgn( 0 , 0 , ImageBtnMin.Width , ImageBtnMin.Height );
  Rgn2 := CreateEllipticRgn( ImageBtnMin.Width-43 , -15 , ImageBtnMin.Width+197 , 155 );
  Rgn3 := CreateRectRgn( 0 , 0 , 0 , 0 );
  CombineRgn( Rgn3 , Rgn1 , Rgn2 , RGN_DIFF );

  ImageBtnMin.SetRgn( Rgn3 );
end;

//==============================================================================
//  E V E N T S
//==============================================================================

procedure TMainForm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.BckgrndMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var L, T : integer;
begin
  if (ssLeft in Shift) then
    begin
      L := Left;
      T := Top;

      L := L + (X - StartPos.x);
      T  := T + (Y - StartPos.y);

      if (L <= 10) then
        begin
          StartPos.x := StartPos.x + L;
          L := 0;
        end;

      if (L+Width >= Screen.Width-10) then
        begin
          StartPos.x := StartPos.x - (Screen.Width-(L+Width));
          L := Screen.Width-Width;
        end;

      if (T <= 10) then
        begin
          StartPos.y := StartPos.y + T;
          T := 0;
        end;

      if (T+Height >= Screen.Height-10) then
        begin
          StartPos.y := StartPos.y - (Screen.Height-(T+Height));
          T := Screen.Height-Height;
        end;

      Left := L;
      Top  := T;
    end;
end;

procedure TMainForm.BckgrndMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  StartPos.x := X;
  StartPos.y := Y;
end;

procedure TMainForm.MinBtnClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TMainForm.ImageBtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ImageBtnMinClick(Sender: TObject);
begin
  ImageBtnMin.SetState( false );
  Application.Minimize;
end;

procedure TMainForm.PlayImClick(Sender: TObject);
begin
  Game.OnPlay;
end;

procedure TMainForm.TileImClick(Sender: TObject);
begin
  Game.OnTile;
end;

procedure TMainForm.ChangeImClick(Sender: TObject);
begin
  Game.OnChange;
end;

procedure TMainForm.NewImClick(Sender: TObject);
begin
  Game.New( gtDontKnow );
end;

procedure TMainForm.LoadImClick(Sender: TObject);
begin
  if (OpenDialog.Execute) then
    Game.Load( OpenDialog.FileName );
end;

procedure TMainForm.SaveImClick(Sender: TObject);
begin
  if (SaveDialog.Execute) then
    Game.Save( SaveDialog.FileName );
end;

end.
