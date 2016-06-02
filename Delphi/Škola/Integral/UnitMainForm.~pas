unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ClassMetoda;

type
  TMainForm = class(TForm)
    Image: TImage;
    RadioGroupMetody: TRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    EditA: TEdit;
    EditB: TEdit;
    Label3: TLabel;
    EditN: TEdit;
    ButtonStart: TButton;
    Label4: TLabel;
    LabelIntegral: TLabel;
    Label6: TLabel;
    LabelPlocha: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RadioGroupMetodyClick(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditAExit(Sender: TObject);
    procedure EditBExit(Sender: TObject);
    procedure EditNExit(Sender: TObject);
  private
    { Private declarations }
    Active : TMetoda;

    procedure Obnov;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses ClassObdlznikova, ClassLicho;

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Active := nil;
  Obdlznikova := TObdlznikova.Create( Image );
  Licho := TLicho.Create( Image );
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Obdlznikova.Free;
  Licho.Free;
end;

procedure TMainForm.RadioGroupMetodyClick(Sender: TObject);
begin
  case RadioGroupMetody.ItemIndex of
    0 : Active := Obdlznikova;
    1 : Active := Licho;
  end;
  if Active = nil then ButtonStart.Enabled := False
                  else
                    begin
                      ButtonStart.Enabled := True;

                      LabelPlocha.Caption := '';
                      LabelIntegral.Caption := '';

                      Active.NakresliFunkciu;
                      Obnov;
                    end;
end;

procedure TMainForm.ButtonStartClick(Sender: TObject);
var Vysledok : TVysledok;
begin
  if Active = nil then exit;

  ButtonStart.Enabled := False;

  Vysledok := Active.Ries( StrToFloat( EditA.Text ) , StrToFloat( EditB.Text ) , StrToInt( EditN.Text ) );

  LabelPlocha.Caption := FloatToStr( Vysledok.Plocha );
  LabelIntegral.Caption := FloatToStr( Vysledok.Integral );

  ButtonStart.Enabled := True;
end;

procedure TMainForm.Obnov;
var A,B : real;
    n : longint;
begin
  if (EditA.Text <> '') and
     (EditB.Text <> '') and
     (EditN.Text <> '') then
       begin
         A := StrToFloat( EditA.Text );
         B := StrToFloat( EditB.Text );
         n := StrToInt( EditN.Text );

         Active.NakresliFunkciu;
         Active.NakresliInterval( A , B , n );
       end;
end;

procedure TMainForm.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Active = nil then exit;
  case Button of
    mbLeft : EditA.Text := IntToStr( X - Active.Stred.X );
    mbRight : EditB.Text := IntToStr( X - Active.Stred.X );
  end;
  Obnov;
end;

procedure TMainForm.EditAExit(Sender: TObject);
begin
  if Active = nil then exit;
  Obnov;
end;

procedure TMainForm.EditBExit(Sender: TObject);
begin
  if Active = nil then exit;
  Obnov;
end;

procedure TMainForm.EditNExit(Sender: TObject);
begin
  if Active = nil then exit;
  Obnov;
end;

end.
