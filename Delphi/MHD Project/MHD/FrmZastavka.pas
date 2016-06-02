unit FrmZastavka;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, ClassData;

type
  PRect = ^TRect;

  TFormZastavka = class(TForm)
    Image: TImage;
    ComboBox: TComboBox;
    TrackBar: TTrackBar;
    ButtonZobrazit: TButton;
    procedure ButtonZobrazitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Zastavka : PZastavka;
    PRectWnd : PRect;
    Prilepeny : boolean;

    Zobrazene : boolean;
    PravyDolny : TPoint;

    procedure InitComboBox;
    //procedure Moving( var Message : TMessage ); message WM_MOVING;
  public
    { Public declarations }
    procedure MyShow( iRect : TRect; iZastavka : PZastavka ); overload;
    procedure MyShow( iZastavka : PZastavka ); overload;
  end;

var
  FormZastavka: TFormZastavka;

implementation

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                 Constructor
//
//==============================================================================
//==============================================================================

procedure TFormZastavka.FormCreate(Sender: TObject);
begin
  Zastavka := nil;
  PRectWnd := nil;
  Prilepeny := False;
end;

//==============================================================================
//==============================================================================
//
//                                  Destructor
//
//==============================================================================
//==============================================================================

procedure TFormZastavka.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if PRectWnd <> nil then
    Dispose( PRectWnd );
end;

//==============================================================================
//==============================================================================
//
//                                 Komponenty
//
//==============================================================================
//==============================================================================

procedure TFormZastavka.ButtonZobrazitClick(Sender: TObject);
begin
  if not Zobrazene then
    begin
      ButtonZobrazit.Caption := '&Skryù <<';
      Width := 300;
      Height := 200;
    end
      else
    begin
      ButtonZobrazit.Caption := '&Zobraziù >>';
      Width := PravyDolny.X;
      Height := PravyDolny.Y;
    end;
  Zobrazene := not Zobrazene;
end;

{procedure TFormZastavka.Moving( var Message : TMessage );
var PRectMove : PRect;
begin
  if (Zastavka = nil) or
     (PRectWnd = nil) then exit;

  PRectMove := Pointer( Message.LParam );

  if Prilepeny then
    begin
      with PRectMove^ do
        begin
          if Abs(Left - PRectWnd^.Right) > 2 then Prilepeny := False
                                             else Left := PRectWnd^.Right;
          Right := Left + Width;
        end;
    end
      else
    begin
      if Abs(PRectMove^.Left - PRectWnd^.Right) < 10 then
        begin
          PRectMove^.Left := PRectWnd^.Right + 1;
          Prilepeny := True;
        end;
    end;

  inherited;
end;}

//==============================================================================
//==============================================================================
//
//                                   Interface
//
//==============================================================================
//==============================================================================

procedure TFormZastavka.InitComboBox;
var I : integer;
begin
  ComboBox.Clear;
  for I := 0 to Zastavka^.Spoje.Count-1 do
    ComboBox.Items.Add( IntToStr( TSpoj( Zastavka^.Spoje[I]^ ).Cislo ) );
  ComboBox.ItemIndex := 0;
end;

procedure TFormZastavka.MyShow( iRect : TRect; iZastavka : PZastavka );
begin
  if iZastavka = nil then exit;

  if PRectWnd = nil then
    New( PRectWnd );
  PRectWnd^ := iRect;

  MyShow( iZastavka );
end;

procedure TFormZastavka.MyShow( iZastavka : PZastavka );
begin
  if iZastavka = nil then exit;

  Prilepeny := False;

  Zastavka := iZastavka;
  Caption := Zastavka^.Nazov;

  Zobrazene := False;
  PravyDolny.X := Width;
  PravyDolny.Y := Height;

  InitComboBox;

  if PRectWnd = nil then inherited ShowModal
                    else inherited Show;
end;

end.
