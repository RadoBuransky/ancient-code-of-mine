unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus;

type
  THlavneOkno = class(TForm)
    Memo: TMemo;
    MainMenu: TMainMenu;
    Otvorit: TMenuItem;
    OpenDialog: TOpenDialog;
    Znak: TLabel;
    Label1: TLabel;
    procedure OtvoritClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HlavneOkno: THlavneOkno;

implementation

{$R *.DFM}

procedure THlavneOkno.OtvoritClick(Sender: TObject);
var c : char;
    s : string;
    FileStream : TFileStream;

    Pole : array[1..1000] of char;
    Pocet : integer;

    I, J, K : integer;
begin
  if OpenDialog.Execute then
    begin
      Memo.Clear;
      FileStream := TFileStream.Create( OpenDialog.FileName , fmOpenRead );
      s := '';

      while FileStream.Position < FileStream.Size do
        begin
          FileStream.Read( c , SizeOf( c ) );
          if Length(s) = 150 then
            begin
              Memo.Lines.Add( s );
              S := '';
            end;
          s := s + c;
        end;

      FileStream.Free;

      Pocet := 0;
      for I := 0 to Memo.Lines.Count-1 do
        for J := 1 to Length( Memo.Lines[I] ) do
          begin
            for K := 1 to Pocet do
              if Pole[K] = Memo.Lines[I][J] then break;
            if Pole[K] = Memo.Lines[I][J] then continue;

            Inc( Pocet );
            Pole[Pocet] := Memo.Lines[I][J];
            Znak.Caption := Memo.Lines[I][J];
            Label1.Caption := IntToStr( Ord (Pole[Pocet]) );
            for K := 0 to MaxInt do;
          end;
    end;
end;

end.
