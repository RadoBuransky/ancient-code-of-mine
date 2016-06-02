unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ClassHraciaPlocha, StdCtrls, Typy, FormVictory;

type TStavThread = class(TThread)
     private
       procedure Zrus( Sender : TObject );
     public
       procedure Execute; override;
     end;

type
  THlavneOkno = class(TForm)
    MainMenu: TMainMenu;
    MainHra: TMenuItem;
    HraNova: TMenuItem;
    HraKoniec: TMenuItem;
    Plocha: TImage;
    Stav: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure HraKoniecClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HraNovaClick(Sender: TObject);
    procedure PlochaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
     StavThread : TStavThread;
     procedure Pracuj;
  public
    { Public declarations }
    KoniecTahu : Boolean;
    KoniecHry : integer;
    Sur : TSur;

    Pomer : real;
    BeziThread : boolean;

    Vitaz : integer;

    procedure CakajNaTah;
    procedure VyhralSom( iKto : integer );
    procedure UkazStav( iPomer : real; Poc1, Poc2 : integer );
  end;

var
  HlavneOkno: THlavneOkno;
  HraciaPlocha : THraciaPlocha;

implementation
{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                 Constructor
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.FormCreate(Sender: TObject);
begin
  HraciaPlocha := THraciaPlocha.Create( 14 , 14 , Plocha , Stav );
end;

//==============================================================================
//==============================================================================
//
//                                 Destructor
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (KoniecHry = 0) or
     (HraciaPlocha.NaTahu = 2) or
     (BeziThread) then
    begin
      KoniecHry := 1;
      Action := caNone;
    end
      else
    begin
      Action := caFree;
      HraciaPlocha.Free;
    end;
end;

//==============================================================================
//==============================================================================
//
//                                 Main menu
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.HraKoniecClick(Sender: TObject);
begin
  Close;
end;

procedure THlavneOkno.HraNovaClick(Sender: TObject);
begin
  HraciaPlocha.NovaHra;
end;

//==============================================================================
//==============================================================================
//
//                                 Plocha
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.PlochaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var I : integer;
begin
  if HraciaPlocha.NaTahu <> 1 then exit;
  
  for I := 1 to HraciaPlocha.X do
    if I * (Plocha.Width / HraciaPlocha.X ) > X then
      begin
        Sur.X := I;
        break;
      end;

  for I := 1 to HraciaPlocha.Y do
    if I * (Plocha.Height / HraciaPlocha.Y ) > Y then
      begin
        Sur.Y := I;
        break;
      end;

  if not HraciaPlocha.Volno( Sur.X , Sur.Y ) then exit;

  KoniecTahu := True;
end;

procedure THlavneOkno.CakajNaTah;
begin
  KoniecTahu := False;
  repeat
    Application.ProcessMessages;
  until KoniecTahu or (KoniecHry = 1);
end;

//==============================================================================
//==============================================================================
//
//                                  Koniec hry
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.VyhralSom( iKto : integer );
begin
  StavThread.DoTerminate;
  Vitaz := iKto;
  Victory.ShowModal;

  //Vyèistenie plochy
  Plocha.Canvas.Brush.Color := clWhite;
  Plocha.Canvas.FillRect( Plocha.ClientRect );
  Stav.Canvas.Brush.Color := clWhite;
  Stav.Canvas.FillRect( Plocha.ClientRect );
end;

//==============================================================================
//==============================================================================
//
//                                  Stav
//
//==============================================================================
//==============================================================================

procedure TStavThread.Zrus( Sender : TObject );
begin
  HlavneOkno.BeziThread := False;
end;

procedure THlavneOkno.UkazStav( iPomer : real; Poc1, Poc2 : integer );
begin
  Label1.Caption := IntToStr( Poc1 );
  Label2.Caption := IntToStr( Poc2 );
  if BeziThread then exit;

  Pomer := iPomer;

  StavThread := TStavThread.Create( True );
  BeziThread := True;
  StavThread.OnTerminate := StavThread.Zrus;
  StavThread.FreeOnTerminate := True;
  StavThread.Suspended := False;
end;

procedure THlavneOkno.Pracuj;
var I, J : integer;
    Maria, Ja : TPicture;
    Vysledok : TBitmap;

    Farba1, Farba2 : byte;
    Farba : TColor;

    Pole : array[1..260,1..260] of TColor;

function ColorToGray( iColor : TColor ) : byte;
begin
  Result := iColor;
end;

function Priemer( iFarba1, iFarba2 : byte ) : TColor;
var F : byte;
begin
  if iFarba1 > iFarba2 then F := iFarba1 - Round((iFarba1-iFarba2)*Pomer)
                       else F := iFarba1 + Round((iFarba2-iFarba1)*Pomer);
  Result := (F shl 16)+(F shl 8)+F;
end;

begin
  Maria := TPicture.Create;
  Ja := TPicture.Create;
  Vysledok := TBitmap.Create;

  Vysledok.Assign( Stav.Picture.Bitmap );

  Maria.LoadFromFile( 'maria.bmp' );
  Ja.LoadFromFile( 'ja.bmp' );

  for I := 1 to Stav.Width do
    for J := 1 to Stav.Height do
      if (Ja.Bitmap.Canvas.Pixels[I,J] <> Maria.Bitmap.Canvas.Pixels[I,J]) then
        begin
          Farba1 := ColorToGray( Ja.Bitmap.Canvas.Pixels[I,J] );
          Farba2 := ColorToGray( Maria.Bitmap.Canvas.Pixels[I,J] );

          Farba := Priemer( Farba1 , Farba2 );

          Vysledok.Canvas.Pixels[I,J] := Farba;

          if StavThread.Terminated then exit;
        end
          else
        Pole[I,J] := Ja.Bitmap.Canvas.Pixels[I,J];

  Stav.Picture.Bitmap.Assign( Vysledok );

  Maria.Free;
  Ja.Free;
  Vysledok.Free;
end;

//==============================================================================
//==============================================================================
//
//                                    TStavThread
//
//==============================================================================
//==============================================================================


procedure TStavThread.Execute;
begin
  HlavneOkno.Pracuj;
end;

end.
