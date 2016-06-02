unit Vyhladavanie;

interface

procedure Hladaj( Kde : Integer; Co : String );

implementation

uses Data, FormHlavneOkno, ComCtrls;

procedure Hladaj( Kde : Integer; Co : String );
var A : Word;
    Riadok : TListItem;

function Nasiel(Co , OutS : string) : Boolean;
var A : Word;
    Slovo : string[42];
begin
  nasiel := false;
  A := 0;
  if length(co) > 0 then
    begin
      nasiel := true;
      repeat
        slovo := '';
        repeat
          inc(a);
          if co[a] <> '*' then slovo := concat(slovo,co[a]);
        until (co[a] = '*') or (length(co) = a);
        while co[a+1] = '*' do inc(a);
        if pos(slovo,outs) = 0 then
          begin
            a := length(co);
            nasiel := false;
          end
            else
          delete(outs,1,pos(slovo,outs));
      until length(co) = a;
    end;
end;

begin
  with HlavneOkno.ListViewVyhladavanie do
    begin
      AllocBy := Pole[ AktivnaSkupina ].PocetPoloziek;
      Items.Clear;
    end;
  for A := 1 to Pole[ AktivnaSkupina ].PocetPoloziek do
    if Nasiel( Co , HlavneOkno.Tabulka.Cells[ Kde , A ] ) then
      begin
        Riadok := HlavneOkno.ListViewVyhladavanie.Items.Add;
        Riadok.Caption := HlavneOkno.Tabulka.Cells[ 0 , A ];
        Riadok.SubItems.Add( HlavneOkno.Tabulka.Cells[ 1 , A ] );
        Riadok.SubItems.Add( HlavneOkno.Tabulka.Cells[ 2 , A ] );
        Riadok.SubItems.Add( HlavneOkno.Tabulka.Cells[ 3 , A ] );
      end;
end;

end.
