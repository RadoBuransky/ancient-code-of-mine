unit FrmDetail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ClassHladanie;

type
  TFormDetail = class(TForm)
    ButtonOK: TButton;
    Memo: TMemo;
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetVysledok( Value : PVysledok );
  public
    { Public declarations }
    property Vysledok : PVysledok write SetVysledok;
  end;

var
  FormDetail: TFormDetail;

implementation

uses ClassData;

{$R *.DFM}
procedure TFormDetail.SetVysledok( Value : PVysledok );
var Poc : integer;
    I, J : integer;
    S : string;
    h, m : integer;
    hs, ms : string;
    SZast : PZastavka;
    Spoj : PSpoj;

procedure Add( S : string );
begin
  Inc( Poc );
  if Poc > 1 then S := #13#10#13#10 + IntToStr( Poc ) + '.     ' + S
             else S := IntToStr( Poc ) + '.     ' + S;
  Memo.Text := Memo.Text + S;
end;

begin
  Memo.Clear;
  Poc := 0;
  SZast := nil;
  for I := 0 to Length( Value^.Prestupy )-1 do
    begin
      if ((SZast <> Value^.Prestupy[I].Zaciatok^.NaZastavke) and
          (SZast <> nil)) or
         ((SZast = nil) and
          (Value^.FreePoint)) then
        begin
          S := 'Prejdete pešo na zastávku '+Value^.Prestupy[I].Zaciatok^.NaZastavke^.Nazov;
          if Value^.Zaciatok^.NaZnamenie then S := S + ' (na znamenie)';
          S := S+' a';
        end
          else
        begin
          S := 'Na zastávke '+Value^.Prestupy[I].Zaciatok^.NaZastavke^.Nazov;
          if Value^.Prestupy[I].Zaciatok^.NaZastavke^.NaZnamenie then
            S := S + ' (na znamenie)';
        end;

      h := Value^.Prestupy[I].Nastup div 60;
      m := Value^.Prestupy[I].Nastup mod 60;
      hs := IntToStr( h );
      if m < 10 then ms := '0'+IntToStr( m )
                else ms := IntToStr( m );

      S := S + ' nastúpite o '+hs+':'+ms+' na spoj èíslo '+IntToStr( Value^.Prestupy[I].Zaciatok^.Cislo )+
           ' (smer '+Value^.Prestupy[I].Zaciatok^.Info^.Koniec^.Nazov+')';

      Spoj := Value^.Prestupy[I].Zaciatok;
      J := 1;
      while J <= Value^.Prestupy[I].Zastavky do
        begin
          Spoj := Spoj^.Next;
          Inc( J );
        end;

      S := S + ' a na '+IntToStr( Value^.Prestupy[I].Zastavky )+'. zastávke '+Spoj^.NaZastavke^.Nazov;
      if Spoj^.NaZastavke^.NaZnamenie then S := S+' (na znamenie)';
      S := S + ' vystúpite.';

      SZast := Spoj^.NaZastavke;
      Add( S );
    end;
end;

procedure TFormDetail.ButtonOKClick(Sender: TObject);
begin
  ModalResult := 1;
end;

end.
