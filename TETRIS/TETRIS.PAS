uses crt,graph;

const sirka = 10;
      dlzka = 15;
      hrana = 12;

      farba : array[1..7] of byte = (1,2,3,4,5,6,7);

var pole : array[1..sirka,1..dlzka] of byte;
    x_p,y_p : byte;
    x,y : byte; {suradnice jeho hlavneho bodu}
    pada : byte; {ktory tetris pada}
    otocenie : byte; {jeho natocenie 1..4}

{$F+}
function DetectVGA256 : Integer;
begin
  DetectVGA256 := 0;
end;
{$F-}

procedure init_mcga;
var gd,gm : integer;
begin
  gd := InstallUserDriver('SVGA256',@DetectVGA256);
  gm := 0;
  initgraph(gd,gm,'c:\bp7\bgi\');
end;

procedure init_premenne;
begin
  x_p := 160 - Round((sirka / 2) * hrana);
  y_p := 10;
end;

procedure ukaz_zaklad;
begin
  SetFillStyle(1,blue);
  Bar(0,0,320,200);
  SetFillStyle(1,black);
  Bar(x_p-2,y_p-2,x_p+(sirka*hrana)+2,y_p+(dlzka*hrana)+2);
  SetColor(yellow);
  Rectangle(x_p-1,y_p-1,x_p+(sirka*hrana)+1,y_p+(dlzka*hrana)+1);
end;

procedure ukaz_hracie_pole;
var a,b : byte;
begin
  for a := 1 to sirka do
    for b := 1 to dlzka do
      if pole[a,b] in [0..7] then
        begin
          if pole[a,b] > 0 then SetFillStyle(1,farba[pole[a,b]])
                           else SetFillStyle(1,black);
          Bar(x_p+(a-1)*hrana,y_p+(b-1)*hrana,
              x_p+a*hrana,y_p+b*hrana);
        end;
end;

procedure posun;
begin
  case pada of
    1 : case otocenie of
          1 : begin
              end;
          2 : begin
              end;
        end;
    2 : begin
        end;
    3 : case otocenie of
          1 : begin
              end;
          2 : begin
              end;
        end;
    4 : case otocenie of
          1 : begin
              end;
          2 : begin
              end;
        end;
    5 : case otocenie of
          1 : begin
              end;
          2 : begin
              end;
        end;
    6 : case otocenie of
          1 : begin
              end;
          2 : begin
              end;
          3 : begin
              end;
          4 : begin
              end;
        end;
    7 : case otocenie of
          1 : if (pole[x,y+3] = 0) and
                 (pole[x+1,y+1] = 0) and
                 (y < dlzka-2) then
                   begin
                     pole[x,y] := 0;
                     pole[x+1,y] := 0;

                     pole[x,y+1] := 7;
                     pole[x,y+3] := 7;
                     pole[x,y+2] := 7;
                     pole[x+1,y+1] := 7;
                   end
                     else
                       pada := 0;
          2 : if (pole[x-2,y+1] = 0) and
                 (pole[x-1,y+1] = 0) and
                 (pole[x,y+2] = 0) and
                 (y < dlzka-1) then
                   begin
                     pole[x-2,y] := 0;
                     pole[x-1,y] := 0;
                     pole[x,y] := 0;
                     pole[x,y+1] := 0;

                     pole[x-2,y+1] := 7;
                     pole[x-1,y+1] := 7;
                     pole[x,y+1] := 7;
                     pole[x,y+2] := 7;
                  end
                     else
                       pada := 0;
          3 : if (pole[x,y+1] = 0) and
                 (pole[x-1,y+1] = 0) and
                 (y < dlzka) then
                   begin
                     pole[x,y-2] := 0;
                     pole[x-1,y] := 0;

                     pole[x-1,y+1] := 7;
                     pole[x,y+1] := 7;
                     pole[x,y] := 7;
                     pole[x,y-1] := 7;
                   end
                     else
                       pada := 0;
          4 : if (pole[x,y+1] = 0) and
                 (pole[x+1,y+1] = 0) and
                 (pole[x+2,y+1] = 0) and
                 (y < dlzka) then
                   begin
                     pole[x,y-1] := 0;
                     pole[x+1,y] := 0;
                     pole[x+2,y] := 0;

                     pole[x,y] := 7;
                     pole[x,y+1] := 7;
                     pole[x+1,y+1] := 7;
                     pole[x+2,y+1] := 7;
                   end
                     else
                       pada := 0;
        end;
  end;
  if pada > 0 then inc(y);
end;

begin
  init_mcga;
  init_premenne;
  ukaz_zaklad;
  pada := 7;
  x := 4;
  y := 2;
  otocenie := 3;
  repeat
    if pada <> 0 then posun;
    delay(500);
    ukaz_hracie_pole;
  until keypressed;
end.