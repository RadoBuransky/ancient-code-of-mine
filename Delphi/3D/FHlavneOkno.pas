unit FHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Menus, ComCtrls, Spin;

type TVektor = record
                 X, Y, Z : Real;
               end;
     TBod = array[1..3] of real;
     THrana = record
                A, B : word;
              end;
     TStena = record
                A, B, C : word;
                Farba : TColor;
                Z : real;
                Vidiet : Boolean;
                Normala : TVektor;
              end;
     TBody = array[1..8] of TBod;
     THrany = array[1..12] of THrana;
     TSteny = array[1..12] of TStena;

     TMatica = array[1..4] of TBod;

     TSvetlo = record
                 Smer : TVektor;
                 Intenzita : Real;
               end;
     TVidiet = array[1..12] of Boolean;
     TKamera = record
                 Body : TBody;
                 X, Y, Z : Real;
                 Alfa, Beta, Gama : Real;
                 Zvacsenie : Real;
                 Vidiet : TVidiet;
               end;


type
  THlavneOkno = class(TForm)
    MainMenu: TMainMenu;
    Subor: TMenuItem;
    Novy: TMenuItem;
    Otvorit: TMenuItem;
    Ulozit: TMenuItem;
    UlozitAko: TMenuItem;
    Koniec1: TMenuItem;
    OpenDialog: TOpenDialog;
    TabSheetEditor: TTabSheet;
    TabSheet3D: TTabSheet;
    Image3D: TImage;
    PageControl: TPageControl;
    GroupBoxBody: TGroupBox;
    GroupBoxHrany: TGroupBox;
    GroupBoxPlochy: TGroupBox;
    ImageEditor: TImage;
    ListViewBody: TListView;
    ButtonPridatBod: TButton;
    ButtonZmazatBod: TButton;
    ButtonPridatHranu: TButton;
    ButtonZrusit: TButton;
    ListViewHrany: TListView;
    ListViewPlochy: TListView;
    ButtonPridatPlochu: TButton;
    ButtonZrusitPlochu: TButton;
    ButtonVymenit: TButton;
    procedure OtvoritClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure Image3DMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3DMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3DMouseMove(Sender: TObject; Shift: TShiftState; Xm,
      Ym: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HlavneOkno: THlavneOkno;

  Body : TBody;
  Hrany : THrany;
  Steny : TSteny;

  PocetBodov, PocetHran, PocetStien : Word;

  PlatnyObjekt : Boolean;

  //Vlastnosti pohladu na objekt :
  StredX , StredY : Real;
  Svetlo : TSvetlo;

  Kamera, KameraEditor : TKamera;

  //Otacanie objektu :
  Stlaceny : Boolean = False;
  Sx, Sy : Integer;

implementation

uses Operacie, PracaSoSuborom;

{$R *.DFM}

procedure THlavneOkno.OtvoritClick(Sender: TObject);
var A : Word;
begin
  if OpenDialog.Execute then
    begin
      PocetBodov := 0;
      PocetHran := 0;
      PocetStien := 0;

      StredX := Image3D.Width / 2;
      StredY := Image3D.Height / 2;

      OtvorSubor( OpenDialog.FileName );
      PlatnyObjekt := True;

      with Kamera do
        begin
          X := 0.5;
          Y := 0.5;
          Z := -2;

          Alfa := 0;
          Beta := 0;
          Gama := 0;

          Zvacsenie := 100;

          for A := 1 to PocetStien do
            Vidiet[A] := Steny[A].Vidiet;
        end;
    end;
end;

procedure THlavneOkno.FormCreate(Sender: TObject);
begin
  PlatnyObjekt := False;

  //Nastavenie 3D
  with Image3D.Canvas do
    begin
      Brush.Color := clBlack;
      Pen.Color := $00FFFFFF;
      FillRect( Image3D.ClientRect );
    end;

  with Svetlo do
    begin
      Smer.X := 0;
      Smer.Y := 0;
      Smer.Z := -1;
      Intenzita := 0.1;
    end;

  //Nastavenie Editoru
  ImageEditor.Canvas.Brush.Color := clBlack;
  ImageEditor.Canvas.FillRect( ImageEditor.ClientRect );
  PremietniEditor( ImageEditor );
end;

procedure THlavneOkno.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePage.PageIndex <> 1 then exit;
  if PlatnyObjekt then Premietni( Image3d );
end;

procedure THlavneOkno.Image3DMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Stlaceny := True;
  Sx := X;
  Sy := Y;
end;

procedure THlavneOkno.Image3DMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Stlaceny := False;
end;

procedure THlavneOkno.Image3DMouseMove(Sender: TObject; Shift: TShiftState;
  Xm, Ym: Integer);
begin
  if not Stlaceny then exit;
  with Kamera do
    begin
      Alfa := Alfa + (Ym - Sy);
      if Alfa > 359 then Alfa := Alfa - 360;
      if Alfa < 0 then Alfa := Alfa + 360;

      Beta := Beta + (Xm - Sx);
      if Beta > 359 then Beta := Beta - 360;
      if Beta < 0 then Beta := Beta + 360;

      Sx := Xm;
      Sy := Ym;
    end;
  Premietni( Image3D );
end;

end.
