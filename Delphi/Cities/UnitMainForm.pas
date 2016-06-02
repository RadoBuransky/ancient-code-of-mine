unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus;

type
  TMainForm = class(TForm)
    Image: TImage;
    MainMenu1: TMainMenu;
    Game1: TMenuItem;
    GameNew: TMenuItem;
    GameExit: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GameNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses ClassCities, ClassHuman, ClassComputer;

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Cities := TCities.Create( THuman.Create( Image ) , TComputer.Create , Image );
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Cities.Free;
end;

procedure TMainForm.GameNewClick(Sender: TObject);
begin
  Cities.NewGame;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Cities.Finish := True;
end;

end.
