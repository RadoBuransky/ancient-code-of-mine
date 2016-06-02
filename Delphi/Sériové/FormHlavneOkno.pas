unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Grids, ComCtrls;

type
  THlavneOkno = class(TForm)
    Tabulka: TStringGrid;
    GroupBoxVyhladavanie: TGroupBox;
    GroupBoxSkupina: TGroupBox;
    MainMenu: TMainMenu;
    Koniec: TMenuItem;
    ComboBoxSkupina: TComboBox;
    ButtonPridatSkupinu: TButton;
    ButtonZmazatSkupinu: TButton;
    ListViewVyhladavanie: TListView;
    EditVyhladavanie: TEdit;
    ComboBoxVyhladavanie: TComboBox;
    ButtonVyhladavanie: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Upravy: TMenuItem;
    PridatPolozku: TMenuItem;
    ZmazatPolozku: TMenuItem;
    PridatSkupinu: TMenuItem;
    ZmazatSkupinu: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure KoniecClick(Sender: TObject);
    procedure ComboBoxSkupinaChange(Sender: TObject);
    procedure ButtonPridatSkupinuClick(Sender: TObject);
    procedure TabulkaSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure ButtonZmazatSkupinuClick(Sender: TObject);
    procedure ButtonVyhladavanieClick(Sender: TObject);
    procedure PridatPolozkuClick(Sender: TObject);
    procedure ZmazatPolozkuClick(Sender: TObject);
    procedure PridatSkupinuClick(Sender: TObject);
    procedure ZmazatSkupinuClick(Sender: TObject);
    procedure TabulkaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HlavneOkno: THlavneOkno;

implementation

Uses Inicializacia, Dialogy, Data, Vyhladavanie, Sort;

{$R *.DFM}

procedure THlavneOkno.FormCreate(Sender: TObject);
begin
  InicializaciaDat;
  NacitajZoSuboru;
  InicializaciaComboBoxu( ComboBoxSkupina );
  ZoradComboBox( ComboBoxSkupina );
  InicializaciaTabulky( Tabulka );
  InicializaciaVyhladavania;

  ComboBoxVyhladavanie.ItemIndex := 0;
end;

procedure THlavneOkno.FormClose(Sender: TObject; var Action: TCloseAction);
var A : Word;
begin
  A := 1;
  Zorad( 0 , Tabulka );
  NahadzDataDoPola;
  NahadzDataDoSuboru;
  for A := 1 to PocetSkupin do
    with Pole[A] do
      begin
        Cislo.Free;
        Nazov.Free;
        Seriove.Free;
        Prompt.Free;
      end;
end;

procedure THlavneOkno.KoniecClick(Sender: TObject);
begin
  HlavneOkno.Close;
end;

procedure THlavneOkno.ComboBoxSkupinaChange(Sender: TObject);
begin
  NahadzDataDoPola;
  NahadzDataDoTabulky( ComboBoxSkupina.ItemIndex+1 );
end;

procedure THlavneOkno.ButtonPridatSkupinuClick(Sender: TObject);
begin
  if PocetSkupin < 100 then DialogPridajSkupinu( True );
end;

procedure THlavneOkno.TabulkaSetEditText(Sender: TObject; ACol,
 ARow: Integer; const Value: String);
begin
  if Value = '' then Exit;
  if Pole[ Aktivnaskupina ].PocetPoloziek = 0 then
    begin
      ZmazatPolozku.Enabled := True;
      Inc( Pole[ Aktivnaskupina ].PocetPoloziek );
    end;
end;

procedure THlavneOkno.ButtonZmazatSkupinuClick(Sender: TObject);
begin
  if MessageDlg( 'Naozaj chcete zmaza skupinu ?', mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then
    ZmazSkupinu;
end;

procedure THlavneOkno.ButtonVyhladavanieClick(Sender: TObject);
begin
  if EditVyhladavanie.Text = '' then Exit;
  Hladaj( ComboBoxVyhladavanie.ItemIndex , EditVyhladavanie.Text );
end;

procedure THlavneOkno.PridatPolozkuClick(Sender: TObject);
begin
  DialogPridajPolozku( AktivnaSkupina );
end;

procedure THlavneOkno.ZmazatPolozkuClick(Sender: TObject);
begin
  if Pole[AktivnaSkupina].PocetPoloziek = 0 then Exit;
  if MessageDlg( 'Naozaj chcete zmaza vybranú položku ?' , mtConfirmation,
                 [mbYes, mbNo], 0) = mrYes then
                   ZmazPolozku( Tabulka.Row );

end;

procedure THlavneOkno.PridatSkupinuClick(Sender: TObject);
begin
  DialogPridajSkupinu( True );
end;

procedure THlavneOkno.ZmazatSkupinuClick(Sender: TObject);
begin
  if MessageDlg( 'Naozaj chcete zmaza skupinu ?', mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then
    ZmazSkupinu;
end;

procedure THlavneOkno.TabulkaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Stlpec0, Stlpec1, Stlpec2, Stlpec3 : Word;
begin
  if Pole[ AktivnaSkupina ].PocetPoloziek = 0 then Exit;
  if Y > Tabulka.RowHeights[0] then Exit;

  Stlpec0 := Tabulka.ColWidths[0];
  Stlpec1 := Stlpec0 + Tabulka.ColWidths[1];
  Stlpec2 := Stlpec1 + Tabulka.ColWidths[2];
  Stlpec3 := Stlpec2 + Tabulka.ColWidths[3];

  if (X < Stlpec0) then Zorad( 0 , Tabulka );
  if (X > Stlpec0) and
     (X < Stlpec1) then Zorad( 1 , Tabulka );
  if (X > Stlpec1) and
     (X < Stlpec2) then Zorad( 2 , Tabulka );
  if (X > Stlpec2) and
     (X < Stlpec3) then Zorad( 3 , Tabulka );
end;

end.
