unit FormZakList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ClassZakList;

type
  TZakList = class(TForm)
	Label1: TLabel;
    EditCislo: TEdit;
    MemoOdber: TMemo;
    Label2: TLabel;
    EditObjCislo: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EditDatPrij: TEdit;
    Label5: TLabel;
    EditVybDna: TEdit;
    RadioGroup: TRadioGroup;
    GroupBox1: TGroupBox;
    MemoDruh: TMemo;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    MemoPris: TMemo;
    MemoPopis: TMemo;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label11: TLabel;
    MemoPopVykonu: TMemo;
    MemoPrisV: TMemo;
    ButtonSave: TButton;
    PrintDialog: TPrintDialog;
    ButtonOpen: TButton;
    ButtonPrint: TButton;
    ButtonCancel: TButton;
    OpenDialog: TOpenDialog;
    ComboBox: TComboBox;
	procedure FormCreate(Sender: TObject);
	procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonPrintClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonOpenClick(Sender: TObject);
    procedure ComboBoxChange(Sender: TObject);
  private
	{ Private declarations }
	procedure FormToClass;
    procedure ClassToForm;
    procedure ClearForm;

    function CounterToString( Counter : integer ) : string;
  public
	{ Public declarations }

	ZakazList : TZakazList;
  end;

var
  ZakList: TZakList;

implementation

uses Printers, Ini, Math, FormSaveZak, ClassAdresy;

{$R *.DFM}
procedure TZakList.FormCreate(Sender: TObject);
var I : integer;
begin
  ZakazList := TZakazList.Create;
  for I := 0 to Length( Adresy.Adresy )-1 do
    ComboBox.Items.Add( Adresy.Adresy[I][0] );
  if (ComboBox.Items.Count > 0) then
    ComboBox.ItemIndex := 0;
end;

procedure TZakList.FormDestroy(Sender: TObject);
begin
  ZakazList.Destroy;
end;

procedure TZakList.FormToClass;
begin
  ZakazList.Clear;

  ZakazList.ZakListCislo := EditCislo.Text;
  ZakazList.ObjCislo := EditObjCislo.Text;
  ZakazList.DatumPrij := EditDatPrij.Text;
  ZakazList.VybDna := EditVybDna.Text;
  ZakazList.Zaruka := (RadioGroup.ItemIndex = 0);
  ZakazList.Odberatel.AddStrings( MemoOdber.Lines );
  ZakazList.DruhZar.AddStrings( MemoDruh.Lines );
  ZakazList.PopisPor.AddStrings( MemoPopis.Lines );
  ZakazList.Prisl.AddStrings( MemoPris.Lines );
  ZakazList.PopisVyk.AddStrings( MemoPopVykonu.Lines );
  ZakazList.PrislVyk.AddStrings( MemoPrisV.Lines );
end;

procedure TZakList.ClassToForm;
begin
  EditCislo.Text := ZakazList.ZakListCislo;
  EditObjCislo.Text := ZakazList.ObjCislo;
  EditDatPrij.Text := ZakazList.DatumPrij;
  EditVybDna.Text := ZakazList.VybDna;
  RadioGroup.ItemIndex := 1-Integer( ZakazList.Zaruka );

  MemoOdber.Clear;
  MemoOdber.Lines.AddStrings( ZakazList.Odberatel );

  MemoDruh.Clear;
  MemoDruh.Lines.AddStrings( ZakazList.DruhZar );

  MemoPopis.Clear;
  MemoPopis.Lines.AddStrings( ZakazList.PopisPor );

  MemoPris.Clear;
  MemoPris.Lines.AddStrings( ZakazList.Prisl );

  MemoPopVykonu.Clear;
  MemoPopVykonu.Lines.AddStrings( ZakazList.PopisVyk );

  MemoPrisV.Clear;
  MemoPrisV.Lines.AddStrings( ZakazList.PrislVyk );
end;

procedure TZakList.ClearForm;
begin
  EditCislo.Text := '';
  EditObjCislo.Text := '';
  EditDatPrij.Text := '';
  EditVybDna.Text := '';
  RadioGroup.ItemIndex := 0;

  MemoOdber.Clear;
  MemoDruh.Clear;
  MemoPopis.Clear;
  MemoPris.Clear;
  MemoPopVykonu.Clear;
  MemoPrisV.Clear;
end;

function TZakList.CounterToString( Counter : integer ) : string;
var Year : string;
    Cislo : string;
    I, J : integer;
begin
  DateTimeToString( Year , 'yyyy' , Date );

  if (Counter = 0) then
    J := 1
  else
    J := Round( Int( log10( Counter )+1 ) );

  Cislo := '';
  for I := 0 to 6-J do
    Cislo := Cislo + '0';

  Result := Year + '-' + Cislo + IntToStr( Counter );
end;

procedure TZakList.FormShow(Sender: TObject);
begin
  ClearForm;
  EditCislo.Text := '';
end;

procedure TZakList.ButtonPrintClick(Sender: TObject);
begin
  FormToClass;
  if (PrintDialog.Execute) then
	begin
	  Printer.BeginDoc;
	  ZakazList.Print( Printer.Canvas , Printer.PageWidth , Printer.PageHeight );
	  Printer.EndDoc;
    end;
end;

procedure TZakList.ButtonCancelClick(Sender: TObject);
begin
  ModalResult := -1;
end;

procedure TZakList.ButtonSaveClick(Sender: TObject);
var FileName : string;
    Counter : integer;
begin
  FormZakazSave.DirectoryListBox.Directory := zakazky_dir;
  FormZakazSave.DirectoryListBox.Update;

  if (FormZakazSave.ShowModal = 1) then
    begin
      Counter := ZakazList.GetAndIncCounter;
      EditCislo.Text := CounterToString( Counter );

      ZakazList.Clear;
      FormToClass;

      FileName := FormZakazSave.DirectoryListBox.Directory + '\' + CounterToString( Counter ) + '.zak';
      ZakazList.Save( FileName );

      zakazky_dir := FormZakazSave.DirectoryListBox.Directory;

      ButtonPrint.Enabled := True;
    end;
end;

procedure TZakList.ButtonOpenClick(Sender: TObject);
begin
  OpenDialog.InitialDir := zakazky_dir;

  if (OpenDialog.Execute) then
    begin
      ZakazList.Open( OpenDialog.FileName );
      ClassToForm;

      ButtonPrint.Enabled := True;
    end;
end;

procedure TZakList.ComboBoxChange(Sender: TObject);
var I : integer;
begin
  if (ComboBox.ItemIndex = -1) then
    exit;

  MemoOdber.Clear;
  for I := 0 to Length( Adresy.Adresy[ComboBox.ItemIndex] )-1 do
    MemoOdber.Lines.Add( Adresy.Adresy[ComboBox.ItemIndex][I] );
end;

end.
