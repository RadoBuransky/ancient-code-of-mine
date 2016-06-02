unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ComCtrls;

type
  TZnaky = array[0..255] of Cardinal;

  THlavneOkno = class(TForm)
    Memo: TMemo;
    MainMenu: TMainMenu;
    Sbor1: TMenuItem;
    Otvori1: TMenuItem;
    OpenDialog: TOpenDialog;
    MemoVysledok: TMemo;
    Button1: TButton;
    procedure Otvori1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HlavneOkno: THlavneOkno;

  VsetkyZnaky : TZnaky;

implementation

{$R *.DFM}

procedure VypisZnaky( Znaky : TZnaky; Memo : TMemo );
var I : byte;
begin
  Memo.Clear;
  for I := 0 to 255 do
    Memo.Lines.Add( Char(I)+' : '+IntToStr( Znaky[I] ) );
end;

function SpocitajZnaky( Subor : string ) : TZnaky;
var MemoryStream : TMemoryStream;
    Znak : char;
begin
  MemoryStream := TMemoryStream.Create;
  MemoryStream.LoadFromFile( Subor );

  while MemoryStream.Position < MemoryStream.Size do
    begin
      MemoryStream.Read( Znak , SizeOf( Znak ) );
      if Result[ Ord( Znak ) ] + 1 > MaxLongInt then
        begin
        end;
    end;

  MemoryStream.Free;
end;

procedure THlavneOkno.Otvori1Click(Sender: TObject);
var Znaky : TZnaky;
    I : byte;
begin
  if not OpenDialog.Execute then exit;
  Znaky := SpocitajZnaky( OpenDialog.FileName );
  for I := 0 to 255 do
    VsetkyZnaky[I] := VsetkyZnaky[I] + Znaky[I];
  VypisZnaky( Znaky , Memo );
end;

procedure THlavneOkno.Button1Click(Sender: TObject);
var I : byte;
    Max : cardinal;
begin
  Max := 0;
  for I := 0 to 255 do
    if VsetkyZnaky[I] > Max then Max := VsetkyZnaky[I];

  with MemoVysledok do
    begin
      Clear;
      for I := 0 to 255 do
        Lines.Add( FloatToStr( (Max/VsetkyZnaky[I])*100 )+' %' );
    end;
end;

procedure THlavneOkno.FormCreate(Sender: TObject);
begin
  FillChar( VsetkyZnaky , SizeOf( VsetkyZnaky ) , 0 );
end;

end.
