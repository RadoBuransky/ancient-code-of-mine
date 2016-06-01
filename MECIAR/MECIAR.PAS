uses crt,graph,dos;

label konec;

const rychlost = 20;
      max_bonus = 5; {maximalny pocet diamantov}
      max_polomer : byte = 35;
      max_poc_ziv = 3;

      zvuky : boolean = true;

      hodnoty : array[1..10] of record h : word; f : byte end =
        ((h :  1000;f : black),
         (h :  2000;f : darkgray),
         (h :  4000;f : lightgray),
         (h :  6000;f : blue),
         (h :  7000;f : green),
         (h :  8000;f : lightblue),
         (h :  9000;f : lightgreen),
         (h : 10000;f : red),
         (h : 30000;f : yellow),
         (h : 60000;f : white));

const poc_poloziek = 4;
      polozka : array[1..poc_poloziek] of string =
       ('Nova hra','Zvuky su zapnute','Sien slavy','Koniec');

type diamant = record
                 x,y : byte;
                 hodnota : word;
                 farba : byte;
               end;

type level_o = object
                 pole : array[1..30,1..30] of byte;
                 surx : array[1..30] of integer;
                 sury : array[1..30] of integer;
                 polomer : array[1..rychlost] of byte;
                 v_zamku : byte;
                 bonus : record
                           poc : byte;
                           cislo : array[1..max_bonus] of diamant;
                         end;
                 koniec : boolean;
                 hod,min,ss,sek,sek2 : word;
                 page : byte;

                 procedure hraj(sirka,vyska,zivoty,kluce : byte;bod : longint;level : byte);
               end;
     menu_o = object
              active : byte;
              page : byte;
              koniec : boolean;
              sur : array[1..poc_poloziek] of record
                                                x,y : integer;
                                              end;
              procedure urob;

              procedure citaj_klaves;
              procedure vypocitaj_suradnice;
              procedure ukaz_menu;
            end;
     init_o = object
                procedure urob;

                procedure dekoduj_levely;
                procedure nacitaj_levely;
                procedure dekoduj_hall;
                procedure nacitaj_hall;
              end;
     hrac = record
              meno : string;
              body : longint;
            end;

var dvere : record
              kde : byte;
              otvorene : boolean;
            end;
    panak : record
              x,y : byte;
              ma_kluc : boolean;
            end;
    zaba : record
             x,y : byte;
           end;
    user_break,skoncil_uspesne : boolean;
    dovod,ktory,zivoty_i : byte;
    body : longint;

    pocet_levelov : byte;

    levely : array[1..100] of record
                                sirka,vyska,kluce : byte;
                              end;

    pocet_hracov : byte;

    hall : array[1..20] of hrac;

    level : level_o;
    menu : menu_o;
    init : init_o;

{$I pcx.pas}

procedure init_graph;
var gd,gm : integer;
begin
  gd := 9;
  gm := 1;
  initgraph(gd,gm,'');
end;

procedure smrt;
var a : integer;
begin
  setcolor(black);
  for a := 0 to getmaxy do
    begin
      line(0,a,getmaxx,a);
      if zvuky then sound(2000-((2000 div getmaxy)*a));
      delay(5);
      if zvuky then nosound;
      if a = 30 then
        begin
          setcolor(lightred);
          outtextxy(getmaxx div 2-150,20,'T v o j   z i v o t   s a   s k o n c i l');
          setcolor(black);
        end;
    end;
  setactivepage(0);
  cleardevice;
  setactivepage(1);
  cleardevice;
end;

procedure ukonci;
var a,miesto : byte;
    meno : string[10];

procedure zisti_meno;
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
  Outtextxy(285,107,'Napis svoje meno');
end;
procedure ukaz_meno;
begin
  SetFillStyle(1,0);
  Bar(240,140,400,160);
  SetColor(white);
  Outtextxy(245,148,meno);
  line(245+(length(meno)*8),158,253+(length(meno)*8),158);
end;

procedure pridaj;
begin
  meno := Concat(meno,char(c));
end;

procedure zmaz;
begin
  Delete(meno,length(meno),1);
end;


begin
  meno := '';
  setactivepage(0);
  cleardevice;
  setvisualpage(0);
  zaklad;
  repeat
    ukaz_meno;
    c := readkey;
    if c = #8 then zmaz;
    if ((Char(c) in ['a'..'z']) or
       (Char(c) in ['A'..'Z'])) and
       (c <> #13) and
       (c <> #27) and
       (c <> #8) and
       (length(meno) < 11) then pridaj;
  until c = #13;
end;

procedure zapis_do_suboru;
var a : byte;
    f : text;
begin
  assign(f,'out.gam');
  rewrite(f);
  writeln(f,pocet_hracov);
  for a := 1 to pocet_hracov do
    begin
      writeln(f,hall[a].meno);
      writeln(f,hall[a].body);
    end;
  close(f);
end;

procedure zakoduj_subor;
var f,f1 : file of byte;
    b,c : byte;
begin
  assign(f,'out.gam');
  reset(f);
  assign(f1,'hall.gam');
  rewrite(f1);
  while not EoF(f) do
    begin
      Read(f,c);
      b := c xor 250;
      Write(f1,b);
    end;
  erase(f);
  close(f1);
end;

begin
  if pocet_hracov > 0 then
    begin
      if pocet_hracov = 20 then menu.urob;
      zisti_meno;
      miesto := 0;
      repeat inc(miesto); until (hall[miesto].body < body) or (miesto > pocet_hracov);
      for a := pocet_hracov downto miesto do
        if a < 20 then hall[a+1] := hall[a];
      hall[miesto].meno := meno;
      hall[miesto].body := body;
      inc(pocet_hracov);
    end
      else
    begin
      zisti_meno;
      pocet_hracov := 1;
      hall[1].meno := meno;
      hall[1].body := body;
    end;
  zapis_do_suboru;
  zakoduj_subor;
end;

{ . . . . . . . . . . . M E N U . . . . . . . . . . . . . . .}

procedure menu_o.vypocitaj_suradnice;
var a : byte;
    dlzka : word;
begin
  dlzka := 0;
  for a := 1 to poc_poloziek do
    if length(polozka[a]) > dlzka then dlzka := length(polozka[a]);
  for a := 1 to poc_poloziek do
    begin
      sur[a].x := getmaxx div 2 - dlzka * 6;
      sur[a].y := getmaxy div 2 - 10 - (poc_poloziek * 25) + (a * 25);
    end;
end;

procedure menu_o.ukaz_menu;
var a : byte;
begin
  setactivepage(1-page);
  cleardevice;
  setfillstyle(1,darkgray);
  bar(sur[1].x-2,sur[1].y-2,
      getmaxx-sur[1].x+2,sur[poc_poloziek].y+27);
  setfillstyle(1,lightgray);
  bar(sur[active].x,sur[active].y,
      getmaxx-sur[active].x,sur[active].y+25);
  for a := 1 to poc_poloziek do
    begin
      if a = active then setcolor(black)
                    else setcolor(white);
      outtextxy(round((getmaxx / 2) - ((length(polozka[a]) / 2) * 8)),sur[a].y + 8,polozka[a]);
    end;
  page := 1 - page;
  setvisualpage(page);
end;

procedure hall_of_fame;
var a : byte;
    s : string;
begin
  setfillstyle(1,darkgray);
  bar(0,0,getmaxx,getmaxy);
  setcolor(yellow);
  outtextxy(20,20,'S I E N   S L A V Y');
  for a := 1 to pocet_hracov do
    begin
      str(hall[a].body,s);
      outtextxy(20,20+a*12,hall[a].meno);
      outtextxy(120,20+a*12,s);
    end;
  setcolor(white);
  outtextxy(20,getmaxy-10,'Stlac lubovolny klaves ...');
  readkey;
  cleardevice;
  menu.ukaz_menu;
end;

procedure menu_o.citaj_klaves;
var key : char;
begin
  key := readkey;
  case key of
    #72 : if active > 1 then
            begin
              dec(active);
              ukaz_menu;
            end;
    #80 : if active < poc_poloziek then
            begin
              inc(active);
              ukaz_menu;
            end;
    #27 : begin
            closegraph;
            clrscr;
            writeln('Have a nice day.');
            halt;
          end;
    #13 : case active of
            1 : koniec := true;
            2 : case zvuky of
                  true : begin
                           zvuky := false;
                           polozka[2] := 'Zvuky su vypnute';
                           ukaz_menu;
                         end;
                  false : begin
                            zvuky := true;
                            polozka[2] := 'Zvuky su zapnute';
                            ukaz_menu;
                          end;
                end;
            3 : hall_of_fame;
            poc_poloziek : begin
                             closegraph;
                             clrscr;
                             writeln('Have a nice day.');
                             halt;
                           end;
          end;
  end;
end;

procedure menu_o.urob;
begin
  active := 1;
  vypocitaj_suradnice;
  page := 1;
  cleardevice;
  ukaz_menu;
  koniec := false;
  repeat citaj_klaves; until koniec;
end;

{ . . . . . . . . . . . M E N U . . . . . . . . . . . . . END}


{ . . . . . . . . . . . L E V E L . . . . . . . . . . . . . . .}

procedure level_o.hraj(sirka,vyska,zivoty,kluce : byte;bod : longint;level : byte);

procedure ukaz_kluc(x,y : integer;farba : byte);
begin
  setcolor(farba);
  setfillstyle(1,farba);
  fillellipse(x,y-5,7,7);
  bar(x-2,y+1,x+2,y+18);

  bar(x+2,y+6,x+7,y+8);
  bar(x+2,y+10,x+4,y+12);
  bar(x+2,y+14,x+7,y+16);
  setfillstyle(1,lightgreen);
  fillellipse(x,y-5,4,4);
end;

procedure ukaz_danger;
begin
  setfillstyle(1,yellow);
  bar(10,30,((getmaxx-20) div rychlost) * pole[panak.x,panak.y],40);
  setfillstyle(1,darkgray);
  bar(1+(getmaxx-20) div rychlost * pole[panak.x,panak.y],30,getmaxx-10,40);
end;

procedure ukaz_stav;
var s : string;
begin
  setactivepage(page);
  SetFillStyle(1,darkgray);
  bar(0,0,getmaxx,50);
  ukaz_danger;
  setcolor(white);

  str(level,s);
  s := concat('Level : ',s);
  outtextxy(20,10,s);

  str(zivoty,s);
  s := concat('Pocet zivotov : ',s);
  outtextxy(200,10,s);

  str(body,s);
  s := concat('Pocet bodov : ',s);
  outtextxy(420,10,s);

  setactivepage(1-page);
  SetFillStyle(1,darkgray);
  bar(0,0,getmaxx,50);
  str(level,s);
  s := concat('Level : ',s);
  outtextxy(20,10,s);

  str(zivoty,s);
  s := concat('Pocet zivotov : ',s);
  outtextxy(200,10,s);

  str(body,s);
  s := concat('Pocet bodov : ',s);
  outtextxy(420,10,s);

  setactivepage(page);
end;

procedure init_vlastnosti;
var a,b : byte;
begin
  skoncil_uspesne := false;
  user_break := false;
  koniec := false;
  dvere.otvorene := false;
  page := 1;
  setactivepage(page);
  setvisualpage(1-page);

  panak.ma_kluc := true;
  v_zamku := 0;

  zaba.x := 1;
  zaba.y := vyska;

  panak.x := sirka;
  panak.y := 1;
  randomize;

  for a := 1 to sirka do
    for b := 1 to vyska do
      pole[a,b] := random(rychlost);

  pole[1,vyska] := rychlost;
  pole[sirka,1] := rychlost;

  for a := 1 to sirka do
    surx[a] := (getmaxx div (sirka+1))*a;

  for a := 1 to vyska do
    sury[a] := (((getmaxy-50) div (vyska+1))*a)+50;

  if (surx[2]-surx[1]) < (sury[2]-sury[1]) then
    max_polomer := ((surx[2]-surx[1]) div 2)
      else
    max_polomer := ((sury[2]-sury[1]) div 2);

  for a := 1 to rychlost do
    polomer[a] := (max_polomer div rychlost) * a;

  bonus.poc := Random(max_bonus);
  for a := 1 to bonus.poc do
    begin
      repeat
        bonus.cislo[a].x := 1+random(sirka-1);
        bonus.cislo[a].y := 1+random(vyska-1);
      until pole[bonus.cislo[a].x,bonus.cislo[a].y] > 0;

      b := random(9)+1;
      bonus.cislo[a].farba := hodnoty[b].f;
      bonus.cislo[a].hodnota := hodnoty[b].h;
    end;
end;

procedure ukaz_zabu(x,y : byte);
begin
  setcolor(black);
  setfillstyle(1,green);
  fillellipse(surx[x],sury[y]-4,7,5);
  fillellipse(surx[x]-4,sury[y]+1,4,2);
  fillellipse(surx[x]+4,sury[y]+1,4,2);
  setfillstyle(1,white);
  fillellipse(surx[x]-3,sury[y]-9,4,4);
  setfillstyle(1,black);
  fillellipse(surx[x]-3,sury[y]-9,2,2);
  setfillstyle(1,white);
  fillellipse(surx[x]+3,sury[y]-9,4,4);
  setfillstyle(1,black);
  fillellipse(surx[x]+3,sury[y]-9,2,2);
end;

procedure ukaz_panaka(x,y : byte);
const kridlo_l : array[1..5] of PointType =
      ((X:  -1; Y: -8),
       (X:  -8; Y: -3),
       (X: -12; Y: 10),
       (X: -9; Y: 13),
       (X: -3; Y: 8));
var a : byte;
    kridlo :  array[1..5] of PointType;
begin
  setcolor(lightgray);
  setfillstyle(1,lightgray);
  fillellipse(surx[x],sury[y]-9,5,3);

  setfillstyle(1,lightgray);
  setcolor(lightgray);
  fillellipse(surx[x],sury[y],5,7);

  for a := 1 to 5 do
    begin
      kridlo[a].x := kridlo_l[a].x+surx[x];
      kridlo[a].y := kridlo_l[a].y+sury[y];
    end;
  setfillstyle(1,white);
  setcolor(lightgray);

  FillPoly(5,kridlo);

  for a := 1 to 5 do
    begin
      kridlo[a].x := surx[x]-kridlo_l[a].x;
      kridlo[a].y := kridlo_l[a].y+sury[y];
    end;
  FillPoly(5,kridlo);

  setcolor(darkgray);
  moveto(surx[x]-5,sury[y]-5);
  lineto(surx[x]-9,sury[y]-7);
  lineto(surx[x]-9,sury[y]-10);

  moveto(surx[x]-8,sury[y]-2);
  lineto(surx[x]-11,sury[y]-3);
  lineto(surx[x]-12,sury[y]-7);

  moveto(surx[x]-10,sury[y]);
  lineto(surx[x]-12,sury[y]);

  moveto(surx[x]-11,sury[y]+3);
  lineto(surx[x]-12,sury[y]+5);

  moveto(surx[x]+5,sury[y]-5);
  lineto(surx[x]+9,sury[y]-7);
  lineto(surx[x]+9,sury[y]-10);

  moveto(surx[x]+8,sury[y]-2);
  lineto(surx[x]+11,sury[y]-3);
  lineto(surx[x]+12,sury[y]-7);

  moveto(surx[x]+10,sury[y]);
  lineto(surx[x]+12,sury[y]);

  moveto(surx[x]+11,sury[y]+3);
  lineto(surx[x]+12,sury[y]+5);
end;

procedure ukaz_kluce;
var a,jeden : byte;
begin
  jeden := max_polomer div kluce;
  for a := 1 to kluce do
    if a <= v_zamku then ukaz_kluc(surx[1]-(kluce div 2 * jeden)+(a-1)*jeden,sury[vyska],lightred)
                    else ukaz_kluc(surx[1]-(kluce div 2 * jeden)+(a-1)*jeden,sury[vyska],black);
  if not panak.ma_kluc and
     (v_zamku < kluce) then ukaz_kluc(surx[sirka],sury[1],lightred);
end;

procedure ukaz_pole;
var a,b : byte;
begin
  setactivepage(1-page);
  setfillstyle(1,blue);
  bar(0,50,getmaxx,getmaxy);
  setfillstyle(1,lightgreen);
  setcolor(green);

  for a := 1 to sirka do
    for b := 1 to vyska do
      if pole[a,b] > 0 then
        FillEllipse(surx[a],sury[b],Round(1.4*polomer[pole[a,b]]),polomer[pole[a,b]]);

  for a := 1 to max_bonus do
    if bonus.cislo[a].x <> 0 then
      begin
        setfillstyle(1,bonus.cislo[a].farba);
        setcolor(bonus.cislo[a].farba);
        fillellipse(surx[bonus.cislo[a].x],sury[bonus.cislo[a].y],3,3);
      end;

  if dvere.otvorene then
    begin
      setcolor(black);
      setfillstyle(1,brown);
      with dvere do
        begin
          if (kde in [1..sirka]) then
            bar(surx[sirka+1-kde]-max_polomer div 2,sury[1]-30,
                surx[sirka+1-kde]+max_polomer div 2,sury[1]-25);

          if (kde in [sirka+1..sirka+vyska]) then
            bar(surx[1]-30,sury[kde-sirka]-max_polomer div 2,
                surx[1]-25,sury[kde-sirka]+max_polomer div 2);

          if (kde in [sirka+vyska+1..2*sirka+vyska]) then
            bar(surx[kde-(sirka+vyska)]-max_polomer div 2,sury[vyska]+30,
                surx[kde-(sirka+vyska)]+max_polomer div 2,sury[vyska]+25);

          if (kde in [2*sirka+vyska+1..2*sirka+2*vyska]) then
            bar(surx[sirka]+30,sury[1+(2*sirka+2*vyska)-kde]-max_polomer div 2,
                surx[sirka]+25,sury[1+(2*sirka+2*vyska)-kde]+max_polomer div 2);
        end;
    end;

  ukaz_kluce;
  ukaz_panaka(panak.x,panak.y);
  ukaz_zabu(zaba.x,zaba.y);
  ukaz_danger;
  setvisualpage(1-page);
  page := 1-page;
end;

procedure zmensi_a_pridaj;
var a,b,c : byte;
begin
  for a := 1 to sirka do
    for b := 1 to vyska do
      if ((a = 1) and (b = vyska)) or
         ((a = sirka) and (b = 1)) then continue
                                   else
        begin
          if pole[a,b] > 0 then
            begin
              dec(pole[a,b]);
              if pole[a,b] = 0 then
                for c := 1 to max_bonus do
                  if (bonus.cislo[c].x = a) and
                     (bonus.cislo[c].y = b) then
                       begin
                         bonus.cislo[c].x := 0;
                         bonus.cislo[c].y := 0;
                         dec(bonus.poc);
                       end;
            end
              else
            if random(2) = 0 then pole[a,b] := 1+random(rychlost);
        end;
  if bonus.poc < max_bonus then
    if random(3) = 1 then
      begin
        a := 0;
        repeat inc(a) until bonus.cislo[a].x = 0;

        repeat
          bonus.cislo[a].x := 1+random(sirka);
          bonus.cislo[a].y := 1+random(vyska);
        until pole[bonus.cislo[a].x,bonus.cislo[a].y] > 0;

        b := 1+random(10);
        bonus.cislo[a].farba := hodnoty[b].f;
        bonus.cislo[a].hodnota := hodnoty[b].h;

        inc(bonus.poc);
      end;
end;

procedure start_clock;
begin
  GetTime(hod,min,sek2,ss);
  while sek2 = sek do
    GetTime(hod,min,sek,ss);
end;

procedure citaj_klaves;
var key : char;
    a : byte;
begin
  key := readkey;
  case key of
    #27 : begin
            koniec := true;
            dovod := 1;
            user_break := true;
            skoncil_uspesne := false;
          end;
    #80 : begin
            if dvere.otvorene then
              if (dvere.kde-(sirka+vyska) = panak.x) and
                 (panak.y = vyska) then
                   begin
                     skoncil_uspesne := true;
                     koniec := true;
                     ukaz_pole;
                     exit;
                   end;
            if panak.y < vyska then
              if pole[panak.x,panak.y+1] > 0 then inc(panak.y);
          end;
    #72 : begin
            if (sirka+1-dvere.kde = panak.x) and
               (panak.y = 1) and
               (dvere.otvorene) then
                 begin
                   skoncil_uspesne := true;
                   koniec := true;
                   ukaz_pole;
                   exit;
                 end;
            if panak.y > 1 then
              if pole[panak.x,panak.y-1] > 0 then dec(panak.y)
          end;
    #75 : begin
            if dvere.otvorene then
              if (dvere.kde-sirka = panak.y) and
                 (panak.x = 1) then
                   begin
                     skoncil_uspesne := true;
                     koniec := true;
                     ukaz_pole;
                     exit;
                   end;
            if panak.x > 1 then
              if pole[panak.x-1,panak.y] > 0 then dec(panak.x)
          end;
    #77 : begin
            if dvere.otvorene then
              if ((2*sirka+2*vyska)-dvere.kde+1 = panak.y) and
                 (panak.x = sirka) then
                   begin
                     skoncil_uspesne := true;
                     koniec := true;
                     ukaz_pole;
                     exit;
                   end;
            if panak.x < sirka then
              if pole[panak.x+1,panak.y] > 0 then inc(panak.x)
          end;
  end;
  if (key = #80) or (key = #72) or (key = #75) or (key = #77) then
    begin
      if (zaba.x = panak.x) and
         (zaba.y = panak.y) then
           begin
             skoncil_uspesne := false;
             koniec := true;
             dovod := 2;
           end;
      ukaz_pole;
      for a := 1 to max_bonus do
        if (bonus.cislo[a].x = panak.x) and
           (bonus.cislo[a].y = panak.y) then
             begin
               bonus.cislo[a].x := 0;
               dec(bonus.poc);
               inc(body,bonus.cislo[a].hodnota);
               ukaz_stav;
             end;
      if (panak.x = sirka) and
         (panak.y = 1) and not
         panak.ma_kluc and
         (v_zamku < kluce) then
           begin
             panak.ma_kluc := true;
             ukaz_pole;
           end;
      if (panak.x = 1) and
         (panak.y = vyska) and
         (panak.ma_kluc) then
           begin
             inc(v_zamku);
             if v_zamku = kluce then
               begin
                 dvere.otvorene := true;
                 dvere.kde := 1+random((2*sirka+2*vyska)-1);
               end;
             ukaz_pole;
             panak.ma_kluc := false;
             ukaz_pole;
           end;
    end;
end;

procedure kontrola;
var a : byte;
begin
  koniec := false;
  if pole[panak.x,panak.y] = 0 then
    begin
      koniec := true;
      dovod := 3;
      skoncil_uspesne := false;
    end;
  if (zaba.x = panak.x) and (zaba.y = panak.y) then
       begin
         skoncil_uspesne := false;
         koniec := true;
         dovod := 4;
       end;
  if pole[zaba.x,zaba.y] = 0 then
    begin
      zaba.x := 1;
      zaba.y := vyska;
    end;

end;

procedure mysli;
var vzdialenost : byte;
begin
  vzdialenost := (abs(panak.x-zaba.x)+abs(panak.y-zaba.y));
  if vzdialenost = 1 then
    begin
      zaba.x := panak.x;
      zaba.y := panak.y;
      ukaz_pole;
      exit;
    end;
  if panak.x-zaba.x > 0 then {ak je panak napravo od zaby}
      if zaba.x < sirka then {ak nie je ani na jednom kraji}
           if pole[zaba.x+1,zaba.y] > 1 then
             begin
               inc(zaba.x);
               ukaz_pole;
               exit;
             end;

  if panak.x-zaba.x < 0 then {ak je panak nalavo od zaby}
      if zaba.x > 1 then {ak nie je ani na jednom kraji}
           if pole[zaba.x-1,zaba.y] > 1 then
             begin
               dec(zaba.x);
               ukaz_pole;
               exit;
             end;

  if panak.y-zaba.y > 0 then {ak je panak dole od zaby}
      if zaba.y < vyska then {ak nie je ani na jednom kraji}
           if pole[zaba.x,zaba.y+1] > 1 then
             begin
               inc(zaba.y);
               ukaz_pole;
               exit;
             end;

  if panak.y-zaba.y < 0 then {ak je panak hore od zaby}
      if zaba.y > 1 then {ak nie je ani na jednom kraji}
           if pole[zaba.x,zaba.y-1] > 1 then
             begin
               dec(zaba.y);
               ukaz_pole;
               exit;
             end;
end;

begin
  init_vlastnosti;
  start_clock;
  ukaz_stav;
  repeat
    ukaz_pole;
    repeat
      if keypressed then citaj_klaves;
      GetTime(hod,min,sek,ss);
    until (sek <> sek2) or koniec or user_break;
    if koniec or user_break then exit;
    mysli;
    zmensi_a_pridaj;
    sek2 := sek;
    if zvuky then sound(200);
    delay(50);
    if zvuky then nosound;
    kontrola;
  until koniec;
end;

{ . . . . . . . . . . . L E V E L . . . . . . . . . . . . . . .END}

{ . . . . . . . . . . . I N I T . . . . . . . . . . . . . . . . }

procedure init_o.dekoduj_levely;
var f,f1 : file of byte;
    b,c : byte;
begin
  assign(f,'levely.gam');
  reset(f);
  assign(f1,'vystup.gam');
  rewrite(f1);
  while not EoF(f) do
    begin
      Read(f,c);
      b := c xor 250;
      Write(f1,b);
    end;
  close(f);
  close(f1);
end;

procedure init_o.nacitaj_levely;
var f : text;
    a : byte;
begin
  assign(f,'vystup.gam');
  reset(f);
  readln(f,pocet_levelov);
  for a := 1 to pocet_levelov do
    readln(f,levely[a].sirka,levely[a].vyska,levely[a].kluce);
  erase(f);
end;

procedure init_o.dekoduj_hall;
var f,f1 : file of byte;
    b,c : byte;
begin
  assign(f,'hall.gam');
  reset(f);
  assign(f1,'vystup.gam');
  rewrite(f1);
  while not EoF(f) do
    begin
      Read(f,c);
      b := c xor 250;
      Write(f1,b);
    end;
  close(f);
  close(f1);
end;

procedure init_o.nacitaj_hall;
var f : text;
    a : byte;
begin
  assign(f,'vystup.gam');
  reset(f);
  readln(f,pocet_hracov);
  for a := 1 to pocet_hracov*2 do
    begin
      readln(f,hall[a].meno);
      readln(f,hall[a].body);
    end;
  erase(f);
end;

procedure init_o.urob;
begin
  dekoduj_levely;
  nacitaj_levely;
  dekoduj_hall;
  nacitaj_hall
end;

{ . . . . . . . . . . . I N I T . . . . . . . . . . . . . . .END}


begin
  clrscr;
  ukaz_pcx;
  init_graph;
  body := 0;
  init.urob;
  menu.urob;

  for ktory := 1 to pocet_levelov do
    begin
      zivoty_i := 3;
      repeat
        level.hraj(levely[ktory].sirka,levely[ktory].vyska,zivoty_i,levely[ktory].kluce,body,ktory);
        if not skoncil_uspesne and not user_break then
          begin
            smrt;
            dec(zivoty_i);
            if zivoty_i = 0 then
              begin
                ukonci;
                menu.urob;
                ktory := 1;
                body := 0;
                zivoty_i := 3;
              end;
         end;
      until skoncil_uspesne or user_break;
      inc(body,5000);
      if user_break then
        begin
          menu.urob;
          ktory := 1;
          body := 0;
        end;
    end;
end.
