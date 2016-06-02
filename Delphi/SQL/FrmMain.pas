unit FrmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, StdCtrls;

type
  TFormMain = class(TForm)
    Query: TQuery;
    Table: TTable;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.DFM}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  with Table do
    begin
      Active := False;

      if not Exists then
        begin
          DatabaseName := 'PcPrompt';
          TableType := ttDBase;
          TableName := 'SKUSKA';
          with FieldDefs do
            begin
              Clear;
              with AddFieldDef do
                begin
                  Name := 'Field1';
                  DataType := ftString;
                  FieldNo := 0;
                  Size := 10;
                end;
            end;

          CreateTable;
        end;

      Active := True;
    end;
end;

end.
