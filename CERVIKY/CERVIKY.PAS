{hra pre male deti}

{687}

program cervici;

Uses keyb,crt,ini,graph;

const poc_ciar = 3;
      zac_sp : real = 0.004;

type ciara = array[1..poc_ciar] of
  record
    x,y : real;
    x1,y1,x2,y2 : integer;
    sx1,sy1,sx2,sy2 : integer;
    sx,sy : real;
  end;

const max_pocet_hracov = 8;
      farby_hracov : array[1..max_pocet_hracov] of word =
        (white,green,red,blue,yellow,cyan,lightmagenta,lightgray);

      kod_kl : array[1..max_pocet_hracov,1..2,1..3] of byte =
      ((($53,$4F,$51),($D3,$CF,$D1)), {del,end,pgdwn}
       (($02,$03,$04),($82,$83,$84)), {1,2,3}
       (($32,$33,$34),($B2,$B3,$B4)), {m,,,.}
       (($1F,$20,$21),($9F,$A0,$A1)), {s,d,f}
       (($4C,$48,$35),($CC,$C8,$B5)), {5,8,/}
       (($29,$0F,$3A),($A9,$8F,$BA)), {`,tab,caps}
       (($2C,$2D,$2E),($AC,$AD,$AE)), {z,x,c}
       (($19,$1A,$1B),($99,$9A,$9B))); {p,[,]}

var x : array[1..max_pocet_hracov] of real;
    y : array[1..max_pocet_hracov] of real;
    sp : array[1..max_pocet_hracov] of real;
    smer : array[1..max_pocet_hracov] of real;

    body : array[1..max_pocet_hracov] of integer;

    xx : array[1..max_pocet_hracov] of integer;
    yy : array[1..max_pocet_hracov] of integer;

    dop : array[1..max_pocet_hracov] of boolean;
    dol : array[1..max_pocet_hracov] of boolean;
    activ : array[1..max_pocet_hracov] of boolean;

    funkcia : array[1..max_pocet_hracov] of byte;
      {1 - killer}

    zbran : array[1..max_pocet_hracov] of ciara;

    leti : array[1..max_pocet_hracov] of boolean;

    smer_st : array[1..max_pocet_hracov] of real;
    sp_st : real;

    a,b : byte;
    skonci : boolean;

    zivi : byte;

    uhol : real;
    hraci : byte;
    pixle : array[1..max_pocet_hracov,1..5] of record
                                                 x,y : integer;
                                                end;

label 1;

procedure palicky(x,y : integer;
                  k : real;
                  a,b,c,d,e,f,g,farba : byte);
begin
  setcolor(farba);
  SetFillStyle(1,farba);
  if a = 1 then
    begin
      moveto(x,y);
      lineto(Round(x+5*k),Round(y-5*k));
      lineto(Round(x+20*k),Round(y-5*k));
      lineto(Round(x+25*k),y);
      lineto(Round(x+20*k),Round(y+5*k));
      lineto(Round(x+5*k),Round(y+5*k));
      lineto(x,y);
      floodfill(Round(x+10*k),y,farba);
    end;
  if b = 1 then
    begin
      moveto(Round(x+25*k),y);
      lineto(Round(x+30*k),Round(y+5*k));
      lineto(Round(x+30*k),Round(y+27*k));
      lineto(Round(x+25*k),Round(y+32*k));
      lineto(Round(x+20*k),Round(y+27*k));
      lineto(Round(x+20*k),Round(y+5*k));
      lineto(Round(x+25*k),y);
      floodfill(Round(x+25*k),Round(y+10*k),farba);
    end;
  if c = 1 then
    begin
      moveto(Round(x+25*k),Round(y+32*k));
      lineto(Round(x+30*k),Round(y+37*k));
      lineto(Round(x+30*k),Round(y+60*k));
      lineto(Round(x+25*k),Round(y+65*k));
      lineto(Round(x+20*k),Round(y+60*k));
      lineto(Round(x+20*k),Round(y+37*k));
      lineto(Round(x+25*k),Round(y+32*k));
      floodfill(Round(x+25*k),Round(y+40*k),farba);
    end;
  if d = 1 then
    begin
      moveto(x,Round(y+65*k));
      lineto(Round(x+5*k),Round(y+60*k));
      lineto(Round(x+20*k),Round(y+60*k));
      lineto(Round(x+25*k),Round(y+65*k));
      lineto(Round(x+20*k),Round(y+70*k));
      lineto(Round(x+5*k),Round(y+70*k));
      lineto(x,Round(y+65*k));
      floodfill(Round(x+10*k),Round(y+65*k),farba);
    end;
  if f = 1 then
    begin
      moveto(x,y);
      lineto(Round(x+5*k),Round(y+5*k));
      lineto(Round(x+5*k),Round(y+27*k));
      lineto(x,Round(y+32*k));
      lineto(Round(x-5*k),Round(y+27*k));
      lineto(Round(x-5*k),Round(y+5*k));
      lineto(x,y);
      floodfill(x,Round(y+10*k),farba);
    end;
  if e = 1 then
    begin
      moveto(x,Round(y+32*k));
      lineto(Round(x+5*k),Round(y+37*k));
      lineto(Round(x+5*k),Round(y+60*k));
      lineto(x,Round(y+65*k));
      lineto(Round(x-5*k),Round(y+60*k));
      lineto(Round(x-5*k),Round(y+37*k));
      lineto(x,Round(y+32*k));
      floodfill(x,Round(y+40*k),farba);
    end;
  if g = 1 then
    begin
      moveto(x,Round(y+32*k));
      lineto(Round(x+5*k),Round(y+27*k));
      lineto(Round(x+20*k),Round(y+27*k));
      lineto(Round(x+25*k),Round(y+32*k));
      lineto(Round(x+20*k),Round(y+37*k));
      lineto(Round(x+5*k),Round(y+37*k));
      lineto(x,Round(y+32*k));
      floodfill(Round(x+10*k),Round(y+32*k),farba);
    end;
end;

procedure cislo(x,y,num,farba : integer);

var cis : integer;
    k : real;

begin
  cis := num;
  k := 0.5;
  if num > 9 then cis := num-(10*(num div 10));
  case cis of
    0 : palicky(x+25,y+10,k,1,1,1,1,1,1,0,farba);
    1 : palicky(x+25,y+10,k,0,1,1,0,0,0,0,farba);
    2 : palicky(x+25,y+10,k,1,1,0,1,1,0,1,farba);
    3 : palicky(x+25,y+10,k,1,1,1,1,0,0,1,farba);
    4 : palicky(x+25,y+10,k,0,1,1,0,0,1,1,farba);
    5 : palicky(x+25,y+10,k,1,0,1,1,0,1,1,farba);
    6 : palicky(x+25,y+10,k,1,0,1,1,1,1,1,farba);
    7 : palicky(x+25,y+10,k,1,1,1,0,0,0,0,farba);
    8 : palicky(x+25,y+10,k,1,1,1,1,1,1,1,farba);
    9 : palicky(x+25,y+10,k,1,1,1,1,0,1,1,farba);
  end;
  if num > 9 then
    begin
      cis := num div 10;
      case cis of
        1 : palicky(x+5,y+10,k,0,1,1,0,0,0,0,farba);
        2 : palicky(x+5,y+10,k,1,1,0,1,1,0,1,farba);
        3 : palicky(x+5,y+10,k,1,1,1,1,0,0,1,farba);
        4 : palicky(x+5,y+10,k,0,1,1,0,0,1,1,farba);
        5 : palicky(x+5,y+10,k,1,0,1,1,0,1,1,farba);
        6 : palicky(x+5,y+10,k,1,0,1,1,1,1,1,farba);
        7 : palicky(x+5,y+10,k,1,1,1,0,0,0,0,farba);
        8 : palicky(x+5,y+10,k,1,1,1,1,1,1,1,farba);
        9 : palicky(x+5,y+10,k,1,1,1,1,0,1,1,farba);
      end;
    end;
end;

procedure vypis_stav;
var a : byte;
begin
  for a := 1 to hraci do
    cislo(575,10+(a-1)*50,body[a],farby_hracov[a]);
end;

procedure posun(a : byte;b,c : integer);
var d : byte;
begin
  for d := 4 downto 1 do
    pixle[a,d+1] := pixle[a,d];
  pixle[a,1].x := b;
  pixle[a,1].y := c;
end;

function podmienka(a : byte) : boolean;

function je_v_poli(b,c : integer) : boolean;
var d : byte;
begin
  je_v_poli := false;
  for d := 1 to 5 do
    if (pixle[a,d].x = b) and
       (pixle[a,d].y = c) then je_v_poli := true;
end;

begin
  podmienka := false;
  if (Getpixel(Round(x[a]),round(y[a])) <> 0) and not
     je_v_poli(Round(x[a]),round(y[a])) then
       podmienka := true
         else
       podmienka := false;
end;

procedure vypis_klavesy;
var a,b : byte;
    s : string;

const klavesy : array[1..max_pocet_hracov,1..3] of string =
        (('Del','End','Pg Down'),
         ('1','2','3'),
         ('m',',','.'),
         ('s','d','f'),
         ('5','Up Arr','/'),
         ('`','Tab','Caps Lo'),
         ('Shift','z','x'),
         ('p','[',']'));

begin
  setfillstyle(1,0);
  Bar(0,0,640,150);
  setcolor(white);
  for a := 1 to hraci do
    begin
      Str(a,s);
      s := 'Hrac '+s;
      Outtextxy((640 div (hraci + 1) * a) - (length(s) * 7 ) div 2,20,s);

      for b := 1 to 3 do
        Outtextxy((640 div (hraci + 1) * a) -
                  (length(klavesy[a,b]) * 7 ) div 2,
                  20 + 20 * b, klavesy[a,b]);
    end;
  for a := 1 to hraci do
    begin
      setcolor(farby_hracov[a]);
      Rectangle((640 div (hraci + 1) * a) - 28, 15
               ,(640 div (hraci + 1) * a) + 32, 95);
    end;
end;

procedure zaciatok;

const active : byte = 1;
      koniec : boolean = false;
      n = 3;
      menu : array[1..n] of string =
        ('Start','Setup','Exit');
      sirka = 100;

var key : char;
    a : byte;

procedure ukaz_aktivneho(a,b,c : integer);
begin
  if c = active then setcolor(yellow)
                else setcolor(lightred);
  rectangle(a,b,a+sirka,b+20);
end;

procedure jedno_menu(a,b,c : integer;s : string);
begin

  setfillstyle(1,red);
  bar(a,b,a+sirka,b+20);

  ukaz_aktivneho(a,b,c);

  setcolor(white);
  Outtextxy( a+ (sirka div 2) - round((length(s)*7) / 2),b+7,s);
end;

procedure vypis_menu(a,b : integer);
var c : byte;
begin
  for c := 1 to n do
    jedno_menu(a,b+(c-1)*40,c,menu[c]);
end;

procedure vypis_active(a,b : integer);
var c : byte;
begin
  for c := 1 to n do
    ukaz_aktivneho(a,b+(c-1)*40,c);
end;


procedure setup;

const m = 2;
      setup_active : integer = 1;
      setup_sirka : byte = 150;
      setup_menu : array[1..m] of string =
        ('Pocet hracov','Spat');
      koniec_setup : boolean = false;

procedure ukaz_setup_aktivneho(a,b,c : integer);
begin
  if c = setup_active then setcolor(yellow)
                      else setcolor(lightred);
  rectangle(a,b,a+setup_sirka,b+20);
end;


procedure jedno_setup_menu(a,b,c : integer;s : string);
begin

  setfillstyle(1,red);
  bar(a,b,a+setup_sirka,b+20);

  ukaz_setup_aktivneho(a,b,c);

  setcolor(white);
  Outtextxy( a+ (setup_sirka div 2) - round((length(s)*7) / 2),b+7,s);
end;

procedure vypis_setup_menu(a,b : integer);
var c : byte;
begin
  for c := 1 to m do
    jedno_setup_menu(a,b+(c-1)*40,c,setup_menu[c]);
end;

procedure vypis_setup_active(a,b : integer);
var c : byte;
begin
  for c := 1 to m do
    ukaz_setup_aktivneho(a,b+(c-1)*40,c);
end;

procedure ukaz_sipky;
begin
  setcolor(green);
  moveto((640 div 2) - (setup_sirka div 2) + 5,
         (480 div 2) - Round(40 * (m / 2)) + 10);

  lineto((640 div 2) - (setup_sirka div 2) + 13,
         (480 div 2) - Round(40 * (m / 2)) + 5);

  lineto((640 div 2) - (setup_sirka div 2) + 13,
         (480 div 2) - Round(40 * (m / 2)) + 15);

  lineto((640 div 2) - (setup_sirka div 2) + 5,
         (480 div 2) - Round(40 * (m / 2)) + 10);

  setfillstyle(1,green);

  floodfill((640 div 2) - (setup_sirka div 2) + 7,
            (480 div 2) - Round(40 * (m / 2)) + 10, green);

  setcolor(green);
  moveto((640 div 2) + (setup_sirka div 2) - 5,
         (480 div 2) - Round(40 * (m / 2)) + 10);

  lineto((640 div 2) + (setup_sirka div 2) - 13,
         (480 div 2) - Round(40 * (m / 2)) + 5);

  lineto((640 div 2) + (setup_sirka div 2) - 13,
         (480 div 2) - Round(40 * (m / 2)) + 15);

  lineto((640 div 2) + (setup_sirka div 2) - 5,
         (480 div 2) - Round(40 * (m / 2)) + 10);

  setfillstyle(1,green);

  floodfill((640 div 2) + (setup_sirka div 2) - 7,
            (480 div 2) - Round(40 * (m / 2)) + 10, green);
end;

procedure vypis_pocet_hracov(a,b : integer);
var s : string;
begin
  setfillstyle(1,0);
  Bar(a,b,a+20,b+10);
  setcolor(white);
  str(hraci,s);
  outtextxy(a,b,s);
end;

procedure uber;
begin
  if hraci > 2 then hraci := hraci - 1
               else exit;
  vypis_pocet_hracov((640 div 2) - 5,
                     (480 div 2) - Round(40 * (m / 2)) + 25);

  vypis_klavesy;
end;

procedure pridaj;
begin
  if hraci < max_pocet_hracov then hraci := hraci + 1
                              else exit;
  vypis_pocet_hracov((640 div 2) - 5,
                     (480 div 2) - Round(40 * (m / 2)) + 25);
  vypis_klavesy;
end;

begin
  cleardevice;
  vypis_setup_menu((640 div 2) - (setup_sirka div 2),
                   (480 div 2) - Round(40 * (m / 2)));
  Setcolor(white);
  Outtextxy(180,460,'R a d o   B u r a n s k y   1 9 9 8');

  ukaz_sipky;

  vypis_pocet_hracov((640 div 2) - 5,
                     (480 div 2) - Round(40 * (m / 2)) + 25);

  vypis_klavesy;

  repeat
    key := readkey;

    case key of
      #27 : koniec_setup := true;
      #75 : if setup_active = 1 then uber;
      #77 : if setup_active = 1 then pridaj;
      #80 : if setup_active < m then setup_active := setup_active + 1;
      #72 : if setup_active > 1 then setup_active := setup_active - 1;
      #13 : case setup_active of
              m : koniec_setup := true;
            end;
    end;

    vypis_setup_active((640 div 2) - (setup_sirka div 2),
                       (480 div 2) - Round(40 * (m / 2)));;

  until koniec_setup;
  koniec_setup := false;
  cleardevice;
end;

begin
  vypis_menu((640 div 2) - (sirka div 2), (480 div 2) - Round(40 * (n / 2)));
  Setcolor(white);
  Outtextxy(180,460,'R a d o   B u r a n s k y   1 9 9 8');

  vypis_klavesy;

  repeat
    key := readkey;
    case key of
      #27 : begin
              closegraph;
              clrscr;
              writeln('Have a nice day.');
              halt;
            end;
      #80 : if active < n then active := active + 1;
      #72 : if active > 1 then active := active - 1;
      #13 : case active of
              1 : koniec := true;
              2 : begin
                    setup;
                    vypis_menu((640 div 2) - (sirka div 2), (480 div 2) - Round(40 * (n / 2)));
                    Setcolor(white);
                    Outtextxy(180,460,'R a d o   B u r a n s k y   1 9 9 8');
                    vypis_klavesy;
                  end;
              n : begin
                    closegraph;
                    clrscr;
                    writeln('Have a nice day.');
                    halt;
                  end;
            end;
    end;
    vypis_active((640 div 2) - (sirka div 2), (480 div 2) - Round(40 * (n / 2)));;
  until koniec;
  for a := 1 to hraci do
    begin
      sp[a] := 0.004;
      smer[a] := 90+(a-1)*180;
      activ[a] := false;
    end;
end;

procedure nakresli(c,d : byte);
var uhol : real;
    e : byte;
begin

  uhol := 180 - smer_st[c];

  if not leti[c] then
    begin
      setcolor(black);
      for e := 1 to poc_ciar do
        line(zbran[c,e].sx1,zbran[c,e].sy1,zbran[c,e].sx2,zbran[c,e].sy2);
      exit;
    end;

  if d = poc_ciar then
    begin
      setcolor(black);
      line(zbran[c,d].sx1,zbran[c,d].sy1,zbran[c,d].sx2,zbran[c,d].sy2);
    end;

  setcolor(farby_hracov[c]);

  zbran[c,d].x1 := Round(zbran[c,d].x + cos(pi/180*uhol)*5);
  zbran[c,d].y1 := Round(zbran[c,d].y + sin(pi/180*uhol)*5);
  zbran[c,d].x2 := Round(zbran[c,d].x - cos(pi/180*uhol)*5);
  zbran[c,d].y2 := Round(zbran[c,d].y - sin(pi/180*uhol)*5);

  line(zbran[c,d].x1,zbran[c,d].y1,zbran[c,d].x2,zbran[c,d].y2);

  zbran[c,d].sx1 := zbran[c,d].x1;
  zbran[c,d].sy1 := zbran[c,d].y1;
  zbran[c,d].sx2 := zbran[c,d].x2;
  zbran[c,d].sy2 := zbran[c,d].y2;
end;


begin
  clrscr;

  init16;

  hraci := 2;

  keybexit;

  zaciatok;

  InitKeyboardHandler; (* Automatically enable it *)

  1 :

  for a := 1 to hraci do
    begin
      activ[a] := true;
      smer[a] := 90+(a-1)*(360 div hraci);
      x[a] := Round(275 - sin(pi/180*smer[a]) * 200);
      y[a] := Round(240 - cos(pi/180*smer[a]) * 200);

      funkcia[a] := 1;
      leti[a] := false;
    end;

  zac_sp := 0.004;

  zivi := hraci;

  cleardevice;

  setcolor(lightred);
  rectangle(4,4,546,475);

  vypis_stav;

  Setcolor(white);
  Outtextxy(575,440,'Rado');
  Outtextxy(562,460,'BURANSKY');

  repeat
    for a := 1 to max_pocet_hracov do
      begin
        dop[a] := false;
        dop[a] := false;
      end;
    uhol := 0.04;
    repeat
      for a := 1 to hraci do
        begin
          if scancode = kod_kl[a,1,1] then dol[a] := true;
          if scancode = kod_kl[a,2,1] then dol[a] := false;

          if scancode = kod_kl[a,1,3] then dop[a] := true;
          if scancode = kod_kl[a,2,3] then dop[a] := false;

          if scancode = kod_kl[a,1,2] then
            case funkcia[a] of
              1 : if not leti[a] then
                    begin
                      leti[a] := true;
                      for b := 1 to poc_ciar do
                        begin
                          zbran[a,b].x := x[a] + sin(pi/180*(180-smer[a])) * (8-b);
                          zbran[a,b].y := y[a] - cos(pi/180*(180-smer[a])) * (8-b);

                          zbran[a,b].sx := round(zbran[a,b].x);
                          zbran[a,b].sy := round(zbran[a,b].y);
                        end;

                       smer_st[a] := smer[a];

                       zac_sp := zac_sp * 2.5;

                       sp[a] := zac_sp + ((zivi - 2) * 0.0008);

                       sp_st := sp[a] * 2;

                    end;
            end;
        end;

      for a := 1 to hraci do
      if activ[a] then
        begin
           if leti[a] then
             begin
               if (zbran[a,1].x < 10) or
                  (zbran[a,1].y < 10) or
                  (zbran[a,1].x > 536) or
                  (zbran[a,1].y > 465) then
                    begin
                      leti[a] := false;
                      nakresli(a,b);
                      zac_sp := zac_sp / 2.5;
                    end;

               for b := 1 to poc_ciar do
                 begin
                   zbran[a,b].x := zbran[a,b].x + sin(pi/180*(180-smer_st[a])) * sp_st;
                   zbran[a,b].y := zbran[a,b].y - cos(pi/180*(180-smer_st[a])) * sp_st;

                   if (round(zbran[a,b].x) <> zbran[a,b].sx) or
                      (round(zbran[a,b].y) <> zbran[a,b].sy) then
                         nakresli(a,b);
                 end;
        end;

          sp[a] := zac_sp + ((zivi - 2) * 0.0008);
          uhol := sp[a] / 0.24;

          if dol[a] then smer[a] := smer[a] + uhol;
          if dop[a] then smer[a] := smer[a] - uhol;
          if smer[a] < 0 then smer[a] := smer[a] + 360;
          if smer[a] > 360 then smer[a] := smer[a] - 360;
          xx[a] := Round(x[a]);
          yy[a] := Round(y[a]);
          x[a] := x[a] + (sin(pi/180*smer[a])*sp[a]);
          y[a] := y[a] + (cos(pi/180*smer[a])*sp[a]);

          skonci := true;

          for b := 1 to hraci do
            if activ[b] and (b <> a) then skonci := false;

          if skonci then
            begin
              body[a] := body[a] + (hraci - 1);
              goto 1;
            end;

          if (round(x[a]) <> xx[a]) or
             (round(y[a]) <> yy[a]) then

          if (Getpixel(Round(x[a]),round(y[a])) <> 0) and
              podmienka(a) then
                begin
                  activ[a] := false;
                  body[a] := body[a] + (hraci - zivi);
                  zivi := zivi - 1;
                end;

          Putpixel(Round(x[a]),round(y[a]),farby_hracov[a]);

          if (round(x[a]) <> xx[a]) or
             (round(y[a]) <> yy[a]) then
               posun(a,Round(x[a]),round(y[a]));
       end;

    until scancode = $01;
  until scancode = $01;
  keybexit;
  closegraph;
  clrscr;
end.