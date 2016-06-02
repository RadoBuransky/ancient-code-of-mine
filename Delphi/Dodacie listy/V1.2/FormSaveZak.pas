unit FormSaveZak;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl;

type
  TFormZakazSave = class(TForm)
    DirectoryListBox: TDirectoryListBox;
    DriveComboBox: TDriveComboBox;
    Label1: TLabel;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormZakazSave: TFormZakazSave;

implementation

{$R *.DFM}

procedure TFormZakazSave.ButtonOKClick(Sender: TObject);
begin
  ModalResult := 1;
end;

procedure TFormZakazSave.ButtonCancelClick(Sender: TObject);
begin
  ModalResult := -1;
end;

end.
