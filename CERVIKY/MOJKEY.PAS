uses crt,keyb;

var a : byte;

begin
  clrscr;
  initkeyboardhandler;
  repeat
    a := scancode;
    repeat
    until scancode <> a;
    {case scancode of
      $4F : writeln('end');
      $51 : writeln('pgdwn');
      $53 : writeln('del');
    end;}
    Writeln(scancode);
  until scancode = $01;
  keybexit;
end.