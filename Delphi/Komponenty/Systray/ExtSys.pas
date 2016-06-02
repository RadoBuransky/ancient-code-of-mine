unit ExtSys;

interface
uses
  Windows, SysUtils, ShellApi, ShlObj;

procedure SHParseDisplayName (handle :  Hwnd;S : string;out AFolder : IShellFolder;
                              out Appidl : PitemIDList);

procedure SHDisplayContext (handle : Hwnd;AFolder : IShellFolder;
                            Appidl : PItemIDList);

implementation

procedure SHParseDisplayName (handle :  Hwnd;S : string;out AFolder : IShellFolder;
                              out Appidl : PitemIDList);
var Folder : array[0..1] of IShellFolder;ppidl : PItemIDList;
    strings : array [1..100] of string;i,j,k : integer;OleS : PWideChar;
    par,n : ULong;
begin
  j := 1; k := 1; setlength (strings[1],255);
  for i := 1 to length (S) do
    begin
      strings[k][j] := S[i];
      if S[i] = '\' then
        begin
          setlength (strings[k],j);
          inc(k);
          setlength (strings[k],255);
          j := 0;
        end;
      inc(j);
    end;
  setlength (strings[k],j-1);
  SHGetDesktopFolder (Folder[0]);
  SHGetSpecialFolderLocation (handle,CSIDL_DRIVES,ppidl);
  Folder[0].BindToObject (ppidl,nil,IID_ISHELLFOLDER,Folder[1]);
  Folder[0] := Folder[1];
  for i := 1 to k-1 do
    begin
      OleS := StringToWideChar (Strings[i],OleS,length(Strings[i])*2+2);
      Folder[0].ParseDisplayName (handle,nil,OleS,n,ppidl,par);
      Folder[0].BindToObject (ppidl,nil,IID_ISHELLFOLDER,Folder[1]);
      Folder[0] := Folder[1];
    end;
  OleS := StringToWideChar (Strings[k],OleS,length(Strings[k])*2+2);
  Folder[0].ParseDisplayName (handle,nil,OleS,n,ppidl,par);
  AFolder := Folder[0];
  Appidl := ppidl;
end;

procedure SHDisplayContext;
var n,par : ULONG;
    ContextMenu : IContextMenu;Data : CMINVOKECOMMANDINFO;
begin
  Data.cbSize := sizeof (CMINVOKECOMMANDINFO);
  data.fMask := 0;
  data.hwnd := handle;
  data.lpVerb := 'properties';
  data.lpParameters := '';
  data.lpDirectory := '';
  data.nShow := SW_SHOW;
  begin
    AFolder.GetUIObjectOf (handle,1,Appidl,IID_IContextMenu,nil,ContextMenu);
    ContextMenu.InvokeCommand (data);// = NOERROR then close;
  end;
end;

end.
