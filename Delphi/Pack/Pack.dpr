program Pack;

uses
  ClassPack in 'ClassPack.pas',
  ClassTree in 'ClassTree.pas';

var
  PackFile : TPack;

begin
  PackFile := TPack.Create;
  try
    PackFile.Pack( 'English.src' , 'English.pck' );
  finally
    PackFile.Free;
  end;
end.
