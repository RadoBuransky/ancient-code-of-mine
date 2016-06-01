{DEC => HEX}

uses crt;

var dec,pr,dr : byte;
    hex,s : string;

const pism : array[10..15] of char = ('A','B','C','D','E','F');

begin
  clrscr;
  Write('Napis cislo decimalnej sustavy: ');
  Readln(dec);
  hex := '';
  pr := dec div 16;
  if pr > 9 then hex := pism[pr]
            else Str(pr,hex);

  dr := dec - (pr * 16);
  if dr > 9 then hex := Concat(hex,pism[dr])
            else
              begin
                Str(dr,s);
                hex := concat(hex,s);
              end;
  writeln('$',hex);
  readkey;
end.