unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ClassTetiva, ClassBisekcia, ClassNulovy;

const KRESLENIE_L = '-500';
      KRESLENIE_P = '500';

      POCITANIE_L = '-100';
      POCITANIE_P = '100';

      PRESNOST = '0,1';

type
  THlavneOkno = class(TForm)
    Image: TImage;
    ButtonNakresli: TButton;
    RadioGroup: TRadioGroup;
    ButtonRies: TButton;
    ButtonKrok: TButton;
    GroupBox1: TGroupBox;
    EditKreslenieL: TEdit;
    EditKreslenieP: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    EditPocitanieL: TEdit;
    EditPocitanieP: TEdit;
    ButtonReset: TButton;
    EditPresnost: TEdit;
    Label5: TLabel;
    LabelVysledok: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioGroupClick(Sender: TObject);
    procedure ButtonNakresliClick(Sender: TObject);
    procedure ButtonKrokClick(Sender: TObject);
    procedure ButtonResetClick(Sender: TObject);
    procedure ButtonRiesClick(Sender: TObject);
  private
    { Private declarations }
    Stlaceny : boolean;
    A, B : TPoint;
  public
    { Public declarations }
  end;

var
  HlavneOkno: THlavneOkno;

  Tetiva : TTetiva;
  Bisekcia : TBisekcia;

  Vybrana : TNulovy;

implementation

uses MojeTypy;

{$R *.DFM}
//==============================================================================
//==============================================================================
//
//                                    Funkcie
//
//==============================================================================
//==============================================================================

function Funkcia1( X : real ) : real;
begin
  Result := (X*X*X / 10000) - (X*X / 50) + (X / 10) + 10;
end;

function Funkcia2( X : real ) : real;
begin
  Result := (Sin( (X-50)/100 )*60)+Sin(X/20)*50;
end;

//==============================================================================
//==============================================================================
//
//                                 Constructor
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.FormCreate(Sender: TObject);
begin
  Stlaceny := False;

  EditKreslenieL.Text := KRESLENIE_L;
  EditKreslenieP.Text := KRESLENIE_P;

  EditPocitanieL.Text := POCITANIE_L;
  EditPocitanieP.Text := POCITANIE_P;

  EditPresnost.Text := PRESNOST;

  Tetiva := TTetiva.Create( -1000 , 1000 , Image );
  Bisekcia := TBisekcia.Create( -1000 , 1000 , Image );

  Tetiva.Funkcia := Funkcia1;
  Bisekcia.Funkcia := Funkcia1;

  Vybrana := Bisekcia;
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
  Bisekcia.Free;
  Tetiva.Free;
end;

//==============================================================================
//==============================================================================
//
//                                  Komponenty
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.RadioGroupClick(Sender: TObject);
begin
  case RadioGroup.ItemIndex of
    0 : Vybrana := Bisekcia;
    1 : Vybrana := Tetiva;
  end;
  Image.Enabled := True;
end;

procedure THlavneOkno.ButtonNakresliClick(Sender: TObject);
var L, P : real;
begin
  if Vybrana = nil then exit;

  try
    L := StrToFloat( EditKreslenieL.Text );
    P := StrToFloat( EditKreslenieP.Text );
  except
    on EConvertError do
      begin
        MessageDlg( 'Hodnoty pre interval kreslenia nie su realne cisla' , mtError , [mbOK] , 0 );
        exit;
      end;
  end;

  Vybrana.NakresliL := L;
  Vybrana.NakresliP := P;
  
  Vybrana.NakresliFunkciu;
end;

procedure THlavneOkno.ButtonKrokClick(Sender: TObject);
var L, P : real;
    Presnost : real;
begin
  if (Vybrana = nil) or
     (Vybrana.Hotovo) then exit;

  try
    L := StrToFloat( EditKreslenieL.Text );
    P := StrToFloat( EditKreslenieP.Text );
  except
    on EConvertError do
      begin
        MessageDlg( 'Hodnoty pre interval kreslenia nie su realne cisla' , mtError , [mbOK] , 0 );
        exit;
      end;
  end;

  Vybrana.NakresliL := L;
  Vybrana.NakresliP := P;

  try
    L := StrToFloat( EditPocitanieL.Text );
    P := StrToFloat( EditPocitanieP.Text );
    Presnost := StrToFloat( EditPresnost.Text );
  except
    on EConvertError do
      begin
        MessageDlg( 'Hodnoty pre interval pocitania alebo presnost nie su realne cisla' , mtError , [mbOK] , 0 );
        exit;
      end;
  end;

  Vybrana.PocitajL := L;
  Vybrana.PocitajP := P;
  Vybrana.Presnost := Presnost;

  Vybrana.Krok;

  if Vybrana.Hotovo and Vybrana.NasielRiesenie then
    begin
      ButtonRies.Enabled := False;
      ButtonKrok.Enabled := False;
      LabelVysledok.Caption := FloatToStr( Round( Vybrana.PocitajL*10 ) / 10 );
    end;
  if Vybrana.Hotovo then Vybrana.Hotovo := False;

  EditPocitanieL.Text := FloatToStr( Vybrana.PocitajL );
  EditPocitanieP.Text := FloatToStr( Vybrana.PocitajP );
end;

procedure THlavneOkno.ButtonRiesClick(Sender: TObject);
var L, P, Presnost : real;
begin
  if (Vybrana = nil) or
     (Vybrana.Hotovo) then exit;

  try
    L := StrToFloat( EditKreslenieL.Text );
    P := StrToFloat( EditKreslenieP.Text );
  except
    on EConvertError do
      begin
        MessageDlg( 'Hodnoty pre interval kreslenia nie su realne cisla' , mtError , [mbOK] , 0 );
        exit;
      end;
  end;

  Vybrana.NakresliL := L;
  Vybrana.NakresliP := P;

  try
    L := StrToFloat( EditPocitanieL.Text );
    P := StrToFloat( EditPocitanieP.Text );
    Presnost := StrToFloat( EditPresnost.Text );
  except
    on EConvertError do
      begin
        MessageDlg( 'Hodnoty pre interval pocitania alebo presnost nie su realne cisla' , mtError , [mbOK] , 0 );
        exit;
      end;
  end;

  Vybrana.PocitajL := L;
  Vybrana.PocitajP := P;
  Vybrana.Presnost := Presnost;

  Vybrana.RiesFunkciu;

  if Vybrana.Hotovo and Vybrana.NasielRiesenie then
    begin
      ButtonRies.Enabled := False;
      ButtonKrok.Enabled := False;
      LabelVysledok.Caption := FloatToStr( Round( Vybrana.PocitajL*10 ) / 10 );
    end;
  if Vybrana.Hotovo then Vybrana.Hotovo := False;

  EditPocitanieL.Text := FloatToStr( Vybrana.PocitajL );
  EditPocitanieP.Text := FloatToStr( Vybrana.PocitajP );
end;

procedure THlavneOkno.ButtonResetClick(Sender: TObject);
begin
  EditKreslenieL.Text := KRESLENIE_L;
  EditKreslenieP.Text := KRESLENIE_P;

  EditPocitanieL.Text := POCITANIE_L;
  EditPocitanieP.Text := POCITANIE_P;

  EditPresnost.Text := PRESNOST;

  LabelVysledok.Caption := '';

  Vybrana.Hotovo := False;

  ButtonRies.Enabled := True;
  ButtonKrok.Enabled := True;
end;



end.
