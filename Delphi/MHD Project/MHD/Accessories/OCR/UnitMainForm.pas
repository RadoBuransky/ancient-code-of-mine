unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    MainFile: TMenuItem;
    FileOpen: TMenuItem;
    FileExit: TMenuItem;
    OpenDialog: TOpenDialog;
    Memo: TMemo;
    ScrollBox: TScrollBox;
    Image: TImage;
    MainOCR: TMenuItem;
    OCRChars: TMenuItem;
    Memo1: TMemo;
    Memo2: TMemo;
    ButtonOK: TButton;
    procedure FileOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure OCRCharsClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
    Selected : boolean;
    SelRect : TRect;

    procedure ShowSelRect;
    //  procedure ShowPreview( Bmp : TBitmap );

    procedure RecognizeSelRect;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses ClassOCR, UnitChars;

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                   Constructor
//
//==============================================================================
//==============================================================================

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Ocr := TOcr.Create( 'C:\Delphi\MHD Project\MHD\Accessories\OCR\Release\ocr.ini' );
  Selected := False;
end;

//==============================================================================
//==============================================================================
//
//                                   Destructor
//
//==============================================================================
//==============================================================================

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Ocr.Free;
end;

//==============================================================================
//==============================================================================
//
//                                   Main Menu
//
//==============================================================================
//==============================================================================

procedure TMainForm.FileOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    Image.Picture.LoadFromFile( OpenDialog.FileName );
end;

procedure TMainForm.OCRCharsClick(Sender: TObject);
begin
  FormChars.ShowModal;
end;

//==============================================================================
//==============================================================================
//
//                                   Events
//
//==============================================================================
//==============================================================================

procedure TMainForm.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Selected then
    begin
      ShowSelRect;
      Selected := False;
    end;
  if (Button = mbLeft) then
       begin
         SelRect.Left := X;
         SelRect.Top := Y;
       end;
end;

procedure TMainForm.ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (ssLeft in Shift) then
    begin
      if Selected then ShowSelRect
                  else Selected := True;

      SelRect.Right := X;
      SelRect.Bottom := Y;

      ShowSelRect;
    end;
end;

procedure TMainForm.ImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ShowSelRect;
  Selected := False;
  RecognizeSelRect;
end;

procedure TMainForm.ButtonOKClick(Sender: TObject);
const R : array[1..3] of TRect =
          ((Left:220;Top:70;Right:482;Bottom:470),
           (Left:479;Top:70;Right:705;Bottom:496),
           (Left:215;Top:495;Right:665;Bottom:905));
var I : integer;
begin
  for I := 1 to 3 do
    begin
      SelRect := R[I];
    end;
end;

//==============================================================================
//==============================================================================
//
//                                   Ostatne
//
//==============================================================================
//==============================================================================

procedure TMainForm.ShowSelRect;
begin
  Image.Canvas.DrawFocusRect( SelRect );
end;

{procedure TMainForm.ShowPreview( Bmp : TBitmap );
var I, J : integer;
    Rect : TRect;
begin
  ImagePrev.Width := Bmp.Width*10;
  ImagePrev.Height := Bmp.Height*10;

  ImagePrev.Picture.Bitmap.Width := Bmp.Width*10;
  ImagePrev.Picture.Bitmap.Height := Bmp.Height*10;

  with Rect do
    begin
      Left := 0;
      Top := 0;
      Right := ImagePrev.Width-1;
      Bottom := ImagePrev.Height-1;
    end;

  with ImagePrev.Canvas do
    begin
      Brush.Color := clGreen;
      FillRect( Rect );
    end;

  for I := 0 to Bmp.Width-1 do
    for J := 0 to Bmp.Height-1 do
      begin
        with ImagePrev.Canvas do
          begin
            Pen.Color := Bmp.Canvas.Pixels[I,J];
            Brush.Color := Bmp.Canvas.Pixels[I,J];
            Rectangle( I*10+I , J*10+J , (I+1)*10+I , (J+1)*10+J );
          end;
      end;
end;}

procedure TMainForm.RecognizeSelRect;
var I, J : integer;
    Bmp : TBitmap;
begin
  Bmp := TBitmap.Create;
  try
    Bmp.Width := Abs(SelRect.Right - SelRect.Left) + 1;
    Bmp.Height := Abs(SelRect.Bottom - SelRect.Top) + 1;

    for I := 0 to Bmp.Width-1 do
      for J := 0 to Bmp.Height-1 do
        Bmp.Canvas.Pixels[I,J] := Image.Picture.Bitmap.Canvas.Pixels[SelRect.Left+I,SelRect.Top+J];

    Ocr.Recognize( Bmp , Memo.Lines );

    with Memo do
      begin
        SelectAll;
        CopyToClipboard;
      end;

  finally
    Bmp.Free;
  end;
end;

end.
