{898}
program TANKERS;

uses crt,graph;


const n = 4;
      zbrane : array[1..n] of string = ('FLUSATKO',
                                        '2x FLUSATKO',
                                        'MEGAFLUS',
                                        'NAPALM DEATH');
      naboje : array[1..n+1] of byte =(10,5,2,1,0);
      cena : array[1..n+1] of word = (500,1500,3000,5000,0);

var pocet_hr : byte;
    meno : array[1..10] of string;
    money : array[1..10] of word;
    sur : array[1..10] of record {suradnice tankov}
                            x,y : integer;
                          end;
    farba : array[1..10] of byte; {farba tanku}
    uhol : array[1..10] of byte;
    sila : array[1..10] of word;
    zivy : array[1..10] of boolean;
    zbran : array[0..10] of byte;
    ma_naboj : array[1..10,0..n] of byte;




procedure koniec;
begin
  closegraph;
  clrscr;
  Write('Have a nice day.');
  halt;
end;

procedure vret; assembler;
 asm
   mov dx,3dah
   @L1:
   in al,dx
   test al,8
   jz @L1
end;


Procedure rgb(Color,wr,wg,wb : Byte);

begin;
  Port[$3C8]:=Color;
  Port[$3C9]:=wr;
  Port[$3C9]:=wg;
  Port[$3C9]:=wb;
end;

procedure init16;
var gd,gm : integer;
begin;
 gd := 9;
 gm := 1;
 InitGraph(gd,gm,'');
end;


procedure nova_hra;

var hot,konec : boolean;
    a,b : byte;
    hra,zabiti : byte;
    c : char;
    p : integer;

procedure nacitaj_mena;

var a : byte;
    c : char;

procedure zaklad;
var s : string;
begin
  SetFillstyle(1,2);
  bar(220,100,420,180);
  SetColor(1);
  Rectangle(220,100,420,180);
  line(220,120,420,120);
  SetColor(4);
  Outtextxy(285,107,'H R A C');
  Str(a,s);
  Outtextxy(355,107,s);
  Outtextxy(240,130,'M E N O : ');
end;

procedure ukaz_meno;
begin
  SetFillStyle(1,0);
  Bar(240,140,400,160);
  SetColor(white);
  Outtextxy(245,148,meno[a]);
  line(245+(length(meno[a])*8),158,253+(length(meno[a])*8),158);
end;

procedure pridaj;
begin
  meno[a] := Concat(meno[a],char(c));
end;

procedure zmaz;
begin
  Delete(meno[a],length(meno[a]),1);
end;


begin
  for a := 1 to 10 do meno[a] := '';
  for a := 1 to pocet_hr do
    begin
      zaklad;
      repeat
        vret;
        ukaz_meno;
        c := readkey;
        if c = #8 then zmaz;
        if ((Char(c) in ['a'..'z']) or
           (Char(c) in ['A'..'Z'])) and
           (c <> #13) and
           (c <> #27) and
           (c <> #8) and
           (length(meno[a]) < 16) then pridaj;
      until c = #13;
    end;
end;

procedure urob_krajinu;
var x,y,xx,yy : integer;
begin
  setcolor(2);
  rectangle(10,40,630,340);
  RGB(3,0,63,10);

  Randomize;
  x := Random(140);

  SetColor(3);
  moveto(11,339);
  y := 300-x;
  lineto(11,y);

  x := 10;
  xx := x;
  yy := y;
  repeat
    x := xx + 1+Random(70);
    repeat
      y := (yy+40)-Random(80);
    until (y < yy+(x-xx)) and (y > yy-(x-xx)) and (y < 300) and (y > 140);

    if x < 629 then line(xx,yy,x,y)
               else line(xx,yy,629,y);
    xx := x;
    yy := y;
  until x > 629;
  line(629,y,629,339);
  line(629,339,11,339);
  SetFillStyle(1,3);
  Floodfill(12,338,3);
end;

procedure tank(clr,x,y,uhol : integer); {nakresli tank}
begin
  SetColor(clr);
  moveto(x,y);
  lineto(x-10,y);
  lineto(x-11,y-1);
  lineto(x-11,y-2);
  lineto(x-10,y-3);
  lineto(x+10,y-3);
  lineto(x+11,y-2);
  lineto(x+11,y-1);
  lineto(x+10,y);
  lineto(x,y);
  SetFillstyle(1,clr);
  Floodfill(x,y-1,clr);
  Circle(x,y-3,3);
  Floodfill(x,y-5,clr);
  line(x,y-3,Round(x+(cos(pi/180*uhol))*10),round(y-(sin(pi/180*uhol))*10));
end;

procedure daj_tanky;
var a,b : byte;
    dobre : boolean;
begin
  Randomize;
  for a := 1 to pocet_hr do
    begin
      repeat
        dobre := true;
        sur[a].x := 30 + Random(580);

        for b := 1 to a-1 do
          if (sur[a].x < (sur[b].x + 40)) and
             (sur[a].x > (sur[b].x - 40)) then dobre := false;
          if a = 1 then dobre := true;

      until dobre;
      sur[a].y := 100;
      uhol[a] := 90;
      sila[a] := 200;
      zivy[a] := true;
      repeat
        Inc(sur[a].y);
      until (getpixel(sur[a].x,sur[a].y+1) <> 0) or (sur[a].y > 470);
      tank(farba[a] , sur[a].x , sur[a].y , uhol[a]);
    end;
end;

procedure vypis_stav;
var s,ss : string;
begin

  SetFillStyle(1,0);
  bar(0,0,640,29);

  SetColor(farba[hra]);
  Outtextxy(15,10,meno[hra]);
  SetColor(2);
  Outtextxy(145,10,'ZBRAN');
  if zbran[hra] =  0 then Outtextxy(145,20,'KAMEN')
                     else
    begin
      Str(ma_naboj[hra,zbran[hra]],ss);
      s := Concat(zbrane[zbran[hra]],' [',ss,']');
      Outtextxy(160-((length(s) div 2 )*7),20,s);
    end;

  Outtextxy(265,10,'PRACHY');
  Str(money[hra],s);
  Outtextxy(287-((length(s)div 2)*7),20,s);
  Outtextxy(390,10,'UHOL');
  Outtextxy(515,10,'SILA');
  Str(uhol[hra],s);
  Outtextxy(402-((length(s) div 2) * 7),20,s);
  Str(sila[hra],s);
  Outtextxy(527-((length(s) div 2) * 7),20,s);

end;

procedure leti;
var dt,ax,ay,c1,c2,t,m,a,xx,x,yy,y,speed,spx,spy,Fg,Fodx,Fody : real;
    vnutri : boolean;
    p : integer;
    zvuk : word;
    zab : byte;

procedure napalm;
var n,a,b : word;
    c : byte;
    dolava : boolean;
begin
  n := 0;
  rgb(15,63,50,60);
  rgb(14,62,52,61);
  rgb(13,61,54,62);
  rgb(12,60,56,63);
  a := Round(x);
  b := Round(y)-1;
  c := 0;
  repeat
    if GetPixel(a-c,b+1) <> 3 then dolava := true;
    if GetPixel(a+c,b+1) <> 3 then dolava := false;
    c := c + 1;
  until (GetPixel(a-c,b+1) <> 3) or
        (GetPixel(a+c,b+1) <> 3);
  if dolava then
      repeat
        Dec(a);
        if getpixel(a,b+1) <> 3 then b := b + 1;
        if getpixel(a,b) = 3 then exit;
        Putpixel(a,b,12+random(3));
      until false
    else
      repeat
        Inc(a);
        if getpixel(a,b+1) <> 3 then b := b + 1;
        if getpixel(a,b) = 3 then exit;
        Putpixel(a,b,12+random(3));
      until false;
  repeat
  until n = 300;
end;

procedure aky_vybuch(a : byte);
var b : byte;
begin
  case a of
    0 : begin
          SetFillstyle(1,0);
          SetColor(0);
          FillEllipse(Round(x),Round(y),10,10);
          for b := 1 to pocet_hr do
            begin
              if Sqrt(Sqr(Abs(x-sur[b].x))+Sqr(Abs(y-sur[b].y))) < 10 then
                begin
                  tank(farba[b],sur[b].x,sur[b].y,uhol[b]);
                  tank(0,sur[b].x,sur[b].y,uhol[b]);
                  zivy[b] := false;
                  Inc(zabiti);
                end;
            end;
        end;
    1 : begin
          SetFillstyle(1,0);
          SetColor(0);
          FillEllipse(Round(x),Round(y),15,15);
          for b := 1 to pocet_hr do
            begin
              if Sqrt(Sqr(Abs(x-sur[b].x))+Sqr(Abs(y-sur[b].y))) < 15 then
                begin
                  tank(farba[b],sur[b].x,sur[b].y,uhol[b]);
                  tank(0,sur[b].x,sur[b].y,uhol[b]);
                  zivy[b] := false;
                  Inc(zabiti);
                end;
            end;
        end;
    2 : begin
          SetFillstyle(1,0);
          SetColor(0);
          FillEllipse(Round(x),Round(y),20,20);
          for b := 1 to pocet_hr do
            begin
              tank(farba[b],sur[b].x,sur[b].y,uhol[b]);
              if Sqrt(Sqr(Abs(x-sur[b].x))+Sqr(Abs(y-sur[b].y))) < 20 then
                begin
                  tank(farba[b],sur[b].x,sur[b].y,uhol[b]);
                  tank(0,sur[b].x,sur[b].y,uhol[b]);
                  zivy[b] := false;
                  Inc(zabiti);
                end;
            end;
        end;
    3 : begin
          SetFillstyle(1,0);
          SetColor(0);
          FillEllipse(Round(x),Round(y),50,50);
          for b := 1 to pocet_hr do
            begin
              if Sqrt(Sqr(Abs(x-sur[b].x))+Sqr(Abs(y-sur[b].y))) < 50 then
                begin
                  tank(farba[b],sur[b].x,sur[b].y,uhol[b]);
                  tank(0,sur[b].x,sur[b].y,uhol[b]);
                  zivy[b] := false;
                  Inc(zabiti);
                end;
            end;
        end;
    4 : napalm;
  end;
end;

procedure vybuch;
var a : byte;
begin
  zab := zabiti;

  aky_vybuch(zbran[hra]);

  zab := zabiti - zab;

  if (zab > 0) and
     (zivy[hra]) then
    money[hra] := money[hra] + ((zab * (pocet_hr * 1500)) div
                                          (pocet_hr - zabiti));

  setcolor(2);
  rectangle(10,40,630,340);

  if ma_naboj[hra,zbran[hra]] > 0 then
  ma_naboj[hra,zbran[hra]] := ma_naboj[hra,zbran[hra]] - 1;

  repeat
    Inc(zbran[hra]);
    if zbran[hra] > n then zbran[hra] := 0;
  until (ma_naboj[hra,zbran[hra]] > 0) or
        (zbran[hra] = 0);

  for a := 1 to pocet_hr do
    begin
      if zivy[a] then
        begin
          tank(0,sur[a].x,sur[a].y,uhol[a]);
          tank(farba[a],sur[a].x,sur[a].y,uhol[a])
        end;
    end;
end;

begin
  vnutri := true;
  x := sur[hra].x+(cos(pi/180*uhol[hra]))*10;
  y := sur[hra].y-(sin(pi/180*uhol[hra]))*10;
  speed := sila[hra]/4;
  spx := cos(pi/180*uhol[hra])*speed;
  spy := sin(pi/180*uhol[hra])*speed;;
  m := 500;
  Fg := m * 9.81;
  t := 0;
  c1 := 6*pi*(2/100000)*0.04;
  c2 := 1/2*pi*0.37*1.2*Sqr(0.04);
  speed := sqrt(sqr(spx)+sqr(spy));
  SetFillstyle(1,lightgreen);
  SetColor(lightgreen);
  xx := x;
  yy := y;
  repeat
    if vnutri then Putpixel(Round(x),Round(y),white);
    Fodx := -c1*spx - c2*speed*spx;
    Fody := -c1*spy - c2*speed*spy;
    ax := Fodx/m;
    ay := (-Fg+Fody)/m;
    dt := speed/300000;
    spx := spx+ax*dt;
    spy := spy+ay*dt;
    xx := x;
    yy := y;
    x := x+spx*dt+ax/2*Sqr(dt);
    y := y-spy*dt+ay/2*Sqr(dt);
    if (x > 629) or
       (x < 11) or
       (y > 349) or
       (y < 41) then vnutri := false
                 else vnutri := true;
    t := t + dt;
    if vnutri then Putpixel(Round(xx),Round(yy),black);
    if (Round(x) = 629) or
       (Round(x) = 11) or
       (Round(y) = 350) or
       (Round(y) = 41) then Putpixel(Round(x),Round(y),black);
    if y > 350 then exit;

  until ((Getpixel(Round(x),Round(y)) <> 0) and (vnutri));

  vybuch;
end;

procedure kupuj(a : byte);
var aktiv,b,f : byte;
    c : char;
    s : string;
    hotovo : boolean;

procedure urob_ramy(x,y : byte);
var d : byte;
begin
  for d := 1 to y do
    begin
      setfillstyle(1,0);
      Bar((x*310)+10,30+((d-1)*30),(x*310)+320,30+(d*30));
      Rectangle((x*310)+10,30+((d-1)*30),(x*310)+320,30+(d*30));
    end;
end;


procedure vypis_zbrane;
var d,e : byte;
    s,ss : string;
begin

  d := 0;
  e := 0;
  repeat
    Inc(d);
    if d <= 10 then
      begin
        Inc(e);
        SetColor(lightred);
        Str(ma_naboj[a,d],ss);
        s := Concat(zbrane[d],' [',ss,']');
        Outtextxy(20,35+((e-1)*30),s);
        SetColor(2);
        Str(cena[d],s);
        Str(naboje[d],ss);
        s := Concat('CENA ZA '+ss+' NABOJOV : '+s);
        Outtextxy(20,48+((e-1)*30),s);
      end;
  until d = n;
end;

procedure aktivny(f : byte);
begin
  SetFillstyle(1,f);
  Bar(270,35+((aktiv-1)*30),300,55+((aktiv-1)*30));
end;

procedure kup;
begin
  SetColor(0);
  Str(money[a],s);
  s := Concat('PENIAZE : '+s);
  Outtextxy(10,10,s);
  money[a] := money[a] - (cena[aktiv]*naboje[aktiv]);
  ma_naboj[a,aktiv] := ma_naboj[a,aktiv] + naboje[aktiv];
  SetColor(2);
  Str(money[a],s);
  s := Concat('PENIAZE : '+s);
  Outtextxy(10,10,s);
  aktiv := 1;
end;

procedure vypis_meno;
begin
  SetColor(farba[a]);
  Outtextxy(320 - ((length(meno[a]) div 2) * 7),10,meno[a]);

  if meno[a] = '' then
    begin
      Str(a,s);
      s := Concat('Hrac'+s);
      Outtextxy(320 - ((length(s) div 2) * 7),10,s);
    end;
end;

begin
  SetFillstyle(1,0);
  bar(0,0,630,350);
  SetFillstyle(1,farba[a]);
  bar(2,22,637,345);
  SetFillstyle(1,0);
  bar(10,35,630,330);
  SetColor(farba[a]);
  Outtextxy(320-((Length(meno[a])*8) div 2),10,meno[a]);
  SetColor(2);
  Str(money[a],s);
  s := Concat('PENIAZE : '+s);
  Outtextxy(10,10,s);
  aktiv := 1;
  urob_ramy(0,10);
  urob_ramy(1,10);
  vypis_zbrane;
  repeat
    hotovo := true;
    urob_ramy(0,n);
    aktivny(lightred);
    vypis_zbrane;
    c := readkey;
    aktivny(0);
    case c of
      #80 : if aktiv+1 < n+1 then Inc(aktiv);
      #72 : if aktiv-1 > 0 then Dec(aktiv);
      #13 : if (cena[aktiv]*naboje[aktiv]) <= money[a] then kup;
    end;
    for f := 1 to n do
      if (cena[f]*naboje[f]) <= money[a] then hotovo := false;
  until (c = #27) or hotovo;
end;

procedure ktory;
begin
  SetColor(farba[hra]);
  Rectangle(0,30,640,350);
  Rectangle(9,39,631,341);
  SetFillStyle(1,farba[hra]);
  Floodfill(7,32,farba[hra]);
end;

begin {procedure nova_hra}
  konec := false;
  SetFillstyle(1,0);
  Bar(0,0,640,350);
  nacitaj_mena;
  cleardevice;
  for a := 1 to pocet_hr do
    begin
     money[a] := 0;
     farba[a] := 5 + a;
     zbran[a] := 0;
     for b := 1 to n do
        ma_naboj[a,b] := 0;
    end;
    ma_naboj[1,4] := 10;
    ma_naboj[2,4] := 10;
  Repeat

    for a := 1 to pocet_hr do
      if money[a] > 0 then
        begin
          hot := true;
          for b := 1 to n do
            begin
              if (cena[b]*naboje[b]) <= money[a] then hot := false
            end;
            if hot = false then kupuj(a);
        end;

    cleardevice;
    urob_krajinu;
    daj_tanky;
    zabiti := 0;
    hra := 0;
    repeat
      repeat
        Inc(hra); {ktory hrac prave teraz hra}
        if hra > pocet_hr then hra := 1;
      until zivy[hra];
      ktory;
      repeat

        vypis_stav;


        c := readkey;
        if zivy[hra] then tank(0,sur[hra].x,sur[hra].y,uhol[hra]);

          {ak tank zije, tak ho zmaze}
        case c of
          #75 : if uhol[hra] < 180 then Inc(uhol[hra]);
          #77 : if uhol[hra] > 0 then Dec(uhol[hra]);
          #72 : if sila[hra] < 400 then Inc(sila[hra]);
          #80 : if sila[hra] > 0 then Dec(sila[hra]);
          #9 :  repeat
                  Inc(zbran[hra]);
                  if zbran[hra] > n then zbran[hra] := 0;
                until (ma_naboj[hra,zbran[hra]] > 0) or
                      (zbran[hra] = 0);
          #27 : koniec;
        end;
        if zbran[hra] > n then zbran[hra] := 0;

        {ak tank zije, tak ho nakresli}
        if zivy[hra] then tank(farba[hra],sur[hra].x,sur[hra].y,uhol[hra]);
        vret;

      until c = #13;
      leti; {bomba leti (samozrejme dokym nepadne)}
    until (zabiti = pocet_hr - 1) or (zabiti = pocet_hr);

  until konec;
end;


procedure urob_zaciatok; {nakresli,urobi a vsetko ostatne; uvodne menu}

const n = 3;
      menu : array[1..n] of String = ('NOVA HRA',
                                      'POCET HRACOV',
                                      '!?! KONIEC !?!');
var   active : shortint;

procedure pozadie;

begin
  RGB(0,5,0,20);
  SetFillStyle(1,0);
  Bar(0,0,640,350);
end;

procedure nakresli_menu;
begin
  RGB(2,50,53,23);
  SetFillStyle(1,2);
  Bar(220,210-((n+1)div 2 *30),420,240+((n+1)div 2 *30));
end;

procedure nakresli_nazov;

procedure T(x,y : word);
begin
  moveto(x,y);
  lineto(x+77,y);
  lineto(x+77,y+30);
  lineto(x+48,y+20);
  lineto(x+77,y+70);
  lineto(x,y+70);
  lineto(x+28,y+20);
  lineto(x,y+30);
  lineto(x,y);
  Floodfill(x+10,y+10,10);
end;

procedure A(x,y : word);
begin
  moveto(x,y+70);
  lineto(x+33,y);
  lineto(x+43,y);
  lineto(x+77,y+70);
  lineto(x+47,y+70);
  lineto(x+38,y+50);
  lineto(x+29,y+70);
  lineto(x,y+70);
  moveto(x+34,y+40);
  lineto(x+38,y+30);
  lineto(x+42,y+40);
  lineto(x+34,y+40);
  Floodfill(x+10,y+60,10);
end;

procedure N(x,y : word);
begin
  moveto(x,y);
  lineto(x+20,y);
  lineto(x+57,y+30);
  lineto(x+38,y);
  lineto(x+77,y);
  lineto(x+77,y+70);
  lineto(x+57,y+70);
  lineto(x+20,y+40);
  lineto(x+38,y+70);
  lineto(x,y+70);
  lineto(x,y);
  FloodFill(x+10,y+10,10);
end;

procedure K(x,y : word);
begin
  moveto(x,y);
  lineto(x+30,y);
  lineto(x+20,y+25);
  lineto(x+40,y);
  lineto(x+77,y);
  lineto(x+40,y+38);
  lineto(x+77,y+70);
  lineto(x+40,y+70);
  lineto(x+20,y+45);
  lineto(x+30,y+70);
  lineto(x,y+70);
  lineto(x,y);
  FloodFill(x+10,y+10,10);
end;

procedure E(x,y : word);
begin
  moveto(x,y);
  lineto(x+77,y);
  lineto(x+77,y+20);
  lineto(x+20,y+10);
  lineto(x+20,y+30);
  lineto(x+67,y+25);
  lineto(x+67,y+47);
  lineto(x+20,y+42);
  lineto(x+20,y+60);
  lineto(x+77,y+50);
  lineto(x+77,y+70);
  lineto(x,y+70);
  lineto(x,y);
  FloodFill(x+10,y+10,10);
end;

procedure R(x,y : word);
begin
  moveto(x,y);
  lineto(x+77,y);
  lineto(x+50,y+38);
  lineto(x+77,y+70);
  lineto(x+40,y+70);
  lineto(x+20,y+38);
  lineto(x+30,y+70);
  lineto(x,y+70);
  lineto(x,y);
  moveto(x+20,y+15);
  lineto(x+40,y+15);
  lineto(x+20,y+30);
  lineto(x+20,y+15);
  FloodFill(x+10,y+10,10);
end;

procedure S(x,y : word);
begin
  moveto(x,y);
  lineto(x+77,y);
  lineto(x+77,y+30);
  lineto(x+20,y+10);
  lineto(x+77,y+70);
  lineto(x,y+70);
  lineto(x,y+40);
  lineto(x+57,y+60);
  lineto(x,y);
  FloodFill(x+15,y+10,10);
end;


begin
  RGB(1,63,63,23);
  Setcolor(10);
  SetFillstyle(1,1);
  T(50,10);
  A(130,10);
  N(210,10);
  K(290,10);
  E(370,10);
  R(450,10);
  S(532,10);
end;

procedure citaj_v_menu;

var c : char;
    a : byte;

begin
  active := 1;
  RGB(3,63,0,40);
  RGB(4,0,0,63);
  SetColor(4);
  repeat
    for a := 1 to n do
      begin
        if a = active then setfillstyle(1,3)
                      else setfillstyle(1,2);
        if a = active then setColor(white)
                      else setColor(4);
        Bar(230,150+(a*30),410,150+((a+1)*30));
        Outtextxy(320-(length(menu[a])div 2)*8,162+(a*30),menu[a]);
      end;
    c := readkey;
    case c of
      #72 : Dec(active);
      #80 : Inc(active);
    end;
    if active < 1 then active := n;
    if active > n then active := 1;
  until c = #13;
end;

procedure pocet_hracov;

var c : char;

procedure zaklad;
begin
  SetFillstyle(1,2);
  bar(220,100,420,180);
  SetColor(4);
  Outtextxy(275,120,'POCET HRACOV');
end;

procedure vypis_stav;
var s : string;
begin
  SetFillstyle(1,2);
  Bar(260,140,380,170);
  SetColor(red);
  Str(pocet_hr,s);
  Outtextxy(320,150,s);
end;

procedure sipky;
begin
  RGB(5,63,0,0);

  if c = #75 then
    begin
      SetFillstyle(1,5);
      SetColor(5);
    end
              else
    begin
      SetFillstyle(1,1);
      SetColor(1);
    end;

  moveto(230,153);
  lineto(240,143);
  lineto(240,163);
  lineto(230,153);

  if c = #75 then floodfill(235,153,5)
             else floodfill(235,153,1);

  if c = #77 then
    begin
      SetFillstyle(1,5);
      SetColor(5);
    end
              else
    begin
      SetFillstyle(1,1);
      SetColor(1);
    end;

  moveto(410,153);
  lineto(400,143);
  lineto(400,163);
  lineto(410,153);

  if c = #77 then floodfill(405,153,5)
             else floodfill(405,153,1);
end;

begin
  cleardevice;
  zaklad;
  repeat
    vypis_stav;
    sipky;
    c := readkey;

    case c of
      #77 : inc(pocet_hr);
      #75 : Dec(pocet_hr);
    end;

    if pocet_hr > 10 then pocet_hr := 10;
    if pocet_hr < 2 then pocet_hr := 2;
  until (c = #13) or (c = #27);
  urob_zaciatok;
end;

begin
  pozadie;
  nakresli_nazov;
  nakresli_menu;
  citaj_v_menu;
  case active of
    1 : nova_hra;
    2 : pocet_hracov;
    3 : koniec;
  end;
end;

begin
  clrscr;
  init16;
  pocet_hr := 2;
  urob_zaciatok;
  RGB(0,5,0,20);
  RGB(1,63,63,23);
  RGB(2,50,53,23);
  RGB(3,63,0,40);
  RGB(4,0,0,63);
  RGB(5,63,0,0);
  nova_hra;
end.

