unit UnitMainWnd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, ClassAdresy;

type
  TMainForm = class(TForm)
    OkBtn: TButton;
    Text: TLabel;
    Table: TTable;
    procedure OkBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.OkBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var F : TextFile;
    I, J, K : integer;
begin
  K := 0;
  Adresy := TAdresy.Create;
  try
    AssignFile( F , 'Adresy.txt' );
    try
      Rewrite( F );
      for I := 0 to Length( Adresy.Adresy )-1 do
        begin
          for J := 0 to Length(Adresy.Adresy[I])-1 do
            Writeln( F , Adresy.Adresy[I,J] );

          Writeln( F , '' );
{          for J := Length(Adresy.Adresy[I]) to 4 do
            Write( F , '|' );

          Write( F , '~' );
          K := K + 1;}
        end;

      Text.Caption := IntToStr( K )+' adries';
    finally
      CloseFile( F );
    end;
  finally
    Adresy.Destroy;
  end;
end;

end.
