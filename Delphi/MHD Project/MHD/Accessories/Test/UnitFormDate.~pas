unit UnitFormDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFormDate = class(TForm)
    EditDen: TEdit;
    Label1: TLabel;
    EditMes: TEdit;
    Label2: TLabel;
    EditRok: TEdit;
    Label3: TLabel;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Day, Month, Year : integer;
  end;

var
  FormDate: TFormDate;

implementation

{$R *.DFM}

procedure TFormDate.ButtonOKClick(Sender: TObject);
begin
  try
    Day := StrToInt( EditDen.Text );
    Month := StrToInt( EditMes.Text );
    Year := StrToInt( EditRok.Text );
  except
    exit;
  end;

  if (Day < 1) or
     (Day > 31) or
     (Month < 1) or
     (Month > 12) or
     (Year < 1) then
    exit;

  ModalResult := 1;
end;

procedure TFormDate.ButtonCancelClick(Sender: TObject);
begin
  ModalResult := -1;
end;

procedure TFormDate.FormCreate(Sender: TObject);
begin
  Day := 0;
  Month := 0;
  Year := 0;
end;

end.
