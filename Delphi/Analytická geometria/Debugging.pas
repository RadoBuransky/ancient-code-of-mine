unit Debugging;

interface

var Subor : TextFile;

procedure Napis( s : string );

procedure Otvor;
procedure Zatvor;

implementation

procedure Otvor;
begin
  AssignFile( Subor , 'debug.txt' );
  Rewrite( Subor );
end;

procedure Zatvor;
begin
  CloseFile( Subor );
end;

procedure Napis( s : string );
begin
  Writeln( Subor , s );
  Flush( Subor );
end;

end.
