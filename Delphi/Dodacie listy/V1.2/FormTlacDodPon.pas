unit FormTlacDodPon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFormTlacDodPonuka = class(TForm)
    ButtonTlacit: TButton;
    ButtonZrusit: TButton;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Button1: TButton;
    PrinterSetupDialog: TPrinterSetupDialog;
    ComboBoxFont: TComboBox;
    procedure ButtonTlacitClick(Sender: TObject);
    procedure ButtonZrusitClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Stlpce : array[1..4] of boolean;
  end;

var
  FormTlacDodPonuka: TFormTlacDodPonuka;

implementation

{$R *.DFM}

procedure TFormTlacDodPonuka.ButtonTlacitClick(Sender: TObject);
begin
  Stlpce[1] := CheckBox1.Checked;
  Stlpce[2] := CheckBox2.Checked;
  Stlpce[3] := CheckBox3.Checked;
  Stlpce[4] := CheckBox4.Checked;

  ModalResult := 1;
end;

procedure TFormTlacDodPonuka.ButtonZrusitClick(Sender: TObject);
begin
  ModalResult := -1;
end;

procedure TFormTlacDodPonuka.Button1Click(Sender: TObject);
begin
  PrinterSetupDialog.Execute;
end;

procedure TFormTlacDodPonuka.FormCreate(Sender: TObject);
var I : integer;
begin
  ComboBoxFont.Clear;
  for I := 0 to Screen.Fonts.Count-1 do
    begin
      ComboBoxFont.Items.Add( Screen.Fonts[I] );
      if Screen.Fonts[I] = 'Times New Roman' then
        ComboBoxFont.ItemIndex := I;
    end;
  if ComboBoxFont.ItemIndex = -1 then
    ComboBoxFont.ItemIndex := 0;
end;

end.
