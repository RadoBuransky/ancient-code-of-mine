unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, CheckLst;

type
  TZastavka = record
    Nazov : string;
    Sur : TPoint;
  end;

  THlavneOkno = class(TForm)
    ScrollBox: TScrollBox;
    Image: TImage;
    CheckListBox: TCheckListBox;
    LabelY: TLabel;
    LabelX: TLabel;
    MainMenu1: TMainMenu;
    Sbor1: TMenuItem;
    Otvori1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckListBoxClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure InitListBox;

    procedure UpdateZastavky;

    procedure ZapisSurDoSuboru;
  public
    { Public declarations }
    ZASTAVKY_FILE : string;

    Zastavky : TList;
  end;

var
  HlavneOkno: THlavneOkno;

implementation

uses SKonstanty;

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                  Constructor
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.InitListBox;
var I : integer;
begin
  for I := 0 to Zastavky.Count-1 do
    begin
      CheckListBox.Items.Add( TZastavka( Zastavky[I]^ ).Nazov );
      if (TZastavka( Zastavky[I]^ ).Sur.X = 0) and
         (TZastavka( Zastavky[I]^ ).Sur.Y = 0) then
           CheckListBox.State[I] := cbUnchecked
             else
           CheckListBox.State[I] := cbChecked;
    end;
end;

procedure THlavneOkno.FormCreate(Sender: TObject);
begin
  ZASTAVKY_FILE := '';
  Zastavky := TList.Create;

  Image.Picture.Bitmap.LoadFromFile( MAP_FILE );
  Image.Width := Image.Picture.Width;
  Image.Height := Image.Picture.Height;

  ScrollBox.VertScrollBar.Range := Image.Height;
  ScrollBox.HorzScrollBar.Range := Image.Width;

  InitListBox;
  UpdateZastavky;
end;

//==============================================================================
//==============================================================================
//
//                                  Destructor
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.ZapisSurDoSuboru;
var I : integer;
begin
  if (ZASTAVKY_FILE = '') then exit;

  AssignFile( Output , ZASTAVKY_FILE );
  {$I-}
  Rewrite( Output );
  {$I+}
  if IOResult <> 0 then
    raise Exception.Create( 'Ned· sa vytvoriù s˙bor '+ZASTAVKY_FILE );

  for I := 0 to Zastavky.Count-1 do
    begin
      Writeln( TZastavka( Zastavky[I]^ ).Nazov );
      Writeln( TZastavka( Zastavky[I]^ ).Sur.X );
      Writeln( TZastavka( Zastavky[I]^ ).Sur.Y );
    end;

  CloseFile( Output );
end;

procedure THlavneOkno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ZapisSurDoSuboru;
end;

//==============================================================================
//==============================================================================
//
//                              Zobrazenie zastavok
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.UpdateZastavky;
const r = 5;
var I : integer;
begin
  with Image.Canvas do
    begin
      Pen.Color := clBlue;
      Brush.Color := clBlue;
    end;

  for I := 0 to Zastavky.Count-1 do
    begin
      if (TZastavka( Zastavky[I]^ ).Sur.X = 0) and
         (TZastavka( Zastavky[I]^ ).Sur.Y = 0) then continue;
      Image.Canvas.Ellipse( TZastavka( Zastavky[I]^ ).Sur.X - r ,
                            TZastavka( Zastavky[I]^ ).Sur.Y - r ,
                            TZastavka( Zastavky[I]^ ).Sur.X + r ,
                            TZastavka( Zastavky[I]^ ).Sur.Y + r );
    end;
end;

//==============================================================================
//==============================================================================
//
//                                Komponenty
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.ImageMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  LabelX.Caption := 'X : '+IntToStr( X );
  LabelY.Caption := 'Y : '+IntToStr( Y );
end;

procedure THlavneOkno.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if CheckListBox.ItemIndex < 0 then exit;

  TZastavka( Zastavky[ CheckListBox.ItemIndex ]^ ).Sur.X := X;
  TZastavka( Zastavky[ CheckListBox.ItemIndex ]^ ).Sur.Y := Y;

  CheckListBox.State[ CheckListBox.ItemIndex ] := cbChecked;

  UpdateZastavky;
end;

procedure THlavneOkno.CheckListBoxClick(Sender: TObject);
begin
  if (CheckListBox.ItemIndex < 0) or
     ((TZastavka( Zastavky[CheckListBox.ItemIndex]^ ).Sur.X = 0) and
      (TZastavka( Zastavky[CheckListBox.ItemIndex]^ ).Sur.Y = 0)) then exit;

  ScrollBox.VertScrollBar.Position := TZastavka( Zastavky[ CheckListBox.ItemIndex ]^ ).Sur.Y - ScrollBox.Height div 2;
  ScrollBox.HorzScrollBar.Position := TZastavka( Zastavky[ CheckListBox.ItemIndex ]^ ).Sur.X - ScrollBox.Width div 2;
end;

procedure THlavneOkno.FormDestroy(Sender: TObject);
begin
  Zastavky.Free;
end;

end.
