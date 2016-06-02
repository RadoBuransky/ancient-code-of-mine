unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  THlavneOkno = class(TForm)
    Query: TQuery;
    DataSource: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HlavneOkno: THlavneOkno;

implementation

{$R *.DFM}

end.
