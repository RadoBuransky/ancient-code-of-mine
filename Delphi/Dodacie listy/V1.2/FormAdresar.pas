unit FormAdresar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl;

type
  TFormAdr = class(TForm)
    DirectoryListBox: TDirectoryListBox;
    DriveComboBox: TDriveComboBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Path : string;
  end;

var
  FormAdr: TFormAdr;

implementation

uses Ini;

{$R *.DFM}

procedure TFormAdr.Button1Click(Sender: TObject);
begin
  Path := DirectoryListBox.Directory;
  ModalResult := 1;
end;

procedure TFormAdr.FormShow(Sender: TObject);
begin
  DirectoryListBox.Directory := Path;
end;

procedure TFormAdr.FormCreate(Sender: TObject);
begin
  Path := ponuky_dir;
end;

end.
