unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    LabelOD: TLabel;
    LabelDO: TLabel;
    ButtonStart: TButton;
    Memo: TMemo;
    procedure ButtonStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Running : boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses ClassData, ClassHladanie;

{$R *.DFM}

procedure TForm1.ButtonStartClick(Sender: TObject);
var I, J : integer;
    SearchData : TSearchData;
begin
  ButtonStart.Caption := '&Stop';
  Running := not Running;
  Memo.Clear;

  with SearchData do
    with Settings do
      begin
        Time := 420;
        Den := 0;
        Zlavneny := False;
        Peso := -0;
        Rezerva := -5;
        AutoShow := False;
      end;

  for I := 0 to Data.Zastavky.Count-1 do
    begin
      SearchData.Odkial := Data.Zastavky[I];
      for J := 0 to Data.Zastavky.Count-1 do
        begin
          if not Running then break;

          LabelOD.Caption := TZastavka( Data.Zastavky[I]^ ).Nazov + '('+IntToStr(I)+')';
          LabelDO.Caption := TZastavka( Data.Zastavky[J]^ ).Nazov + '('+IntToStr(J)+')';
          Application.ProcessMessages;

          if (I = J) then continue;

          SearchData.Kam := Data.Zastavky[J];

          if (Hladanie.Najdi( SearchData ) = nil) then
            Memo.Lines.Add( LabelOD.Caption +' -> '+LabelDO.Caption );
        end;
      if not Running then break;
    end;

  ButtonStart.Caption := '&Štart';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Data := TData.Create;
  Hladanie := THladanie.Create;
  Running := False;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Hladanie.Free;
  Data.Free;
end;

end.
