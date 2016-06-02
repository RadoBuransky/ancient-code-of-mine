// Interface to libmysql.dll
// Dennis Thrysøe <qabi@mindless.com> 24-01-1999 18:33

unit MySqlClass;

interface
uses classes, dialogs, sysutils;

  // --------------------------- Constants -------------------------------------
const
 thelib='libmysql.dll';
 mysql_errmsg_size=200;
 field_type_decimal=0;
 field_type_tiny=1;
 field_type_short=2;
 field_type_long=3;
 field_type_float=4;
 field_type_double=5;
 field_type_null=6;
 field_type_timestamp=7;
 field_type_longlong=8;
 field_type_int24=9;
 field_type_date=10;
 field_type_time=11;
 field_type_datetime=12;
 field_type_enum=247;
 field_type_set=248;
 field_type_tiny_blob=249;
 field_type_medium_blob=250;
 field_type_long_blob=251;
 field_type_blob=252;
 field_type_var_string=253;
 field_type_string=254;

type
  // ------------------- Various types from libmysql.dll -----------------------
  enum_field_types=byte;
  my_bool= shortint;
  gptr= pchar;
  socket= word;

  mysql_status=(mysql_status_ready,mysql_status_get_result,mysql_status_use_result);
  mysql_net_type = (NET_TYPE_TCPIP, NET_TYPE_SOCKET, NET_TYPE_NAMEDPIPE);

  pused_mem=^used_mem;
  err_proc=procedure;

  used_mem=record
            next:pused_mem;
            left,size:word
           end;

  pmem_root=^mem_root;
  mem_root=record
           free,used:pused_mem;
           min_malloc,block_size:word;
           error_handler:err_proc;
          end;

  net=record
       net_type: mysql_net_type;
       hPipe: Integer;
       fd: socket;
       fcntl: integer;
       buff,buff_end,write_pos, read_pos: pchar;
       last_error:array[01..mysql_errmsg_size] of char;
       last_errno,max_packet,timeout,pkt_vnr: integer;
       error,return_errno, compress:my_bool;

       remain_in_buf,length, buf_length, where_b: longint;
       more: my_bool;
       save_char: char;
      end;

  pmysql_field=^mysql_field;
  mysql_field=record
             name,table,def: pchar;
             _type: enum_field_types;
             length,max_length,flags,decimals:integer;
            end;
  mysql_field_offset= integer;

  pmysql_rows=^mysql_rows;
  mysql_rows=record
            next: pmysql_rows;
            data:pointer ;
           end;

  mysql_row=array[00..$ffff div sizeof(pchar)] of pchar;
  pmysql_row=^mysql_row;

  pmysql_data=pointer;

  pmysql_res=^mysql_res;
  mysql_res= record
    row_count: longint;
    field_count, current_field:word;
    fields: pmysql_field;
    data: pmysql_data;
    data_cursor:pmysql_rows;
    field_alloc:pmem_root;
    row:pmysql_row;
    current_row:pmysql_row;
    lengths:^word;
    handle:word;
    eof:my_bool;
   end;

  pmysql=^_mysql;
  _mysql= record
        _net: net;
        host,user,passwd,
        unix_socket,
        server_version,
        host_info,
        info,db: pchar;
        port,client_flag,server_capabilities: integer;
        protocol_version,field_count: integer;
        thread_id: longint;
        affected_rows,
        insert_id,
        extra_info:longint;
        pcaket_length: longint;
        status: mysql_status;
        fields: pmysql_field;
        field_alloc: mem_root;
        free_me,reconnect:my_bool;
       end;

  // ------------------- Class declaration: TField -----------------------------
  TField = class
  public
    Name: String;
    FieldType: String;
    Constructor Create(aName: String);
  end;

  // ------------------- Class declaration: TFields ----------------------------
  TFields = class
  private
    ffields: TList;
    function getField(Index: Integer): TField;
  public
    Constructor Create(res: pmysql_res);
    Destructor Destroy; override;
    Function Count: Integer;
    Property Fields[Index: Integer]: TField read getField; default;
    Procedure Add(Value: TField);
  end;

  // ------------------- Class declaration: TRow -------------------------------
  TRow = class
  private
    fvalues: TStringList;
    function getValue(Index: Integer): String;
  public
    Constructor Create(aRow: TStringList);
    Destructor Destroy; override;
    Function Count: Integer;
    Property Databases[Index: Integer]: String read getValue; default;
    Procedure Add(Value: String);
  end;

  // ------------------- Class declaration: TRows ------------------------------
  TRows = class
  private
    frows: TList;
    function getRow(Index: Integer): TRow;
  public
    Constructor Create(res: pmysql_res; Count: Integer);
    Destructor Destroy; override;
    Function Count: Integer;
    Property Rows[Index: Integer]: TRow read getRow; default;
    Procedure Add(Value: TRow);
  end;

  // ------------------- Class declaration: TResult ----------------------------
  TResult = class
  private
    fmysql: pmysql;
  public
    Rows: TRows;
    Fields: TFields;
    AffectedRows: Integer;
    Constructor Create(res: pmysql_res; aMySql: pmysql);
    Destructor Destroy; override;
    Function lastError: String;
  end;
  

  // ------------------- Class declaration: TTable -----------------------------
  TTable = class
  public
    Name: String;
    Fields: TFields;
    FieldInfo: TResult;
    Constructor Create(aMySql: pmysql; aName: String);
    Destructor Destroy; override;
  end;

  // ------------------- Class declaration: TTables ----------------------------
  TTables = class
  private
    ftables: TList;
    fmysql: pmysql;
    function getTable(Index: Integer): TTable;
  public
    Constructor Create(aMySql: pmysql; aName: String);
    Destructor Destroy; override;
    Function Count: Integer;
    Property Tables[Index: Integer]: TTable read getTable; default;
    Procedure Add(Value: TTable);
  end;


  // ------------------- Class declaration: TDatabase --------------------------
  TDatabase = class
  private
    fmysql: pmysql;
  public
    Name: String;
    Selected: Boolean;
    Tables: TTables;
    Constructor Create(aMySql: pmysql; aName: String);
    Destructor Destroy; override;
    Function Select: Boolean;
  end;

  // ------------------- Class declaration: TDatabases -------------------------
  TDatabases = class
  private
    fdatabases: TList;
    fmysql: pmysql;
    function getDatabase(Index: Integer): TDatabase;
  public
    Constructor Create(aMySql: pmysql);
    Destructor Destroy; override;
    Function Count: Integer;
    Property Databases[Index: Integer]: TDatabase read getDatabase; default;
    Procedure Add(Value: TDatabase);
  end;

  // ------------------- Class declaration: TMySql -----------------------------
  TMySql = class
  private
    fmysql: pmysql;
    fdatabases: TDatabases;
    fresult: TResult;
    fconnected: Boolean;
    fname: String;
    fhost: String;
    fuser: String;
    fpassword: String;
    fport: Integer;
    procedure setName(aName: String);
    procedure setHost(aHost: String);
    procedure setUser(aUser: String);
    procedure setPassword(aPassword: String);
    procedure setPort(aPort: Integer);

    function getName: String;
    function getHost: String;
    function getUser: String;
    function getPassword: String;
    function getPort: Integer;
    procedure constructResult(res: pmysql_res);
  public
    class function ClientVersion: String;
    constructor CreateConnect(aHost, aUser, aPassword: String; aPort: Integer);
    destructor Destroy; override;

    function Connect: Boolean;
    function Disconnect: Boolean;
    function Connected: boolean;

    Property Name: String read getName write setName;
    Property Host: String read getHost write setHost;
    Property User: String read getUser write setUser;
    Property Password: String read getPassword write setPassword;
    Property Port: Integer read getPort write setPort;

    function getVersion: String;
    function getHostInfo: String;
    function getProtocolVersion: Integer;
    function getThreadId: Longint;
    function getStat: String;
    function getProcesses: TResult;
    function getDatabases: TDatabases;

    function Query(sql: String): TResult;

    function SelectDb(d: String): Boolean;
    function CreateDb(name: String): Boolean;
    function DeleteDb(name: String): Boolean;
    function RefreshGrants: Boolean;
    function lastError: String;
  end;

  // ------------------- Interface to libmysql.dll -----------------------------

  procedure mysql_close( _mysql: pmysql);stdcall;external thelib;
  function mysql_real_connect( _mysql: pmysql; const host,user,passwd,db:pchar; port: integer; unix_socket: pchar; clientflag: integer):pmysql;stdcall;external thelib;
  function mysql_list_dbs(_mysql:pmysql;wild: pchar):pmysql_res;stdcall;external thelib;
  function mysql_connect( _mysql: pmysql; const host,user,passwd:pchar):pmysql;stdcall;external thelib;
  function mysql_list_tables(_mysql: pmysql; const wild: pchar):pmysql_res;stdcall;external thelib;
  function mysql_list_fields(_mysql: pmysql;const table,wild: pchar):pmysql_res;stdcall;external thelib;
  function mysql_init(_mysql: pmysql): pmysql; stdcall; external thelib;
  function mysql_kill(_mysql: pmysql; pid:longint): Integer; stdcall; external thelib;
  function mysql_real_query(_mysql: pmysql; const q: pchar; length: integer): Integer; stdcall; external thelib;
  function mysql_select_db(_mysql:pmysql;const db: pchar):integer;stdcall;external thelib;
  function mysql_query(_mysql:pmysql;const query: pchar):integer;stdcall;external thelib;
  function mysql_store_result(_mysql:pmysql):pmysql_res;stdcall;external thelib;
  function mysql_get_client_info: PChar; stdcall; external thelib;
  function mysql_get_server_info(_mysql: pmysql): PChar; stdcall; external thelib;
  function mysql_get_host_info(_mysql: pmysql): PChar; stdcall; external thelib;
  function mysql_get_proto_info(_mysql: pmysql): integer; stdcall; external thelib;
  function mysql_field_seek(result: pmysql_res;offset: mysql_field_offset): mysql_field_offset; stdcall;external thelib;
  function mysql_list_processes(_mysql: pmysql):pmysql_res;stdcall;external thelib;
  function mysql_create_db(_mysql: pmysql; DB: pchar): integer; stdcall; external thelib;
  function mysql_drop_db(_mysql: pmysql; DB: pchar): integer; stdcall; external thelib;
  function mysql_stat(_mysql:pmysql):pchar;stdcall;external thelib;
  function mysql_refresh(_mysql: pmysql; refresh_options: Integer): Integer;stdcall;external thelib;
  function mysql_eof(res:pmysql_res): Integer; stdcall; external thelib;
  function mysql_use_result(_mysql:pmysql):pmysql_res;stdcall;external thelib;
  procedure mysql_free_result(result:pmysql_res);stdcall;external thelib;
  function mysql_fetch_field(handle: pmysql_res):pmysql_field;stdcall;external thelib;
  function mysql_fetch_row(res:pmysql_res):pmysql_row;stdcall;external thelib;

implementation

// -----------------------------------------------------------------------------
// ********************* Class implementation: TDatabases **********************
// -----------------------------------------------------------------------------

Constructor TDatabases.Create(aMySql: pmysql);
Var
  db: TDatabase;
  row: pmysql_row;
  res: pmysql_res;
  i: Integer;
begin
  fmysql := aMySql;
  fdatabases := TList.Create;

  res := mysql_list_dbs(fmysql,'');
  if res <> nil then
    for i:=0 to res^.row_count-1 do
    begin
      row := mysql_fetch_row(res);
      db := TDatabase.Create(fmysql,row[0]);
      fdatabases.Add(db);
    end;
  mysql_free_result(res);

  i := 0;
  while (i < fdatabases.Count) AND NOT TDatabase(fdatabases[i]).Select do
    Inc(i);
end;

Destructor TDatabases.Destroy;
Var i:Integer;
begin
  for i:=0 to fdatabases.Count-1 do
    TDatabase(fdatabases[i]).Free;
  fdatabases.Free;
end;

Function TDatabases.Count: Integer;
begin
  Result := fdatabases.Count;
end;

function TDatabases.getDatabase(Index: Integer): TDatabase;
begin;
  Result := fdatabases[Index];
end;

Procedure TDatabases.Add(Value: TDatabase);
begin
  fdatabases.Add(Value);
end;

// -----------------------------------------------------------------------------
// ********************* Class implementation: TDatabase ***********************
// -----------------------------------------------------------------------------

Constructor TDatabase.Create(aMySql: pmysql; aName: String);
begin
  fmysql := aMySql;
  Name := aName;

  mysql_select_db(fmysql,pchar(Name));
  Tables := TTables.Create(fmysql,Name)
end;

Destructor TDatabase.Destroy;
begin
  Tables.Free;
end;

Function TDatabase.Select: Boolean;
begin
  Selected := (mysql_select_db(fmysql,PChar(Name)) >= 0);
  Result := Selected;
end;

// -----------------------------------------------------------------------------
// ********************* Class implementation: TTables *************************
// -----------------------------------------------------------------------------

Constructor TTables.Create(aMySql: pmysql; aName: String);
Var
  tab: TTable;
  row: pmysql_row;
  res: pmysql_res;
  i: Integer;
begin
  fmysql := aMySql;
  ftables := TList.Create;

  res := mysql_list_tables(fmysql,'');
  if res <> nil then
    for i:=0 to res^.row_count-1 do
    begin
      row := mysql_fetch_row(res);
      tab := TTable.Create(fmysql, row[0]);
      ftables.Add(tab);
    end;
  mysql_free_result(res);
end;

Destructor TTables.Destroy;
Var i:Integer;
begin
  for i:=0 to ftables.Count-1 do
    TTable(ftables[i]).Free;
  ftables.Free;
end;

Function TTables.Count: Integer;
begin
  Result := ftables.Count;
end;

function TTables.getTable(Index: Integer): TTable;
begin;
  Result := ftables[Index];
end;

Procedure TTables.Add(Value: TTable);
begin
  ftables.Add(Value);
end;

// -----------------------------------------------------------------------------
// ********************* Class implementation: TTable **************************
// -----------------------------------------------------------------------------

Constructor TTable.Create(aMySql: pmysql; aName: String);
Var
  res: pmysql_res;
begin
  Name := aName;
  mysql_query(aMysql,Pchar('SELECT * FROM '+aName + ' LIMIT 1'));
  res := mysql_store_result(aMysql);
  Fields := TFields.Create(res);
  mysql_free_result(res);
  
  mysql_query(aMysql,Pchar('SHOW FIELDS FROM '+aName));
  res := mysql_store_result(aMysql);
  FieldInfo := TResult.Create(res,aMySql);
  mysql_free_result(res);
end;

Destructor TTable.Destroy;
begin
  Fields.Free;
  FieldInfo.Free;
end;

// -----------------------------------------------------------------------------
// ********************* Class implementation: TFields *************************
// -----------------------------------------------------------------------------

Constructor TFields.Create(res: pmysql_res);
Var
  field: TField;
  infield: pmysql_field;
begin
  ffields := TList.Create;

  if res <> nil then
  begin
    mysql_field_seek(res,0);
    Repeat
      infield := mysql_fetch_field(res);
      if infield <> nil then
      begin
        field := TField.Create(infield.name);
        ffields.Add(field);
      end;
    until infield = nil;
  end;
end;

Destructor TFields.Destroy;
Var i:Integer;
begin
  for i:=0 to ffields.Count-1 do
    TField(ffields[i]).Free;
  ffields.Free;
end;

Function TFields.Count: Integer;
begin
  Result := ffields.Count;
end;

function TFields.getField(Index: Integer): TField;
begin;
  Result := ffields[Index];
end;

Procedure TFields.Add(Value: TField);
begin
  ffields.Add(Value);
end;


// -----------------------------------------------------------------------------
// ********************* Class implementation: TField **************************
// -----------------------------------------------------------------------------

Constructor TField.Create(aName: String);
begin
  Name := aName;
end;

// -----------------------------------------------------------------------------
// ********************* Class implementation: TResult **********************
// -----------------------------------------------------------------------------

Constructor TResult.Create(res: pmysql_res; aMySql: pmysql);
begin
  fmysql := aMySql;
  Fields := TFields.Create(res);
  Rows := TRows.Create(res,Fields.Count);
  AffectedRows := aMySql.affected_rows;
end;

Destructor TResult.Destroy;
begin
  Rows.Free;
  Fields.Free;
end;

function TResult.lastError: String;
Var
 i: Integer;
begin
  Result := '';
    i:=1;
  if fmysql <> nil then
    while (i <= mysql_errmsg_size) AND (fmysql^._net.last_error[i] <> #0)do
    begin
      Result := Result + fmysql^._net.last_error[i];
      Inc(i);
    end;
end;

// -----------------------------------------------------------------------------
// ********************* Class implementation: TRows **********************
// -----------------------------------------------------------------------------

Constructor TRows.Create(res: pmysql_res; Count: Integer);
Var
  row: pmysql_row;
  i,j: Integer;
  strl: TStringList;
begin
  frows := TList.Create;
  if res <> nil then
    for i:=0 to res^.row_count-1 do
    begin
      row := mysql_fetch_row(res);
      strl := TStringList.Create;
      for j:=0 to Count-1 do
      begin
        strl.Add(row[j]);
      end;
      frows.Add(TRow.Create(strl));
    end;
end;

Destructor TRows.Destroy;
Var i:Integer;
begin
  for i:=0 to frows.Count-1 do
    TRow(frows[i]).Free;
  frows.Free;
end;

Function TRows.Count: Integer;
begin
  Result := frows.Count;
end;

function TRows.getRow(Index: Integer): TRow;
begin;
  Result := frows[Index];
end;

Procedure TRows.Add(Value: TRow);
begin
  frows.Add(Value);
end;

// -----------------------------------------------------------------------------
// ********************* Class implementation: TRow **********************
// -----------------------------------------------------------------------------

Constructor TRow.Create(aRow: TStringList);
begin
  fvalues := aRow;

end;

Destructor TRow.Destroy;
begin
  fvalues.Free;
end;

Function TRow.Count: Integer;
begin
  Result := fvalues.Count;
end;

function TRow.getValue(Index: Integer): String;
begin;
  Result := fvalues[Index];
end;

Procedure TRow.Add(Value: String);
begin
  fvalues.Add(Value);
end;

// -----------------------------------------------------------------------------
// ********************* Class implementation: TMySql **************************
// -----------------------------------------------------------------------------

function TMySql.Connect: Boolean;
begin
  fmysql := mysql_init(nil);
  if (fmysql <> nil) AND (mysql_real_connect(fmysql,pchar(fhost),pchar(fuser),pchar(fpassword),nil,fport,nil,0) <> nil) then
  begin
    fconnected := true;
    fdatabases := TDatabases.Create(fmysql);
  end
  else
    fconnected := false;

  Result := fconnected;
end;

function TMySql.Disconnect: Boolean;
begin
  mysql_close(fmysql);
  fconnected := false;
  Result := fconnected;
end;

class function TMySql.ClientVersion: String;
begin
     Result := mysql_get_client_info;
end;

constructor TMySql.CreateConnect(aHost, aUser, aPassword: String; aPort: Integer);
begin
  inherited create;
  fHost := aHost;
  fUser := aUser;
  fPassword := aPassword;
  fPort := aPort;
  Connect; 
end;

destructor TMySql.Destroy;

begin
    fDatabases.Free;
    fResult.Free;
    if (fmysql <> nil)  then
      Disconnect;
    inherited Destroy;
end;

procedure TMySql.setName(aName: String);
begin
     fName := aName;
end;

procedure TMySql.setHost(aHost: String);
begin
     fHost := aHost;
end;

procedure TMySql.setUser(aUser: String);
begin
     fUser := aUser;
end;

procedure TMySql.setPassword(aPassword: String);
begin
     fPassword := aPassword;
end;

procedure TMySql.setPort(aPort: Integer);
begin
     fPort := aPort;
end;

function TMySql.getName: String;
begin
  Result := fName;
end;

function TMySql.getHost: String;
begin
  Result := fHost;
end;

function TMySql.getUser: String;
begin
  Result := fUser;
end;

function TMySql.getPassword: String;
begin
  Result := fPassword;
end;

function TMySql.getPort: Integer;
begin
  Result := fPort;
end;

function TMySql.getVersion: String;
begin
  if (fmysql <> nil) then
     Result := mysql_get_server_info(fmysql)
  else
     Result := '';
end;

function TMySql.getHostInfo: String;
begin
  if (fmysql <> nil) then
     Result := mysql_get_host_info(fmysql)
  else
     Result := '';
end;

function TMySql.getProtocolVersion: Integer;
begin
  if (fmysql <> nil) then
     Result := mysql_get_proto_info(fmysql)
  else
     Result := 0;
end;

function TMySql.getThreadId: Longint;
begin
  if (fmysql <> nil) then
     Result := fmysql^.thread_id
  else
     Result := 0;
end;

function TMySql.getStat: String;
begin
  if (fmysql <> nil) then
     Result := mysql_stat(fmysql)
  else
     Result := '';
end;

function TMySql.getDatabases: TDatabases;
begin
  Result := fdatabases;
end;

function TMySql.Connected: boolean;
begin
     if (fmysql <> nil) then
     //Result := NOT (fmysql = nil)
     //Result := (fmysql^.protocol_version > 0)
       Result := (fmysql^._net.buff <> nil)
     else
       Result := false;
end;

procedure TMySql.constructResult(res: pmysql_res);
begin
  fresult.Free;
  fresult := TResult.Create(res,fmysql);
  mysql_free_result(res);
end;

function TMySql.Query(sql: String): TResult;
begin
  mysql_query(fmysql,pchar(sql));
  constructResult(mysql_store_result(fmysql));
  Result := fresult;
end;

function TMySql.getProcesses: TResult;
begin
  constructResult(mysql_list_processes(fmysql));
  Result := fresult;
end;

function TMySql.SelectDb(d: String): Boolean;
begin
   Result := ( mysql_select_db(fmysql,PChar(d)) >= 0);
end;

function TMySql.CreateDb(name: String): Boolean;
begin
  Result := False;
  if (fmysql <> nil) AND (mysql_create_db(fmysql,PChar(name)) = 0) then
    Result := True;
end;

function TMySql.DeleteDb(name: String): Boolean;
begin
  Result := False;
  if (fmysql <> nil) AND (mysql_drop_db(fmysql,PChar(name)) = 0) then
    Result := True;
end;

function TMySql.RefreshGrants: Boolean;
begin
  Result := (mysql_refresh(fmysql,1) = 0); // 1 is REFRESH_GRANT
end;

function TMySql.lastError: String;
Var
 i: Integer;
begin
  Result := '';
  if fmysql <> nil then
    for i:=0 to mysql_errmsg_size do
      if fmysql^._net.last_error[i] <> #0 then
        Result := Result + fmysql^._net.last_error[i];
end;

end.
