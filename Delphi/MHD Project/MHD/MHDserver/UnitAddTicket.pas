unit UnitAddTicket;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Konstanty;

type
  TFormAddTicket = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ButtonOK: TButton;
    ButtonZrusit: TButton;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonZrusitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    NewTicket : TTicket;
  end;

var
  FormAddTicket: TFormAddTicket;

implementation

{$R *.DFM}

procedure TFormAddTicket.ButtonOKClick(Sender: TObject);
begin
  try
    with NewTicket do
      begin
        Min := StrToInt( Edit1.Text );
        Norm := StrToInt( Edit2.Text );
        Zlav := StrToInt( Edit3.Text );
      end;
  except
    exit
  end;

  if (NewTicket.Min < 1) or
     (NewTicket.Norm < 0) or
     (NewTicket.Zlav < 0) then exit;

  ModalResult := 1;
end;

procedure TFormAddTicket.ButtonZrusitClick(Sender: TObject);
begin
  ModalResult := -1;
end;

end.
