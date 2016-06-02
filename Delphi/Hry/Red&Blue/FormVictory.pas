unit FormVictory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TVictory = class(TForm)
    Image: TImage;
    ButtonOK: TButton;
    procedure ButtonOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Victory: TVictory;

implementation

uses FormHlavneOkno;

{$R *.DFM}

procedure TVictory.ButtonOKClick(Sender: TObject);
begin
  ModalResult := 1;
end;

procedure TVictory.FormShow(Sender: TObject);
begin
  case HlavneOkno.Vitaz of
    0 : begin
          Image.Canvas.Pen.Color := clWhite;
          Image.Canvas.Brush.Color := clBlack;
          Image.Canvas.FillRect( Image.ClientRect );
          Image.Canvas.TextOut( 3 , 3 , 'S K V E L É! R E M Í Z A' );
        end;
    1 : Image.Picture.LoadFromFile( 'maria.bmp' );
    2 : Image.Picture.LoadFromFile( 'ja.bmp' );
  end;
end;

end.
