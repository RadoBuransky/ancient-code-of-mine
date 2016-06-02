unit ATWinAmpDriver;
{ Name        : ATWinAmpDriver <ATWinAmpDriver.PAS>
  Version     : 1.01
  Description : Component to drive/control WinAmp from your Delphi app.
  Programmer  : Sony Arianto Kurniawan
  Copyright © Nov-Dec, 1998 AriTech Development Indonesia
  Tools       : Borland Delphi 3.0 C/S
  E-Mail      : sony-ak@iname.com
  Web site    : http://www.geocities.com/Pentagon/5900/
  Type        : Freeware
  Price       : $0.00
  Made in Indonesia
  History     :  v1.00   - First release to public
                 v1.01   - Init some vars
  Note        : - Latest check with WinAmp v2.03
                - This component is FREEWARE if :
                    - You credits me in your app. if you use this component/code
                - some code portion from WAIPC.PAS by Brendin J. Emslie
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TATWAShowMode   = (wamNormal,wamHide,wamMinimize,wamMaximize);
  TATWinAmpDriver = class(TComponent)
  private
    FAuthor,NullValS    : string;
    FWAPath             : string;
    FWASMode            : TATWAShowMode;
    procedure SetWinAmpMode(value:TATWAShowMode);
  protected
    procedure ExecuteCmd(cmd:integer);  // execute WinAmp commands
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    function GetWinAmpHandle:hWnd;  // get WinAmp handle
    function IsWinAmpRunning:boolean;  // check if WinAmp is running
    function GetWinAmpVersionStr:string;  // get WinAmp version in string form
    function GetWinAmpVersionInt:integer;  // get WinAmp version in integer form
    function GetPlayBackStatus:integer;  // if it play=1;pause=3 or not_play=0
    function GetSongLength:integer;  // get song length in seconds
    function GetSongPos:integer;  // get song pos in milliseconds
    function GetPlayListLength:integer;  // get playlist length in tracks
    function WritePlayList:integer;  // write play list to disk
                                     // writes to <WinAmpDir>\WinAmp.pl
    function JumpToTime(newsongpos:integer):integer;// jump to new song position
                                                   // in milliseconds,
                                                   // return 0=success
                                                   //        1=on eof
                                                   //       -1=error
                                                   // ONLY AVAILABLE IN v1.60+
    procedure AddToPlayList(fname:string);  // add file name to play list
    procedure DeletePlayList;  // delete play list
    procedure Play;  // start play the music from playlist
    procedure ChangeDir(newdir:string);  // change directory
    procedure SetPlayListPos(newplpos:integer);  // set playlist pos for v2.00+
    procedure SetVolume(newvol:integer);  // set volume for v2.00+ (0-255)
    procedure SetPanning(newpan:integer);  // set panning for v2.00+ (0-255)
    procedure EQWindow;  // toggle EQ window
    procedure PlayListWindow;  // toggle PlayList window
    procedure VolumeUp;  // set volume up a little
    procedure VolumeDown;  // set volume down a little
    procedure ForwardFive;  // forward 5 seconds
    procedure RewindFive;  // rewind five seconds
    procedure GoToPrevSong;  // go to previous song
    procedure ShowLoadFile;  // show load file(s) box
    procedure ShowPreferences;  // show preferences box
    procedure SetAOT;  // toggle set "Always On Top" option
    procedure ShowAbout;  // show about box (cute)
    //button related procedures
    procedure BtnPrevSong;  // Button1 click
    procedure BtnStartList;  // Ctrl+Button1 click
    procedure BtnRewFive;  // Shift+Button1 click
    procedure BtnPlay;  // Button2 click
    procedure BtnOpenLocation;  // Ctrl+Button2 click
    procedure BtnLoadFile;  // Shift+Button2 click
    procedure BtnPause;  // Button3 click
    procedure BtnStop;  // Button4 click
    procedure BtnFadeStop;  // Shift+Button4 click
    procedure BtnFwdSong;  // Button5 click
    procedure BtnEndList;  // Ctrl+Button5 click
    procedure BtnFwdFive;  // Shift+Button5 click
    function LaunchWinAmp:integer;  // try to launch WinAmp 0=success;1=fail
    function ShutdownWinAmp:integer;  // try to shutdown WinAmp 0=success;1=fail
  published
    property Author : string read FAuthor write NullValS;
    property WinAmpPath : string read FWAPath write FWAPath;
    property WinAmpMode : TATWAShowMode read FWASMode write SetWinAmpMode;
  end;

procedure Register;

implementation

const
  // List of WinAmp's IPCs
  IPC_GETVERSION         = 0;
  IPC_PLAYFILE           = 100;     // add to playlist
  IPC_DELETE             = 101;     // delete playlist
  IPC_STARTPLAY          = 102;     // start the music
  IPC_CHDIR              = 103;     // change directory
  IPC_ISPLAYING          = 104;     // is WinAmp playing music?
  IPC_GETOUTPUTTIME      = 105;     // get song length & song position
  IPC_JUMPTOTIME         = 106;     // jump to new song position
  IPC_WRITEPLAYLIST      = 120;     // write playlist to disk
  IPC_SETPLAYLISTPOS     = 121;     // set playlist position
  IPC_SETVOLUME          = 122;     // set WinAmp volume
  IPC_SETPANNING         = 123;     // set WinAmp panning
  IPC_GETLISTLENGTH      = 124;     // get playlist length in tracks
  // List of WinAmp's commands
  WINAMP_OPTIONS_EQ      = 40036;
  WINAMP_OPTIONS_PLEDIT  = 40040;
  WINAMP_VOLUMEUP        = 40058;
  WINAMP_VOLUMEDOWN      = 40059;
  WINAMP_FFWD5S          = 40060;
  WINAMP_REW5S           = 40061;
  // List of WinAmp's button control
  WINAMP_BUTTON1         = 40044;
  WINAMP_BUTTON2         = 40045;
  WINAMP_BUTTON3         = 40046;
  WINAMP_BUTTON4         = 40047;
  WINAMP_BUTTON5         = 40048;
  WINAMP_BUTTON1_SHIFT   = 40144;
  WINAMP_BUTTON2_SHIFT   = 40145;
  WINAMP_BUTTON3_SHIFT   = 40146;
  WINAMP_BUTTON4_SHIFT   = 40147;
  WINAMP_BUTTON5_SHIFT   = 40148;
  WINAMP_BUTTON1_CTRL    = 40154;
  WINAMP_BUTTON2_CTRL    = 40155;
  WINAMP_BUTTON3_CTRL    = 40156;
  WINAMP_BUTTON4_CTRL    = 40157;
  WINAMP_BUTTON5_CTRL    = 40158;
  // List of WinAmp's additional control
  WINAMP_PREVSONG	 = 40198;
  WINAMP_FILE_PLAY       = 40029;
  WINAMP_OPTIONS_PREFS   = 40012;
  WINAMP_OPTIONS_AOT     = 40019;
  WINAMP_HELP_ABOUT      = 40041;

function TATWinAmpDriver.ShutdownWinAmp:integer;
begin
  result := 0;
  if IsWinAmpRunning then
    SendMessage(GetWinAmpHandle,WM_CLOSE,0,0)
  else
    result := 1;
end;

procedure TATWinAmpDriver.SetWinAmpMode(value:TATWAShowMode);
var
  mode  : integer;
begin
  mode  := SW_HIDE;
  if value = FWASMode then exit;
  FWASMode      := value;
  if IsWinAmpRunning then
  begin
    case value of
      wamNormal   : mode := SW_SHOWNORMAL;
      wamHide     : mode := SW_HIDE;
      wamMaximize : mode := SW_MAXIMIZE;
      wamMinimize : mode := SW_MINIMIZE;
    end;
    ShowWindow(GetWinAmpHandle,mode);
  end;
end;

function TATWinAmpDriver.LaunchWinAmp:integer;
var
  mode  : integer;
begin
  result := 0;
  mode   := SW_HIDE;
  case FWASMode of
    wamNormal   : mode := SW_SHOWNORMAL;
    wamHide     : mode := SW_HIDE;
    wamMaximize : mode := SW_MAXIMIZE;
    wamMinimize : mode := SW_MINIMIZE;
  end;
  if WinExec(PChar(FWAPath),mode) <= 31 then
    result := 1;
end;

procedure TATWinAmpDriver.BtnPrevSong;
begin
  ExecuteCmd(WINAMP_BUTTON1);
end;

procedure TATWinAmpDriver.BtnStartList;
begin
  ExecuteCmd(WINAMP_BUTTON1_CTRL);
end;

procedure TATWinAmpDriver.BtnRewFive;
begin
  ExecuteCmd(WINAMP_BUTTON1_SHIFT);
end;

procedure TATWinAmpDriver.BtnPlay;
begin
  ExecuteCmd(WINAMP_BUTTON2);
end;

procedure TATWinAmpDriver.BtnOpenLocation;
begin
  ExecuteCmd(WINAMP_BUTTON2_CTRL);
end;

procedure TATWinAmpDriver.BtnLoadFile;
begin
  ExecuteCmd(WINAMP_BUTTON2_SHIFT);
end;

procedure TATWinAmpDriver.BtnPause;
begin
  ExecuteCmd(WINAMP_BUTTON3);
end;

procedure TATWinAmpDriver.BtnStop;
begin
  ExecuteCmd(WINAMP_BUTTON4);
end;

procedure TATWinAmpDriver.BtnFadeStop;
begin
  ExecuteCmd(WINAMP_BUTTON4_SHIFT);
end;

procedure TATWinAmpDriver.BtnFwdSong;
begin
  ExecuteCmd(WINAMP_BUTTON5);
end;

procedure TATWinAmpDriver.BtnEndList;
begin
  ExecuteCmd(WINAMP_BUTTON5_CTRL);
end;

procedure TATWinAmpDriver.BtnFwdFive;
begin
  ExecuteCmd(WINAMP_BUTTON5_SHIFT);
end;

procedure TATWinAmpDriver.GoToPrevSong;
begin
  ExecuteCmd(WINAMP_PREVSONG);
end;

procedure TATWinAmpDriver.ShowLoadFile;
begin
  ExecuteCmd(WINAMP_FILE_PLAY);
end;

procedure TATWinAmpDriver.ShowPreferences;
begin
  ExecuteCmd(WINAMP_OPTIONS_PREFS);
end;

procedure TATWinAmpDriver.SetAOT;
begin
  ExecuteCmd(WINAMP_OPTIONS_AOT);
end;

procedure TATWinAmpDriver.ShowAbout;
begin
  ExecuteCmd(WINAMP_HELP_ABOUT);
end;

procedure TATWinAmpDriver.VolumeUp;
begin
  ExecuteCmd(WINAMP_VOLUMEUP);
end;

procedure TATWinAmpDriver.VolumeDown;
begin
  ExecuteCmd(WINAMP_VOLUMEDOWN);
end;

procedure TATWinAmpDriver.ForwardFive;
begin
  ExecuteCmd(WINAMP_FFWD5S);
end;

procedure TATWinAmpDriver.RewindFive;
begin
  ExecuteCmd(WINAMP_REW5S);
End;

procedure TATWinAmpDriver.EQWindow;
begin
  ExecuteCmd(WINAMP_OPTIONS_EQ);
end;

procedure TATWinAmpDriver.PlayListWindow;
begin
  ExecuteCmd(WINAMP_OPTIONS_PLEDIT);
end;

procedure TATWinAmpDriver.ExecuteCmd(cmd:integer);
begin
  if IsWinAmpRunning then
    SendMessage(GetWinAmpHandle,WM_COMMAND,cmd,0);
end;

function TATWinAmpDriver.GetPlayListLength:integer;
begin
  result    := 0;
  if IsWinAmpRunning then
    result  := SendMessage(GetWinAmpHandle,WM_USER,0,IPC_GETLISTLENGTH);
end;

procedure TATWinAmpDriver.SetPanning(newpan:integer);
begin
  if IsWinAmpRunning then
    SendMessage(GetWinAmpHandle,WM_USER,newpan,IPC_SETPANNING);
end;

procedure TATWinAmpDriver.SetVolume(newvol:integer);
begin
  if IsWinAmpRunning then
    SendMessage(GetWinAmpHandle,WM_USER,newvol,IPC_SETVOLUME);
end;

procedure TATWinAmpDriver.SetPlayListPos(newplpos:integer);
begin
  if IsWinAmpRunning then
    SendMessage(GetWinAmpHandle,WM_USER,newplpos,IPC_SETPLAYLISTPOS);
end;

function TATWinAmpDriver.WritePlaylist:integer;
begin
  result   := -1;
  if IsWinAmpRunning then
    result := SendMessage(GetWinAmpHandle,WM_USER,0,IPC_WRITEPLAYLIST);
    // result is the index of the current song in the playlist
end;

function TATWinAmpDriver.JumpToTime(newsongpos:integer):integer;
begin
  result   := -1;
  if IsWinAmpRunning then
    result := SendMessage(GetWinAmpHandle,WM_USER,newsongpos,IPC_JUMPTOTIME);
end;

function TATWinAmpDriver.GetSongPos:integer;
begin
  result   := -1;
  if IsWinAmpRunning then
    result := SendMessage(GetWinAmpHandle,WM_USER,0,IPC_GETOUTPUTTIME);
end;

function TATWinAmpDriver.GetSongLength:integer;
begin
  result   := -1;
  if IsWinAmpRunning then
    result := SendMessage(GetWinAmpHandle,WM_USER,1,IPC_GETOUTPUTTIME);
end;

function TATWinAmpDriver.GetPlayBackStatus:integer;
begin
  result   := $0F;
  if IsWinAmpRunning then
    result := SendMessage(GetWinAmpHandle,WM_USER,0,IPC_ISPLAYING);
end;

procedure TATWinAmpDriver.ChangeDir(newdir:string);
var
  i  : integer;
begin
  if IsWinAmpRunning then
  begin
    for i:=0 to length(newdir) do
      PostMessage(GetWinAmpHandle,WM_USER,ord(PChar(newdir)[i]),IPC_CHDIR);
    PostMessage(GetWinAmpHandle,WM_USER,0,IPC_CHDIR);
  end;
end;

procedure TATWinAmpDriver.Play;
begin
  if IsWinAmpRunning then
    SendMessage(GetWinAmpHandle,WM_USER,0,IPC_STARTPLAY);
end;

procedure TATWinAmpDriver.DeletePlayList;
begin
  if IsWinAmpRunning then
    SendMessage(GetWinAmpHandle,WM_USER,0,IPC_DELETE);
end;

procedure TATWinAmpDriver.AddToPlayList(fname:string);
var
  i : integer;
begin
  if IsWinAmpRunning then
  begin
    for i:=0 to length(fname) do
      PostMessage(GetWinAmpHandle,WM_USER,ord(PChar(fname)[i]),IPC_PLAYFILE);
    PostMessage(GetWinAmpHandle,WM_USER,0,IPC_PLAYFILE);
  end;
end;

function TATWinAmpDriver.GetWinAmpVersionStr:string;
begin
  result := 'Unknown Version';
  if IsWinAmpRunning then
    case SendMessage(GetWinAmpHandle,WM_USER,0,IPC_GETVERSION) of
      $1551        : result  := '1.55';
      $16A0        : result  := '1.6b';
      $16AF        : result  := '1.60';
      $16B0        : result  := '1.61';
      $16B1        : result  := '1.62';
      $16B3        : result  := '1.64';
      $16B4        : result  := '1.666';
      $16B5        : result  := '1.69';
      $1700        : result  := '1.70';
      $1702        : result  := '1.72';
      $1703        : result  := '1.73';
      $1800        : result  := '1.80';
      $1801        : result  := '1.81';
      $1802        : result  := '1.82';
      $1900        : result  := '1.90';
      $1901        : result  := '1.91';
      $2000        : result  := '2.00';
      $2001        : result  := '2.01';
      $2002        : result  := '2.02';
      $2003        : result  := '2.03';
      $2004        : result  := '2.04';
    end;
end;

function TATWinAmpDriver.GetWinAmpVersionInt:integer;
begin
  result := 0;
  if IsWinAmpRunning then
    result  := SendMessage(GetWinAmpHandle,WM_USER,0,IPC_GETVERSION);
end;

function TATWinAmpDriver.IsWinAmpRunning:boolean;
begin
  result := false;
  if GetWinAmpHandle <> 0 then
    result := true;
end;

function TATWinAmpDriver.GetWinAmpHandle:hWnd;
begin
  result := FindWindow('Winamp v1.x',nil);  // find WinAmp handle
end;

constructor TATWinAmpDriver.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FAuthor       := 'Sony Arianto Kurniawan [November,1998]';
  FWAPath       := '';
  FWASMode      := wamNormal;
end;

destructor TATWinAmpDriver.Destroy;
begin
  inherited;
end;

procedure Register;
begin
  RegisterComponents('ActiveX', [TATWinAmpDriver]);
end;

end.
