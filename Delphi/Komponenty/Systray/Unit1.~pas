unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Systray, ShellApi, ShlObj, StdCtrls,ExtSys, ExtCtrls;

type
  TForm1 = class(TForm)
    PopupMenu1: TPopupMenu;
    Exit1: TMenuItem;
    Button1: TButton;
    Edit1: TEdit;
    Properties1: TMenuItem;
    Minimize1: TMenuItem;
    Maximize1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Restore1: TMenuItem;
    Panel1: TPanel;
    picovina1: TMenuItem;
    Systray1: TSystray;
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure Maximize1Click(Sender: TObject);
    procedure Minimize1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Restore1Click(Sender: TObject);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Exit1DrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
  private

  public
    Sys : TSystray;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
procedure TForm1.FormCreate(Sender: TObject);
var ic : TIcon;
begin
{  ic := TIcon.Create;
  ic.LoadFromFile ('C:\my documents\systrayIcon.ico');
  Sys := TSystray.Create (Self);
  Sys.Parent := self;
  Sys.ToolTip := 'Mirko''s test component';
  Sys.Icon := ic;}
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  close;
end;


procedure TForm1.Button1Click(Sender: TObject);
var Folder : IShellFolder;ppidl : PItemIdList;
begin
  SHParseDisplayName (self.handle,edit1.text,Folder,ppidl);
  SHDisplayContext (self.handle,Folder,ppidl);
end;

procedure TForm1.Properties1Click(Sender: TObject);
begin
  button1.click;
end;

procedure TForm1.Maximize1Click(Sender: TObject);
begin
  self.WindowState := wsMaximized;
//  Application.Ma
end;

procedure TForm1.Minimize1Click(Sender: TObject);
begin
  Application.Minimize;
  self.WindowState := wsMinimized;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
var i : integer;
begin
  for i := 1 to 3 do
    PopupMenu1.Items[i+1].Enabled := true;
  case self.WindowState of
    wsMinimized : PopupMenu1.Items[3].Enabled := false;
    wsMaximized : PopupMenu1.Items[4].Enabled := false;
    wsNormal : PopupMenu1.Items[2].Enabled := false;
  end;
end;

procedure TForm1.Restore1Click(Sender: TObject);
begin
  Application.Restore;
  Self.WindowState := wsNormal;
end;

procedure TForm1.Panel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    Popupmenu1.popup (X,Y);
end;

procedure TForm1.Exit1DrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
begin
  if sender is Tmenuitem then
end;

end.

