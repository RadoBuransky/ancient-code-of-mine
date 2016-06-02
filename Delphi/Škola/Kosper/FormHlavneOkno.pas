unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  THlavneOkno = class(TForm)
    ButtonStart: TButton;
    Memo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
  private
    { Private declarations }
    N : longword;
  public
    { Public declarations }
  end;

var
  HlavneOkno: THlavneOkno;

implementation

{$R *.DFM}

procedure THlavneOkno.FormCreate(Sender: TObject);
begin
  N := High( LongWord );
end;

procedure THlavneOkno.ButtonStartClick(Sender: TObject);
var Sucet : extended;
    I : longword;
begin
  ButtonStart.Enabled := False;

  Sucet := 0;
  I := 1;
  repeat
    Sucet := Sucet + (1/I);
    Inc( I );
  until I = N;

  Memo.Lines.Add('');
  Memo.Lines.Add('Poèet prvkokv : '+IntToStr( N ));
  Memo.Lines.Add('Súèet : '+FloatToStr( Sucet ));

  ButtonStart.Enabled := True;
end;

end.
