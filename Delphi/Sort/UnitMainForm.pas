unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  PInt = ^Integer;

  TMainForm = class(TForm)
    Image: TImage;
    ButtonStart: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Pole : TList;
    Pracujem : boolean;
    procedure Pracuj;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.Pracuj;
begin
  Image.Canvas.FillRect( Image.ClientRect );

end;

procedure TMainForm.ButtonStartClick(Sender: TObject);
begin
  if Pracujem then
    begin
      ButtonStart.Caption := 'Štart';
      Pracujem := False;
    end
      else
    begin
      ButtonStart.Caption := 'Stop';
      Pracujem := True;
      Pracuj;
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var I : word;
    NewPInt : PInt;
begin
  Pole := TList.Create;
  
  for I := 0 to high( I ) do
    begin
      New( NewPInt );
      Pole.Add( NewPInt );
    end;

  for I := 0 to high( I ) do
    begin
      New( NewPInt );
      Pole.Add( NewPInt );
    end;

  with Image.Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := clBlack;
      Pen.Color := clYellow;

      FillRect( Image.ClientRect );
    end;
  Pracujem := False;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var I : integer;
begin
  for I := 0 to Pole.Count-1 do
    Dispose( PInt( Pole[I] ) );
  Pole.Free;
end;

end.
