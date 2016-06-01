uses crt,graph;

const max_pocet = 10; {maximalny pocet hracov}
      speed = 20; {delay pri lete strely}

type player = record
                pocet_vytazstiev : byte;
                peniaze : word;
                meno : string[15];
              end;
     ScrType = Array[0..199,0..319] of Byte;
     ScrPtr = ^ScrType;
     zbrane = array[1..2] of boolean;
     farby = array[0..255] of record
                                r,g,b : byte;
                              end;

var active : byte; {prave hrajuci tank}
    pocet : byte; {pocet tankov}
    hrac : array[1..max_pocet] of player;
    koniec : boolean; {koniec jedneho kola}
    uplny_koniec : boolean; {koniec celej hry}
    pocet_hier : byte; {kolko kol bude mat hra}
    teraz_hra : byte; {kolkata hra sa teraz hra}

    farba : ^farby; {pole plne farieb}

    tank : array[1..max_pocet] of record
                                    x,y,uhol,sila,energia : integer;
                                    farba : byte;

                                    zbran : zbrane; {ake zbrane ma}
                                    vybrata : byte; {ktoru zbran ma vybratu}

                                    zije : boolean;
                                  end;

    buffer,visual : scrptr; {pointer na druhy visual page}

{$F+}
function DetectVGA256 : Integer;
begin
  DetectVGA256 := 1;
end;
{$F-}

procedure init_graph;
var gd,gm : integer;
begin
  gd := InstallUserDriver('SVGA256',@DetectVGA256);
  gm := 0;
  initgraph(gd,gm,'c:\bp7\bgi\');
end;

procedure rgb(Col,R,G,B : Byte);
BEGIN
     port[$3c8]:=Col;

     port[$3c9]:=r;
     port[$3c9]:=g;
     port[$3c9]:=b;
END;

Procedure Getrgb(Col : Byte; Var R,G,B : Byte);
  { This gets the Red, Green and Blue values of a certain color }
BEGIN
     port[$3c7]:=Col;

     r:=port[$3c9];
     g:=port[$3c9];
     b:=port[$3c9];
END;

Procedure CopyScr(Source,Dest:ScrPtr);Assembler;
Asm
   push  ds
   les   di,Dest
   lds   si,Source
   mov   cx,16000
   db    66h
   rep   movsw
   pop   ds
End;

procedure init_paletu;
var a,r,g,b : byte;
    f : text;
begin
  assign(f,'farby.clr');
  {$I-}
  reset(f);
  {$I+}
  if IOResult <> 0 then
    begin
      closegraph;
      writeln('Nemozem najst subor farby.clr');
      halt;
    end;
  a := 17;
  new(farba);
  while not eof(f) do
    begin
      readln(f,farba^[a].r,farba^[a].g,farba^[a].b);
      rgb(a,farba^[a].r,farba^[a].g,farba^[a].b);
      inc(a);
    end;
  close(f);
end;

procedure urob_krajinu;
var x,y,sy,prve_y : integer;
begin
  setcolor(27);
  randomize;
  y := 140+random(40);
  prve_y := y;
  x := 2;
  moveto(2,y);
  repeat
    sy := y;
    repeat
      y := y-20+random(40);
    until y < 197;

    x := x+random(40);
    if x < 318 then lineto(x,y)
               else lineto(317,y);
  until x > 318;
  lineto(317,198);
  lineto(2,198);
  lineto(2,prve_y);
  setfillstyle(1,27);
  floodfill(3,196,27);
end;

procedure init_premenne;
var a : byte;
begin
  hrac[1].meno := 'Rado';
  hrac[1].pocet_vytazstiev := 0;
  hrac[1].peniaze := 0;

  hrac[2].meno := 'Chudak';
  hrac[2].pocet_vytazstiev := 0;
  hrac[2].peniaze := 0;

  pocet_hier := 10;
  teraz_hra := 1;

  uplny_koniec := false;

  pocet := 2;
  active := 1;

  for a := 1 to pocet do
    begin
      tank[a].uhol := 45;
      tank[a].sila := 150;
      tank[a].farba := 16+a;
      tank[a].energia := 100;

      tank[a].zbran[1] := true;
      tank[a].zbran[2] := true;

      tank[a].vybrata := 1;
      tank[a].zije := true;
    end;

  visual := Ptr($A000,0);
  new(buffer);
end;

procedure zacni_nove_kolo;
var a : byte;
begin
  cleardevice;
  active := 1;

  for a := 1 to pocet do
    begin
      tank[a].uhol := 45;
      tank[a].sila := 150;
      tank[a].farba := 16+a;
      tank[a].energia := 100;

      tank[a].zbran[1] := true;
      tank[a].zbran[2] := true;

      tank[a].vybrata := 1;
      tank[a].zije := true;
    end;
end;

procedure rozmiestni_tanky;
var a,b,sx : integer;
    dobre : boolean;
begin
  randomize;
  sx := 0;
  for a := 1 to pocet do
    begin
      repeat
        tank[a].x := 20+random(280);
        dobre := true;
        for b := 1 to a do
          if (abs(tank[b].x-tank[a].x) < 20) and
             (b <> a) then
            begin
              dobre := false;
              break;
            end;
      until dobre;
      for b := 41 to 199 do
        if getpixel(tank[a].x,b) = 27 then
          begin
            tank[a].y := b;
            break;
          end;
    end;
end;

procedure ukaz_tank(x,y,uhol : integer; farba : byte);
begin
  setcolor(farba);
  setfillstyle(1,farba);
  bar(x-5,y-4,x+5,y);
  bar(x-6,y-3,x+6,y-1);
  bar(x-1,y-6,x+1,y-2);
  bar(x-2,y-5,x+2,y-2);
  line(x,y-5,x+round(cos(pi/180*uhol)*5),y-round(sin(pi/180*uhol)*5)-5);
end;

procedure vybuch(x,y,zbran : word);
var a,b : byte;
    vzdialenost : word;
begin
  case zbran of
    1 : begin
          for a := 10 downto 1 do
            begin
              setfillstyle(1,38-a);
              setcolor(38-a);
              fillellipse(x,y,a,a);
            end;
          for a := 10 downto 1 do
            begin
              for b := 1 to a do
                rgb(27+b,farba^[(37-a)+b].r,farba^[(37-a)+b].g,farba^[(37-a)+b].b);
              for b := a to 10 do
                rgb(27+b,farba^[37-b+a].r,farba^[37-b+a].g,farba^[37-b+a].b);
              delay(50);
            end;
          setcolor(black);
          setfillstyle(1,black);
          fillellipse(x,y,10,10);

          for a := 1 to pocet do
            begin
              vzdialenost := round(sqrt(sqr(tank[a].x-x)+sqr(tank[a].y-y)));
              if vzdialenost in [11..21] then
                   begin
                     if (22-vzdialenost) * 5 >= tank[a].energia then
                       begin
                         tank[a].zije := false;
                         ukaz_tank(tank[a].x,tank[a].y,tank[a].uhol,black);
                       end
                         else
                       begin
                         dec(tank[a].energia,(22-vzdialenost) * 5);
                         ukaz_tank(tank[a].x,tank[a].y,tank[a].uhol,tank[a].farba);
                       end;
                   end
                     else
              if vzdialenost < 11 then
                   begin
                     tank[a].zije := false;
                     ukaz_tank(tank[a].x,tank[a].y,tank[a].uhol,black);
                   end;
            end;
        end;
  end;
end;

procedure zije_este_niekto;
var a,poc : byte;
begin
  poc := 0;
  for a := 1 to pocet do
    if tank[a].zije then inc(poc);
  if poc < 2 then
    begin
      inc(teraz_hra);
      if teraz_hra > pocet_hier then uplny_koniec := true;
      koniec := true;
      for a := 1 to pocet do
        if tank[a].zije then inc(hrac[a].pocet_vytazstiev);
    end;
end;

procedure strela(x,y : real;uhol,sila : integer);
var narazil,daleko : boolean;
    vx,vy : real;
    sx,sy : real;

procedure ukaz_kde_je_strela(x,y : integer;farba : byte);
begin
  if y < 40 then y := 40;
  if y > getmaxy-1 then y := getmaxy-1;
  if x < 1 then x := 1;
  if x > getmaxx-1 then x := getmaxx-1;
  putpixel(0,y,farba);
  putpixel(getmaxx,y,farba);
  putpixel(x,39,farba);
  putpixel(x,getmaxy,farba);
end;

procedure kontrola(x,y : integer);
begin
  if (x >= getmaxx-1) or
     (x <= 1) or
     (y >= getmaxy-1) then daleko := true;

  if (getpixel(x,y) <> black) and
     (y > 40) then narazil := true;
end;

begin
  x := x+(cos(pi/180*uhol)*7);
  y := y-(sin(pi/180*uhol)*7)-5;

  narazil := false;
  daleko := false;

  vx := cos(pi/180*uhol)*sila/50;
  vy := -sin(pi/180*uhol)*sila/50;

  sx := x;
  sy := y;

  repeat
    repeat
      vy := vy + 0.1;
      y := y + vy;
      x := x + vx;
    until (y <> sy) or (x <> sx);
    if round(sy) = 40 then putpixel(round(sx),round(sy),darkgray)
                      else putpixel(round(sx),round(sy),black);
    ukaz_kde_je_strela(round(sx),round(sy),38);
    sx := x;
    sy := y;
    kontrola(round(x),round(y));
    if not narazil and not daleko then
      begin
        if sy > 40 then putpixel(round(x),round(y),white);
        ukaz_kde_je_strela(round(x),round(y),lightgreen);
        delay(speed);
      end;
  until narazil or daleko;

  if narazil and not daleko then vybuch(round(x),round(y),tank[active].vybrata);

  zije_este_niekto;
end;

procedure ukaz_hru(farba : byte);
var s : string;
begin
  setcolor(farba);
  str(pocet_hier+1-teraz_hra,s);
  outtextxy(82,12,s);
end;

procedure ukaz_silu(farba : byte);
var s : string;
begin
  setcolor(farba);
  str(tank[active].sila,s);
  outtextxy(180,2,s);
end;

procedure ukaz_energiu(farba : byte);
var s : string;
begin
  setcolor(farba);
  str(tank[active].energia,s);
  outtextxy(180,12,s);
end;

procedure ukaz_peniaze(farba : byte);
var s : string;
begin
  setcolor(farba);
  str(hrac[active].peniaze,s);
  outtextxy(287,12,s);
end;

procedure ukaz_uhol(farba : byte);
var s : string;
begin
  setcolor(farba);
  str(tank[active].uhol,s);
  outtextxy(287,2,s);
end;

procedure ukaz_zaklad;
var a : byte;
begin
  setcolor(darkgray);
  rectangle(1,40,getmaxx-1,getmaxy-1);

  setfillstyle(1,38);
  floodfill(0,0,darkgray);

  setcolor(yellow);
  for a := 1 to hrac[active].pocet_vytazstiev do
    line(a*2,23,a*2+1,22);

  setcolor(lightgray);
  outtextxy(2,12,'Este hier');
  outtextxy(109,2,'Sila');
  outtextxy(216,2,'Uhol');
  outtextxy(109,12,'Energia');
  outtextxy(216,12,'$');

  setcolor(tank[active].farba);
  outtextxy(54-(length(hrac[active].meno) div 2)*7,2,hrac[active].meno);

  ukaz_silu(white);
  ukaz_uhol(white);
  ukaz_peniaze(white);
  ukaz_energiu(white);
  ukaz_hru(white);
end;


procedure ukaz_vsetko;
var a : byte;
begin
  setfillstyle(1,black);
  bar(0,0,319,39);
  ukaz_zaklad;
  for a := 1 to pocet do
    ukaz_tank(tank[a].x,tank[a].y,tank[a].uhol,tank[a].farba);
end;

procedure citaj_klaves;
var key : char;
begin
  key := readkey;
  case key of
    #27 : begin
            koniec := true;
            uplny_koniec := true;
          end;
    #13 : begin
            strela(tank[active].x,tank[active].y,tank[active].uhol,tank[active].sila);
            inc(active);
            if active > pocet then active := 1;
            ukaz_vsetko;
          end;
    #75 : begin
            ukaz_uhol(black);
            ukaz_tank(tank[active].x,tank[active].y,tank[active].uhol,black);
            inc(tank[active].uhol,2);
            if tank[active].uhol > 180 then tank[active].uhol := 0;
            ukaz_uhol(white);
            ukaz_tank(tank[active].x,tank[active].y,tank[active].uhol,tank[active].farba);
          end;
    #77 : begin
            ukaz_uhol(black);
            ukaz_tank(tank[active].x,tank[active].y,tank[active].uhol,black);
            dec(tank[active].uhol,2);
            if tank[active].uhol < 0 then tank[active].uhol := 180;
            ukaz_uhol(white);
            ukaz_tank(tank[active].x,tank[active].y,tank[active].uhol,tank[active].farba);
          end;
    #72 : begin
            ukaz_silu(black);
            inc(tank[active].sila,2);
            if tank[active].sila > 1000 then tank[active].sila := 1000;
            if tank[active].sila > tank[active].energia*10 then
              tank[active].sila := tank[active].energia*10;
            ukaz_silu(white);
          end;
    #80 : begin
            ukaz_silu(black);
            dec(tank[active].sila,2);
            if tank[active].sila < 0 then tank[active].sila := 0;
            ukaz_silu(white);
          end;

  end;
end;

begin
  init_graph;
  init_premenne;
  init_paletu;

  repeat
    zacni_nove_kolo;

    urob_krajinu;
    rozmiestni_tanky;
    koniec := false;

    ukaz_vsetko;
    repeat
      citaj_klaves;
    until koniec;
  until uplny_koniec;
  dispose(farba);
end.