uses crt,dos,graph,digital;

const koniec : boolean = false;
      max = 12;
      x : shortint = 6;
      y : shortint = 6;
      hrac : byte = 1;

var pole : array[1..max,1..max] of byte;
    pocet1,pocet2 : word;
    sirka : byte;
    sx,sy,sh : byte;

procedure init_graph;
var gd,gm : integer;
begin
  gd := detect;
  InitGraph(gd,gm,'');
end;

procedure nakresli_celu_hraciu_plochu;
var a,b : byte;
    s : string[2];
begin
  SetColor(White);
  SetFillStyle(1,black);

  for a := 1 to max do
    for b := 1 to max do
      if pole[a,b] = 0 then
        Bar3D( 15+(a-1)*sirka,    15+(b-1)*sirka,
               15+sirka+(a-1)*sirka, 15+sirka+(b-1)*sirka,
               0, false);

  for a := 1 to max do
    for b := 1 to max do
      case pole[a,b] of
        1 : begin
              SetColor(white);
              Rectangle(15+(a-1)*sirka,    15+(b-1)*sirka,
                        15+sirka+(a-1)*sirka, 15+sirka+(b-1)*sirka);
              SetColor(lightblue);
              SetFillStyle(1,lightblue);
              FillEllipse(15+(sirka div 2)+(a-1)*sirka,
                          15+(sirka div 2)+(b-1)*sirka,
                          (sirka - 4) div 2, (sirka - 4) div 2);
            end;
        2 : begin
              SetColor(white);
              Rectangle(15+(a-1)*sirka,    15+(b-1)*sirka,
                        15+sirka+(a-1)*sirka, 15+sirka+(b-1)*sirka);
              SetColor(lightred);
              SetFillStyle(1,lightred);
              FillEllipse(15+(sirka div 2)+(a-1)*sirka,
                          15+(sirka div 2)+(b-1)*sirka,
                          (sirka - 4) div 2, (sirka - 4) div 2);
            end;
      end;

  SetColor(white);

  for a := 1 to max do
    begin
      Str(a,s);
      OutTextXY(25+(a-1)*sirka,5,s);
      OutTextXY(0,27+(a-1)*sirka,s);
    end;
end;

procedure nakresli_kamen(a,b : byte);
begin
  case pole[a,b] of
        1 : begin
              SetColor(white);
              Rectangle(15+(a-1)*sirka,    15+(b-1)*sirka,
                        15+sirka+(a-1)*sirka, 15+sirka+(b-1)*sirka);
              SetColor(lightblue);
              SetFillStyle(1,lightblue);
              FillEllipse(15+(sirka div 2)+(a-1)*sirka,
                          15+(sirka div 2)+(b-1)*sirka,
                          (sirka - 4) div 2, (sirka - 4) div 2);
            end;
        2 : begin
              delay(500);
              SetColor(white);
              Rectangle(15+(a-1)*sirka,    15+(b-1)*sirka,
                        15+sirka+(a-1)*sirka, 15+sirka+(b-1)*sirka);
              SetColor(lightred);
              SetFillStyle(1,lightred);
              FillEllipse(15+(sirka div 2)+(a-1)*sirka,
                          15+(sirka div 2)+(b-1)*sirka,
                          (sirka - 4) div 2, (sirka - 4) div 2);
            end;
      end;
end;

function zoberie(farba,surx,sury : byte) : byte;
var a,b,c,poc : byte;
    z : byte;
begin
  zoberie := 0;

  z := 0;

  case farba of
    1 : c := 2;
    2 : c := 1;
  end;

  {dolava hore}

  if (surx > 2) and (sury > 2) then
    begin

      a := surx;
      b := sury;
      poc := 0;

      repeat
        Dec(a);
        Dec(b);
        Inc(poc);
      until (pole[a,b] <> c) or
            (a < 1) or (b < 1);

      if pole[a,b] = farba then z := z + (poc - 1);

    end;

  {hore}

  if (sury > 2) then
    begin

      a := surx;
      b := sury;
      poc := 0;

      repeat
        Dec(b);
        Inc(poc);
      until (pole[a,b] <> c) or
            (a < 1) or (b < 1);

      if pole[a,b] = farba then z := z + (poc - 1);

    end;

  {doprava hore}

  if (surx < max) and (sury > 2) then
    begin

      a := surx;
      b := sury;
      poc := 0;

      repeat
        Inc(a);
        Dec(b);
        Inc(poc);
      until (pole[a,b] <> c) or
            (a > max) or (b < 1);

      if pole[a,b] = farba then z := z + (poc - 1);

    end;

  {doprava}

  if (surx < max) then
    begin

      a := surx;
      b := sury;
      poc := 0;

      repeat
        Inc(a);
        Inc(poc);
      until (pole[a,b] <> c) or
            (a > max);

      if pole[a,b] = farba then z := z + (poc - 1);

    end;

  {doprava dole}

  if (surx < max) and (sury < max) then
    begin

      a := surx;
      b := sury;
      poc := 0;

      repeat
        inc(a);
        inc(b);
        Inc(poc);
      until (pole[a,b] <> c) or
            (a > max) or (b > max);

      if pole[a,b] = farba then z := z + (poc - 1);

    end;

  {dole}

  if (sury < max) then
    begin

      a := surx;
      b := sury;
      poc := 0;

      repeat
        inc(b);
        Inc(poc);
      until (pole[a,b] <> c) or
            (y > max);

      if pole[a,b] = farba then z := z + (poc - 1);

    end;

  {dolava dole}

  if (surx > 2) and (sury < max) then
    begin

      a := surx;
      b := sury;
      poc := 0;

      repeat
        Dec(a);
        inc(b);
        Inc(poc);
      until (pole[a,b] <> c) or
            (a < 1) or (b > max);

      if pole[a,b] = farba then z := z + (poc - 1);

    end;

  {dolava}

  if (surx > 2) then
    begin

      a := surx;
      b := sury;
      poc := 0;

      repeat
        Dec(a);
        Inc(poc);
      until (pole[a,b] <> c) or
            (a < 1);

      if pole[a,b] = farba then z := z + (poc - 1);

    end;

    zoberie := z;
end;

procedure urob_tah(farba,surx,sury : byte);
var a,b,c : byte;
begin

  pole[surx,sury] := farba;
  nakresli_kamen(surx,sury);

  case farba of
    1 : c := 2;
    2 : c := 1;
  end;

  {dolava hore}

  if (surx > 2) and (sury > 2) then
    begin

      a := surx;
      b := sury;

      repeat
        Dec(a);
        Dec(b);
      until (pole[a,b] <> c) or
            (a < 1) or (b < 1);

      if pole[a,b] = farba then
        repeat
          if pole[a,b] <> farba then
            begin
              pole[a,b] := farba;
              nakresli_kamen(a,b);
            end;
          Inc(a);
          Inc(b);
        until pole[a,b] = farba;
    end;

  {hore}

  if (sury > 2) then
    begin

      a := surx;
      b := sury;

      repeat
        Dec(b);
      until (pole[a,b] <> c) or
            (a < 1) or (b < 1);

      if pole[a,b] = farba then
        repeat
          if pole[a,b] <> farba then
            begin
              pole[a,b] := farba;
              nakresli_kamen(a,b);
            end;
          Inc(b);
        until pole[a,b] = farba;

    end;

  {doprava hore}

  if (surx < max) and (sury > 2) then
    begin

      a := surx;
      b := sury;

      repeat
        Inc(a);
        Dec(b);
      until (pole[a,b] <> c) or
            (a > max) or (b < 1);

      if pole[a,b] = farba then
        repeat
          if pole[a,b] <> farba then
            begin
              pole[a,b] := farba;
              nakresli_kamen(a,b);
            end;
          Dec(a);
          Inc(b);
        until pole[a,b] = farba;

    end;

  {doprava}

  if (surx < max) then
    begin

      a := surx;
      b := sury;

      repeat
        Inc(a);
      until (pole[a,b] <> c) or
            (a > max);

      if pole[a,b] = farba then
        repeat
          if pole[a,b] <> farba then
            begin
              pole[a,b] := farba;
              nakresli_kamen(a,b);
            end;
          Dec(a);
        until pole[a,b] = farba;

    end;

  {doprava dole}

  if (surx < max) and (sury < max) then
    begin

      a := surx;
      b := sury;

      repeat
        inc(a);
        inc(b);
      until (pole[a,b] <> c) or
            (a > max) or (b > max);

      if pole[a,b] = farba then
        repeat
          if pole[a,b] <> farba then
            begin
              pole[a,b] := farba;
              nakresli_kamen(a,b);
            end;
          Dec(a);
          Dec(b);
        until pole[a,b] = farba;

    end;

  {dole}

  if (sury < max) then
    begin

      a := surx;
      b := sury;

      repeat
        inc(b);
      until (pole[a,b] <> c) or
            (b > max);

      if pole[a,b] = farba then
        repeat
          if pole[a,b] <> farba then
            begin
              pole[a,b] := farba;
              nakresli_kamen(a,b);
            end;
          Dec(b);
        until pole[a,b] = farba;

    end;

  {dolava dole}

  if (surx > 2) and (sury < max) then
    begin

      a := surx;
      b := sury;

      repeat
        Dec(a);
        inc(b);
      until (pole[a,b] <> c) or
            (a < 1) or (b > max);

      if pole[a,b] = farba then
        repeat
          if pole[a,b] <> farba then
            begin
              pole[a,b] := farba;
              nakresli_kamen(a,b);
            end;
          Inc(a);
          Dec(b);
        until pole[a,b] = farba;

    end;

  {dolava}

  if (surx > 2) then
    begin

      a := surx;
      b := sury;

      repeat
        Dec(a);
      until (pole[a,b] <> c) or
            (a < 1);

      if pole[a,b] = farba then
        repeat
          if pole[a,b] <> farba then
            begin
              pole[a,b] := farba;
              nakresli_kamen(a,b);
            end;
          Inc(a);
        until pole[a,b] = farba;
    end;
end;


procedure citaj_klaves;
var key : char;
begin
  key := readkey;
  case key of
    #27 : koniec := true;
    #72 : Dec(y);
    #80 : Inc(y);
    #75 : Dec(x);
    #77 : Inc(x);
    #13 : if (pole[x,y] = 0) and
             (zoberie(hrac,x,y) <> 0) then
            begin
              pole[x,y] := hrac;
              urob_tah(hrac,x,y);
              case hrac of
                1 : hrac := 2;
                2 : hrac := 1;
              end;
            end;
  end;
  if x < 1 then x := max;
  if y < 1 then y := max;
  if x > max then x := 1;
  if y > max then y := 1;
end;

procedure init_premenne;
var a,b : byte;
begin
  for a := 1 to max do
    for b := 1 to max do
      pole[a,b] := 0;

  pole[6,6] := 1;
  pole[7,7] := 1;
  pole[6,7] := 2;
  pole[7,6] := 2;

  sirka := 460 div max;

  sx := x;
  sy := y;

  pocet1 := 2;
  pocet2 := 2;
end;

procedure spocitaj;
var a,b : byte;
begin
  pocet1 := 0;
  pocet2 := 0;
  for a := 1 to max do
    for b := 1 to max do
      if pole[a,b] <> 0 then
        case pole[a,b] of
          1 : Inc(pocet1);
          2 : Inc(pocet2);
        end;
end;

procedure ukaz_kurzor;
var a,b : real;
begin
  if (x <> sx) or
     (y <> sy) or
     (hrac  <> sh) then
       begin
         SetColor(black);
         Rectangle(16+(sx-1)*sirka,       16+(sy-1)*sirka,
                   14+sirka+(sx-1)*sirka, 14+sirka+(sy-1)*sirka);
         SetColor(white);
         Rectangle(15+(sx-1)*sirka,       15+(sy-1)*sirka,
                   15+sirka+(sx-1)*sirka, 15+sirka+(sy-1)*sirka);

         case hrac of
           1 : SetColor(lightblue);
           2 : SetColor(lightred);
         end;
         Rectangle(16+(x-1)*sirka,       16+(y-1)*sirka,
                   14+sirka+(x-1)*sirka, 14+sirka+(y-1)*sirka);
         Rectangle(15+(x-1)*sirka,       15+(y-1)*sirka,
                   15+sirka+(x-1)*sirka, 15+sirka+(y-1)*sirka);

         sx := x;
         sy := y;
       end;

  if hrac <> sh then
    begin

      case hrac of
        1 : begin
              SetColor(lightblue);
              Setfillstyle(1,lightblue);
            end;
        2 : begin
              Setcolor(lightred);
              Setfillstyle(1,lightred);
            end;
        end;

        Rectangle(500,10,640,470);
        Rectangle(520,30,620,450);
        case hrac of
          1 : Floodfill(510,20,lightblue);
          2 : Floodfill(510,20,lightred);
        end;

        spocitaj;

        SetFillStyle(1,black);
        Bar(520,30,620,450);

        cislo(540,50,pocet1,lightblue,0.5);
        cislo(540,150,pocet2,lightred,0.5);

        SetFillStyle(1,lightblue);

        a := pocet1;
        b := pocet2;

        if (a = b) then
          begin
            a := 200;
            b := 200;
          end;

        if (a > b) and (a < 200) then
          begin
            b := b * (200 / a);
            a := 200;
          end;

       if (a < b) and (b < 200) then
          begin
            a := a * (200 / b);
            b := 200;
          end;

        if (a > b) and (a > 200) then
          begin
            b := b / (a / 200);
            a := 200;
          end;

        if (a < b) and (b > 200) then
          begin
            a := a / (b / 200);
            b := 200;
          end;

        bar(540,420,560,420 - Round(a));

        SetFillStyle(1,lightred);
        bar(570,420,590,420 - Round(b));

        sh := hrac;
    end;
end;

procedure pocitac_mysli1;
var a,b,c,d : word;
    zob : byte;
    roh : array[1..4] of byte;
    zober : byte;
    zober_roh : byte;
    tah : array[1..(max*max)+1] of
      record
        zoberie,x,y : byte;
      end;
begin
  for a := 1 to max*max+1 do
    begin
      tah[a].zoberie := 0;
      tah[a].x := 0;
      tah[a].y := 0;
    end;

  for a := 1 to max do
    for b := 1 to max do
      if pole[a,b] = 0 then
        begin
          zob := zoberie(2,a,b);

          if zob > 0 then
            begin
              c := 0;

              repeat
                inc(c);
              until tah[c].zoberie < zob;

              for d := max*max downto c do
                begin
                  tah[d+1].zoberie := tah[d].zoberie;
                  tah[d+1].x := tah[d].x;
                  tah[d+1].y := tah[d].y;
                end;

              tah[c].zoberie := zob;
              tah[c].x := a;
              tah[c].y := b;
            end;
        end;

  a := 0;

  repeat
    a := a + 1;
  until (tah[1].zoberie <> tah[a].zoberie);

  a := a - 1;

  b := 1+Random(a-1);

  for a := 1 to 4 do
    roh[a] := 0;

  if pole[1,1] = 0 then roh[1] := zoberie( 2,   1,   1);
  if pole[max,1] = 0 then roh[2] := zoberie( 2, max,   1);
  if pole[1,max] = 0 then roh[3] := zoberie( 2,   1, max);
  if pole[max,max] = 0 then roh[4] := zoberie( 2, max, max);

  zober_roh := 0;

  zober := 0;

  for a := 1 to 4 do
    if roh[a] > zober_roh then
      begin
        zober_roh := roh[a];
        zober := a;
      end;

  if zober > 0 then
    begin
      case zober of
        1 : if pole[1,1] = 0 then urob_tah(2,1,1);
        2 : if pole[max,1] = 0 then urob_tah(2,max,1);
        3 : if pole[1,max] = 0 then urob_tah(2,1,max);
        4 : if pole[max,max] = 0 then urob_tah(2,max,max);
      end;
    end
      else
        if (tah[b].zoberie > 0) then
            urob_tah(2,tah[b].x,tah[b].y);

  hrac := 1;
end;

{procedure pocitac_mysli2;
var a,b,c,d : word;
    zob : byte;
    roh : array[1..4] of byte;
    zober : byte;
    zober_roh : byte;
    tah : array[1..(max*max)+1] of
      record
        zoberie,x,y : byte;
      end;
begin
  for a := 1 to max*max do
    begin
      tah[a].zoberie := 0;
      tah[a].x := 0;
      tah[a].y := 0;
    end;

  for a := 1 to max do
    for b := 1 to max do
      if pole[a,b] = 0 then
        begin
          zob := zoberie(1,a,b);

          if zob > 0 then
            begin
              c := 0;

              repeat
                inc(c);
              until tah[c].zoberie < zob;

              for d := max*max downto c do
                begin
                  tah[d+1].zoberie := tah[d].zoberie;
                  tah[d+1].x := tah[d].x;
                  tah[d+1].y := tah[d].y;
                end;

              tah[c].zoberie := zob;
              tah[c].x := a;
              tah[c].y := b;
            end;
        end;

  a := 0;

  repeat
    a := a + 1;
  until (tah[1].zoberie <> tah[a].zoberie);

  a := a - 1;

  b := 1+Random(a-1);

  for a := 1 to 4 do
    roh[a] := 0;

  if pole[1,1] = 0 then roh[1] := zoberie( 1,   1,   1);
  if pole[max,1] = 0 then roh[2] := zoberie( 1, max,   1);
  if pole[1,max] = 0 then roh[3] := zoberie( 1,   1, max);
  if pole[max,max] = 0 then roh[4] := zoberie( 1, max, max);

  zober_roh := 0;

  zober := 0;

  for a := 1 to 4 do
    if roh[a] > zober_roh then
      begin
        zober_roh := roh[a];
        zober := a;
      end;

  if zober > 0 then
    begin
      case zober of
        1 : if pole[1,1] = 0 then urob_tah(1,1,1);
        2 : if pole[max,1] = 0 then urob_tah(1,max,1);
        3 : if pole[1,max] = 0 then urob_tah(1,1,max);
        4 : if pole[max,max] = 0 then urob_tah(1,max,max);
      end;
    end
      else
        if (tah[b].zoberie > 0) then
            urob_tah(1,tah[b].x,tah[b].y);

  hrac := 2;
end;}


procedure kontrola;
var a,b : byte;
    k : boolean;
begin
  k := false;

  for a := 1 to max do
    for b := 1 to max do
      if pole[a,b] = 0 then k := true;

  if not k then koniec := true;
end;

begin
  clrscr;
  init_graph;
  init_premenne;
  nakresli_celu_hraciu_plochu;
  ukaz_kurzor;
  randomize;
  repeat
    case hrac of
      1 : citaj_klaves; {pocitac_mysli2;}
      2 : pocitac_mysli1;
    end;
    kontrola;
    ukaz_kurzor;
  until koniec;
  readkey;
  closegraph;
  clrscr;
  Writeln('Have a nice day.');
end.