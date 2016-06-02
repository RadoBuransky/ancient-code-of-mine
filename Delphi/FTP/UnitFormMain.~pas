unit UnitFormMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Psock, NMFtp, ComCtrls, Grids, Outline, FileCtrl, StdCtrls;

type
  PPath = ^TPath;
  TPath = string;

  TFormMain = class(TForm)
    MainMenu: TMainMenu;
    MainConnect: TMenuItem;
    NMFTP: TNMFTP;
    StatusBar: TStatusBar;
    GroupBox1: TGroupBox;
    DriveComboBox: TDriveComboBox;
    DirectoryListBox: TDirectoryListBox;
    FileListBox: TFileListBox;
    ListView: TListView;
    GroupBox2: TGroupBox;
    ButtonStart: TButton;
    TreeView: TTreeView;
    ButtonGetAllFiles: TButton;
    PopupMenu1: TPopupMenu;
    Delete: TMenuItem;
    procedure MainConnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonGetAllFilesClick(Sender: TObject);
    procedure NMFTPDisconnect(Sender: TObject);
    procedure NMFTPConnect(Sender: TObject);
    procedure NMFTPPacketRecvd(Sender: TObject);
    procedure NMFTPPacketSent(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NMFTPError(Sender: TComponent; Errno: Word; Errmsg: String);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure TreeViewDeletion(Sender: TObject; Node: TTreeNode);
    procedure DeleteClick(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
  private
    { Private declarations }
    DelFile, DelDir : TStringList;

    procedure VytvorStrom( ToNode : TTreeNode; Path : string );
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses UnitFormConnect;

{$R *.DFM}
//==============================================================================
//==============================================================================
//
//                                  Constructor
//
//==============================================================================
//==============================================================================

procedure TFormMain.FormCreate(Sender: TObject);
var PNewPath : PPath;
begin
  DelFile := TStringList.Create;
  DelDir := TStringList.Create;

  New( PNewPath );
  PNewPath^ := 'C:\Rado\www\x';
  TreeView.Items.AddChildObject( TreeView.Items[0] , 'NEW' , PNewPath );
end;

//==============================================================================
//==============================================================================
//
//                                  Destructor
//
//==============================================================================
//==============================================================================

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 // if NMFTP.Connected then Action := caNone;
  Action := caFree;

  DelFile.Free;
  DelDir.Free;
end;

//==============================================================================
//==============================================================================
//
//                                 Main Menu
//
//==============================================================================
//==============================================================================

procedure TFormMain.MainConnectClick(Sender: TObject);
begin
  if not NMFTP.Connected then FormConnect.MyShowModal( NMFTP )
                         else NMFTP.Disconnect;
end;

//==============================================================================
//==============================================================================
//
//                                 NMFTP
//
//==============================================================================
//==============================================================================

procedure TFormMain.NMFTPConnect(Sender: TObject);
begin
  DelFile.Clear;
  DelDir.Clear;

  StatusBar.Panels[0].Text := 'Connected';
  MainConnect.Caption := '&Disconnect';
  ButtonGetAllFiles.Enabled := True;

  ListView.Items.Clear;

  TreeView.Items.Clear;
  TreeView.Items.Add( nil , NMFTP.Host );
end;

procedure TFormMain.NMFTPDisconnect(Sender: TObject);
begin
  StatusBar.Panels[0].Text := 'Disconnected';
  MainConnect.Caption := '&Connect';
  ButtonGetAllFiles.Enabled := False;
end;

procedure TFormMain.NMFTPPacketRecvd(Sender: TObject);
begin
  StatusBar.Panels[3].Text := 'Bytes recieved : '+IntToStr( NMFTP.BytesRecvd );
end;

procedure TFormMain.NMFTPPacketSent(Sender: TObject);
begin
  StatusBar.Panels[2].Text := 'Bytes sent : '+IntToStr( NMFTP.BytesSent );
end;

procedure TFormMain.NMFTPError(Sender: TComponent; Errno: Word;
  Errmsg: String);
begin
  MessageDlg( 'Stala sa dáka chyba : '+Errmsg+' '+IntToStr( Errno ) , mtError , [mbOK] , 0 );
end;

//==============================================================================
//==============================================================================
//
//                               Tree view
//
//==============================================================================
//==============================================================================

procedure TFormMain.VytvorStrom( ToNode : TTreeNode; Path : string );
var ActualDir : string;
    I : integer;
    Files, Dirs : TStringList;
    PNewPath : PPath;
begin
  ActualDir := NMFTP.CurrentDir;
  if Path <> '' then
    begin
      NMFTP.ChangeDir( Path );
      Path := Path + '/';
    end;

  NMFTP.List;

  Files := TStringList.Create;
  Dirs := TStringList.Create;

  for I := 0 to NMFTP.FTPDirectoryList.name.Count-1 do
    case NMFTP.FTPDirectoryList.Attribute[I][1] of
      'd' : Dirs.Add( NMFTP.FTPDirectoryList.name[I] );
      '-' : Files.Add( NMFTP.FTPDirectoryList.name[I] );
    end;

  for I := 0 to Dirs.Count-1 do
    begin
      New( PNewPath );
      PNewPath^ := ActualDir+'/'+Path+Dirs[I];
      VytvorStrom( TreeView.Items.AddChildObject( ToNode , Dirs[I] , PNewPath ) , Dirs[I] );
    end;

  for I := 0 to Files.Count-1 do
    begin
      New( PNewPath );
      PNewPath^ := ActualDir+'/'+Path+Files[I];
      TreeView.Items.AddChildObject( ToNode , Files[I] , PNewPath );
    end;

  TreeView.Update;

  NMFTP.ChangeDir( ActualDir );

  Files.Free;
  Dirs.Free;
end;

procedure TFormMain.PopupMenu1Popup(Sender: TObject);
begin
  if TreeView.Selected = nil then exit;
  TreeView.Selected.Selected := True;
end;

procedure TFormMain.TreeViewDeletion(Sender: TObject; Node: TTreeNode);
begin
  if Node.Data <> nil then
    Dispose( PPath( Node.Data ) );
end;

//==============================================================================
//==============================================================================
//
//                             Ostatné komponenty
//
//==============================================================================
//==============================================================================

procedure TFormMain.ButtonGetAllFilesClick(Sender: TObject);
begin
  ButtonGetAllFiles.Enabled := False;
  StatusBar.Panels[1].Text := 'Getting file structure ...';
  MainConnect.Enabled := False;

  with NMFTP do
    begin
      ParseList := True;
      VytvorStrom( TreeView.Items[0] , '' );
    end;

  MainConnect.Enabled := True;
  StatusBar.Panels[1].Text := 'File structure got';
end;

procedure TFormMain.DeleteClick(Sender: TObject);
var NewListItem : TListItem;
begin
  if TreeView.Selected.Data = nil then exit;

  NewListItem := ListView.Items.Add;
  NewListItem.Caption := TPath( TreeView.Selected.Data^ );
  NewListItem.SubItems.Add( 'DELETE' );

  if TreeView.Selected.Count = 0 then DelFile.Add( TPath( TreeView.Selected.Data^ ) )
                                 else DelDir.Add( TPath( TreeView.Selected.Data^ ) );
end;

procedure TFormMain.ButtonStartClick(Sender: TObject);
var I : integer;
begin
  for I := 0 to DelDir.Count-1 do
    NMFTP.RemoveDir( DelDir[I] );
  for I := 0 to DelFile.Count-1 do
    NMFTP.Delete( DelFile[I] );

  ListView.Items.Clear;
  DelFile.Clear;
  DelDir.Clear;
end;

end.
