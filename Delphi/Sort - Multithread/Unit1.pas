unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

const PocetSortov = 6;

type TZoznam = array[1..PocetSortov] of string;

type
  THlavneOkno = class(TForm)
    PaintBoxBubble: TPaintBox;
    PaintBoxQuick: TPaintBox;
    TextBubbleSort: TLabel;
    TextQuickSort: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    TlacitkoZacniTriedit: TButton;
    EditPocet: TEdit;
    Bevel3: TBevel;
    PaintBoxSelection: TPaintBox;
    TextSelection: TLabel;
    Bevel4: TBevel;
    PaintBoxShell: TPaintBox;
    TextShell: TLabel;
    Bevel5: TBevel;
    PaintBoxRadix: TPaintBox;
    TextRadix: TLabel;
    ImageVystup: TImage;
    TextVysledky: TLabel;
    TextPocetPrvkov: TLabel;
    Bevel6: TBevel;
    PaintBoxMerge: TPaintBox;
    TextMerge: TLabel;
    procedure ObnovZoznam( ObnovZoznam : TZoznam );
    procedure TlacitkoZacniTrieditClick(Sender: TObject);
    procedure ZrusJedenThread( Sender : TObject );
    procedure EditPocetExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HlavneOkno: THlavneOkno;
  PocetPrvkov : Word;
  KohoZrusit : Word;

implementation

Uses Unit2;

var QuickPole : TPole;
    BubblePole : TPole;
    SelectionPole : TPole;
    ShellPole : TPole;
    RadixPole : TPole;
    MergePole : TPole;

    BeziaceSorty : Word;

    Vysledky : TZoznam;

const Mena : TZoznam = ('Bubble','Quick','Selection','Shell','Radix','Merge');

{$R *.DFM}

procedure NahodnePole;
var a, c : Word;
begin
  for a := 1 to PocetPrvkov do
    begin
      c := Random( 500 );
      QuickPole[ a ] := c;
    end;
  BubblePole := QuickPole;
  SelectionPole := QuickPole;
  ShellPole := QuickPole;
  RadixPole := QuickPole;
  MergePole := QuickPole;

  for a := 1 to PocetSortov do
    Vysledky[a] := '';
end;

procedure THlavneOkno.ObnovZoznam( ObnovZoznam : TZoznam );
var a : Word;
begin
  with ImageVystup.Canvas do
    begin
      for a := 1 to PocetSortov do
        TextOut( ImageVystup.ClientRect.Left + 10 , ImageVystup.ClientRect.Left + ((a-1)*20) ,
                 ObnovZoznam[ a ] );
    end;
end;

procedure THlavneOkno.ZrusJedenThread( Sender : TObject );
begin
  Dec( BeziaceSorty );
  if BeziaceSorty = 0 then
    begin
      TlacitkoZacniTriedit.Enabled := True;
      EditPocet.Enabled := True;
    end;
  Vysledky[ PocetSortov-BeziaceSorty ] := IntToStr(PocetSortov-BeziaceSorty) + '. ' + Mena[ KohoZrusit ];
  ObnovZoznam( Vysledky );
end;

procedure THlavneOkno.TlacitkoZacniTrieditClick(Sender: TObject);
begin
  TlacitkoZacniTriedit.Enabled := False;
  EditPocet.Enabled := False;
  NahodnePole;

  ImageVystup.Canvas.FillRect( ImageVystup.ClientRect );
  BeziaceSorty := PocetSortov;

  with TBubbleSort.Create( PaintBoxBubble , BubblePole , PocetPrvkov ) do
    OnTerminate := ZrusJedenThread;
  with TQuickSort.Create( PaintBoxQuick , QuickPole , PocetPrvkov ) do
    OnTerminate := ZrusJedenThread;
  with TSelectionSort.Create( PaintBoxSelection , SelectionPole , PocetPrvkov ) do
    OnTerminate := ZrusJedenThread;
  with TShellSort.Create( PaintBoxShell , ShellPole , PocetPrvkov ) do
    OnTerminate := ZrusJedenThread;
  with TRadixSort.Create( PaintBoxRadix , RadixPole , PocetPrvkov ) do
    OnTerminate := ZrusJedenThread;
  with TMergeSort.Create( PaintBoxMerge , MergePole , PocetPrvkov ) do
    OnTerminate := ZrusJedenThread;
end;

procedure THlavneOkno.EditPocetExit(Sender: TObject);
var Zaloha : Word;
    Code : integer;
begin
  Zaloha := PocetPrvkov;
  Val( EditPocet.Text , PocetPrvkov , Code );
  if Code <> 0 then PocetPrvkov := Zaloha;
end;

procedure THlavneOkno.FormCreate(Sender: TObject);
begin
  with ImageVystup.Canvas do
    begin
      Brush.Color := clBtnFace;
      Pen.Color := clBlack;
      FillRect( ImageVystup.ClientRect );
    end;
  PocetPrvkov := 100;
end;

end.
