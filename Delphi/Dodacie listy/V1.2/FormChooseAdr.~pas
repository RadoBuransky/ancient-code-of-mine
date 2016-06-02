unit FormChooseAdr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl;

type
  TFormChAdr = class(TForm)
    DriveComboBox: TDriveComboBox;
    DirectoryListBox: TDirectoryListBox;
    Memo: TMemo;
    ButtonOK: TButton;
    ButtonAdr: TButton;
    Edit: TEdit;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonAdrClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormChAdr: TFormChAdr;

implementation

{$R *.DFM}

procedure TFormChAdr.ButtonOKClick(Sender: TObject);
begin
  ModalResult := 1;
end;

procedure TFormChAdr.ButtonAdrClick(Sender: TObject);
begin
  try
    if DirectoryListBox.Directory[ Length(DirectoryListBox.Directory)] <> '\' then
      MkDir( DirectoryListBox.Directory+'\'+Edit.Text )
        else
      MkDir( DirectoryListBox.Directory+Edit.Text );
    DirectoryListBox.Directory := DirectoryListBox.Directory+'\'+Edit.Text;
    DirectoryListBox.Update;
  except
  end;
end;

end.
