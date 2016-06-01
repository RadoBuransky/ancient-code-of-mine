{* * * Biliard * * *}
Uses crt,graph;

var ball : array[1..16] of record
                             speed,x,y,smer,v,farba : integer;
                           end;
    koniec : boolean;

procedure stol;
var a : byte;
begin
  {hraci stol}
  SetFillstyle(1,119);
  bar(20,85,620,395);

  {diery}
  setfillstyle(1,black);
  PieSlice(20,85,270,360,13);
  PieSlice(20,395,90,0,13);
  PieSlice(620,395,90,180,13);
  PieSlice(620,85,270,180,13);
  PieSlice(320,75,225,315,13);
  PieSlice(320,405,45,135,13);

  {okraje}
  setcolor(2);

  moveto(10,96);
  lineto(20,101);
  lineto(20,379);
  lineto(10,384);
  lineto(10,96);

  moveto(630,96);
  lineto(620,101);
  lineto(620,379);
  lineto(630,384);
  lineto(630,96);

  moveto(31,75);
  lineto(36,85);
  lineto(304,85);
  lineto(309,75);
  lineto(31,75);

  moveto(331,75);
  lineto(336,85);
  lineto(604,85);
  lineto(609,75);
  lineto(331,75);

  moveto(31,405);
  lineto(36,395);
  lineto(304,395);
  lineto(309,405);
  lineto(31,405);

  moveto(331,405);
  lineto(336,395);
  lineto(604,395);
  lineto(609,405);
  lineto(331,405);

  setfillstyle(1,2);
  floodfill(15,282,2);
  floodfill(622,282,2);
  floodfill(40,78,2);
  floodfill(340,78,2);
  floodfill(40,398,2);
  floodfill(340,398,2);

  {obruba}

  SetFillstyle(1,brown);
  bar(1,65,640,75);
  bar(1,65,10,405);
  bar(1,405,640,415);
  bar(630,65,640,415);

  SetColor(191);
  line(170,86,170,394);

  {inicializacia}
  for a := 1 to 16 do
    begin
      ball[a].speed := 0;
      ball[a].smer := 0;
      ball[a].v := 1;
    end;

  ball[1].x := 439;
  ball[1].y := 228;
  ball[1].farba := 43;

  ball[2].x := 454;
  ball[2].y := 219;
  ball[2].farba := 55;

  ball[3].x := 470;
  ball[3].y := 246;
  ball[3].farba := 40;

  ball[4].x := 486;
  ball[4].y := 201;
  ball[4].farba := 1;

  ball[5].x := 486;
  ball[5].y := 237;
  ball[5].farba := 64;

  ball[6].x := 502;
  ball[6].y := 228;
  ball[6].farba := 116;

  ball[7].x := 502;
  ball[7].y := 264;
  ball[7].farba := 4;

  ball[8].x := 470;
  ball[8].y := 228;
  ball[8].farba := 0;

  ball[9].x := 454;
  ball[9].y := 237;
  ball[9].farba := 43;

  ball[10].x := 470;
  ball[10].y := 210;
  ball[10].farba := 55;

  ball[11].x := 486;
  ball[11].y := 219;
  ball[11].farba := 40;

  ball[12].x := 486;
  ball[12].y := 255;
  ball[12].farba := 1;

  ball[13].x := 502;
  ball[13].y := 192;
  ball[13].farba := 64;

  ball[14].x := 502;
  ball[14].y := 210;
  ball[14].farba := 116;

  ball[15].x := 502;
  ball[15].y := 246;
  ball[15].farba := 4;

  ball[16].x := 170;
  ball[16].y := 228;
  ball[16].farba := 92;

  ball[16].smer := 0;

end;

procedure konec;
begin
  cleardevice;
  closegraph;
  halt;
end;

procedure ukaz_gule;
var a : byte;
    c : string;
begin
  for a := 1 to 16 do
    begin
      if (a in [1..8]) or (a = 16) then
        begin
          setcolor(ball[a].farba);
          setfillstyle(1,ball[a].farba);
          Fillellipse(ball[a].x,ball[a].y,8,8);
        end;
      if a in [9..15] then
        begin
          setcolor(92);
          setfillstyle(1,92);
          Fillellipse(ball[a].x,ball[a].y,8,8);
          setcolor(ball[a].farba);
          SetFillstyle(1,ball[a].farba);
          bar(ball[a].x-5,ball[a].y-5,ball[a].x+5,ball[a].y+5);
          PieSlice(ball[a].x,ball[a].y,135,225,8);
          PieSlice(ball[a].x,ball[a].y,45,0,8);
          PieSlice(ball[a].x,ball[a].y,329,360,8);
        end;
      if a <> 16 then
        begin
          setcolor(black);
          if (a = 8) or
             (a = 4) or
             (a = 12) or
             (a = 15) or
             (a = 7) then setcolor(92);
          Str(a,c);
          if a < 10 then outtextxy(ball[a].x-3,ball[a].y-3,c)
                    else outtextxy(ball[a].x-8,ball[a].y-3,c)
        end;
    end;
end;

procedure zacni;
var d,stoj : byte;

procedure zmaz(a : byte);
begin
  Setfillstyle(1,119);
  setcolor(119);
  fillellipse(ball[a].x,ball[a].y,8,8);
end;


procedure pohni;
var a : byte;

procedure kontrola(a : byte);
begin
  if ball[a].x <= 28 then ball[a].smer := 270-(ball[a].smer-270);
  if ball[a].x >= 612 then ball[a].smer := 270-(ball[a].smer-270);
  if ball[a].y <= 93 then ball[a].smer := 270+(90-ball[a].smer);
  if ball[a].y >= 387 then ball[a].smer := 270+(90-ball[a].smer);
end;


begin
  for a := 1 to 16 do
    begin
      if ball[a].speed > 0 then zmaz(a);
      Inc(ball[a].x,Trunc(Cos(pi/180*(360-ball[a].smer))*ball[a].speed));
      Inc(ball[a].y,Trunc(Sin(pi/180*(360-ball[a].smer))*ball[a].speed));
      if ball[a].speed > 0 then kontrola(a);
      if (ball[a].x >= 162) or (ball[a].x <= 178) then
        begin
          setcolor(191);
          line(170,86,170,394);
          setcolor(119);
        end;
    end;
end;


procedure spomal;
var a : byte;
begin
  stoj := 0;
  for a := 1 to 16 do
    begin
      if ball[a].speed > 0 then Dec(ball[a].speed);
      if (ball[a].speed > 0) and (stoj <= 0) then stoj := 1;
    end;
end;

begin
  ball[16].speed := 10;
  d := 0;
  repeat
    d := d + 1;
    pohni;
    if d = 20 then
      begin
        spomal;
        d := 0;
      end;
    ukaz_gule;
  until stoj = 0;
end;





procedure citaj_kl;
var key : char;
    s : string;

procedure ukaz_smer(a : byte);
begin
  if a = 0 then setcolor(92)
           else setcolor(lightred);
  PieSlice(ball[16].x,ball[16].y,ball[16].smer,ball[16].smer-1,7);
end;

begin
  key := readkey;
  SetFillstyle(1,0);
  bar(1,1,80,20);
  str(ball[16].smer,s);
  outtextxy(10,10,s);
  setfillstyle(1,92);
  ukaz_smer(0);
  case key of
    #75 : Dec(ball[16].smer);
    #77 : Inc(ball[16].smer);
    #13 : zacni;
    #27 : koniec := true;
  end;
  if ball[16].smer < 0 then ball[16].smer := 360 + ball[16].smer;
  if ball[16].smer > 360 then ball[16].smer := ball[16].smer - 360;
  ukaz_smer(1);
end;

procedure init16;
var gd,gm : integer;
begin
  gd := 9;
  gm := 1;
  InitGraph(gd,gm,'');
end;

begin
  clrscr;
  init16;
  stol;
  koniec := false;
  ukaz_gule;
  repeat
    citaj_kl;
  until koniec;
  konec;
end.