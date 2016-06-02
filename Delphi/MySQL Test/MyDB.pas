unit MyDB;
interface
uses {$IFNDEF LINUX}Windows, {$ENDIF}Classes, SysUtils;

// Most important thing to check if functionality fails,
// check these compiler switches:

{$IFDEF LINUX}
{$DEFINE NEW_LIBMYSQL_DLL}
// $ DEFINE OLD_LIBMYSQL_DLL
{$ENDIF}


//i'm developing on Linux Redhat 7.1 with
//custom installation of MySQL 3.23 client+server,
//typically i need the new libs.
//Obviously there's no way to check library version before compiling :(

////////////////////////////////////////////////
//                                            //
// TMyDB component v 0.1 by artee@dubaron.com //
// TMyDB is a MySQL specific interface        //
//                                            //
////////////////////////////////////////////////

// MySQL stand-alone interface unit & component
// Developed with Kylix OE,
// should work on delphi 4 and higher as well
// By artee@dubaron.com
//
// * For both component and low level use.
// * Most relevant functions ported.
// * Special functionality to get results in
//   two-dimensional array (type TQueryResult)
// * design time functionality

// Got some header stripped from Zeos components.
// Their header is below. Tx pals.
//
// Zeos left some compiler switches which
// may or may not be relevant for your windows/linux system
//
// { $ DEFINE OLD_LIBMYSQL_DLL}
// { $ DEFINE NEW_LIBMYSQL_DLL}
//
// ToDo:
// *Debug this unit!
// *set options for real_connect, like compression etc.

//\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

{********************************************************}
{                                                        }
{                 Zeos Database Objects                  }
{        Delphi plain interface to libmysql.dll          }
{                                                        }
{       Copyright (c) 1999-2001 Sergey Seroukhov         }
{    Copyright (c) 1999-2001 Zeos Development Group      }
{                                                        }
{********************************************************}


{***************** Plain API Constants definition ****************}

const
{$IFNDEF LINUX}
  DEFAULT_DLL_LOCATION = 'libmysql.dll';
{$ELSE}
  DEFAULT_DLL_LOCATION = '/usr/local/lib/mysql/libmysqlclient.so';
{$ENDIF}

{General Declarations}
  MYSQL_ERRMSG_SIZE    = 200;
  MYSQL_PORT           = 3306;
  LOCAL_HOST           = 'localhost';
  NAME_LEN             = 64;
  PROTOCOL_VERSION     = 10;
  FRM_VER              = 6;

{Enum Field Types}
  FIELD_TYPE_DECIMAL   = 0;
  FIELD_TYPE_TINY      = 1;
  FIELD_TYPE_SHORT     = 2;
  FIELD_TYPE_LONG      = 3;
  FIELD_TYPE_FLOAT     = 4;
  FIELD_TYPE_DOUBLE    = 5;
  FIELD_TYPE_NULL      = 6;
  FIELD_TYPE_TIMESTAMP = 7;
  FIELD_TYPE_LONGLONG  = 8;
  FIELD_TYPE_INT24     = 9;
  FIELD_TYPE_DATE      = 10;
  FIELD_TYPE_TIME      = 11;
  FIELD_TYPE_DATETIME  = 12;
  FIELD_TYPE_YEAR      = 13;
  FIELD_TYPE_NEWDATE   = 14;
  FIELD_TYPE_ENUM      = 247;
  FIELD_TYPE_SET       = 248;
  FIELD_TYPE_TINY_BLOB = 249;
  FIELD_TYPE_MEDIUM_BLOB = 250;
  FIELD_TYPE_LONG_BLOB = 251;
  FIELD_TYPE_BLOB      = 252;
  FIELD_TYPE_VAR_STRING = 253;
  FIELD_TYPE_STRING    = 254;

{For Compatibility}
  FIELD_TYPE_CHAR      = FIELD_TYPE_TINY;
  FIELD_TYPE_INTERVAL  = FIELD_TYPE_ENUM;

{ Field's flags }
  NOT_NULL_FLAG          = 1;     { Field can't be NULL }
  PRI_KEY_FLAG           = 2;     { Field is part of a primary key }
  UNIQUE_KEY_FLAG        = 4;     { Field is part of a unique key }
  MULTIPLE_KEY_FLAG      = 8;     { Field is part of a key }
  BLOB_FLAG              = 16;    { Field is a blob }
  UNSIGNED_FLAG          = 32;    { Field is unsigned }
  ZEROFILL_FLAG          = 64;    { Field is zerofill }
  BINARY_FLAG            = 128;   { Field is binary }
  ENUM_FLAG              = 256;   { Field is an enum }
  AUTO_INCREMENT_FLAG    = 512;   { Field is a autoincrement field }
  TIMESTAMP_FLAG         = 1024;  { Field is a timestamp }
  SET_FLAG               = 2048;  { Field is a set }
  NUM_FLAG               = 32768; { Field is num (for clients) }

{Server Administration Refresh Options}
  REFRESH_GRANT	         = 1;     { Refresh grant tables }
  REFRESH_LOG		 = 2;     { Start on new log file }
  REFRESH_TABLES	 = 4;     { close all tables }
  REFRESH_HOSTS	         = 8;     { Flush host cache }
  REFRESH_STATUS         = 16;    { Flush status variables }
  REFRESH_THREADS        = 32;    { Flush status variables }
  REFRESH_SLAVE          = 64;    { Reset master info abd restat slave thread }
  REFRESH_MASTER         = 128;   { Remove all bin logs in the index and truncate the index }
  REFRESH_READ_LOCK      = 16384; { Lock tables for read }
  REFRESH_FAST		 = 32768; { Intern flag }

{ Client Connection Options }
  _CLIENT_LONG_PASSWORD	  = 1;	  { new more secure passwords }
  _CLIENT_FOUND_ROWS	  = 2;	  { Found instead of affected rows }
  _CLIENT_LONG_FLAG	  = 4;	  { Get all column flags }
  _CLIENT_CONNECT_WITH_DB = 8;	  { One can specify db on connect }
  _CLIENT_NO_SCHEMA	  = 16;	  { Don't allow database.table.column }
  _CLIENT_COMPRESS	  = 32;	  { Can use compression protcol }
  _CLIENT_ODBC		  = 64;	  { Odbc client }
  _CLIENT_LOCAL_FILES	  = 128;  { Can use LOAD DATA LOCAL }
  _CLIENT_IGNORE_SPACE	  = 256;  { Ignore spaces before '(' }
  _CLIENT_CHANGE_USER     = 512;  { Support the mysql_change_user() }
  _CLIENT_INTERACTIVE     = 1024; { This is an interactive client }
  _CLIENT_SSL             = 2048; { Switch to SSL after handshake }
  _CLIENT_IGNORE_SIGPIPE  = 4096; { IGNORE sigpipes }
  _CLIENT_TRANSACTIONS    = 8196; { Client knows about transactions }


{****************** Plain API Types definition *****************}

type
   TBOOL =LongBool;
   TInt64=Int64;
  TClientCapabilities = (
    CLIENT_LONG_PASSWORD,
    CLIENT_FOUND_ROWS,
    CLIENT_LONG_FLAG,
    CLIENT_CONNECT_WITH_DB,
    CLIENT_NO_SCHEMA,
    CLIENT_COMPRESS,
    CLIENT_ODBC,
    CLIENT_LOCAL_FILES,
    CLIENT_IGNORE_SPACE
  );

  TSetClientCapabilities = set of TClientCapabilities;

  TRefreshOptions = (
    _REFRESH_GRANT,
    _REFRESH_LOG,
    _REFRESH_TABLES,
    _REFRESH_HOSTS,
    _REFRESH_FAST
  );
  TSetRefreshOptions = set of TRefreshOptions;

  mysql_status = (
    MYSQL_STATUS_READY,
    MYSQL_STATUS_GET_RESULT,
    MYSQL_STATUS_USE_RESULT
  );

  mysql_option = (
    MYSQL_OPT_CONNECT_TIMEOUT,
    MYSQL_OPT_COMPRESS,
    MYSQL_OPT_NAMED_PIPE,
    MYSQL_INIT_COMMAND,
    MYSQL_READ_DEFAULT_FILE,
    MYSQL_READ_DEFAULT_GROUP,
    MYSQL_SET_CHARSET_DIR,
    MYSQL_SET_CHARSET_NAME
  );

  PUSED_MEM=^USED_MEM;
  USED_MEM = packed record
    next:       PUSED_MEM;
    left:       Integer;
    size:       Integer;
  end;

  PERR_PROC = ^ERR_PROC;
  ERR_PROC = procedure;

  PMEM_ROOT = ^MEM_ROOT;
  MEM_ROOT = packed record
    free:          PUSED_MEM;
    used:          PUSED_MEM;
{$IFDEF NEW_LIBMYSQL_DLL}
    pre_alloc:     PUSED_MEM;
{$ENDIF}
    min_malloc:    Integer;
    block_size:    Integer;
    error_handler: PERR_PROC;
  end;

  NET = packed record
    vio:           Pointer;
    fd:            Integer;
    fcntl:         Integer;
    buff:          PChar;
    buff_end:      PChar;
    write_pos:     PChar;
    read_pos:      PChar;
    last_error:    array[01..MYSQL_ERRMSG_SIZE] of Char;
    last_errno:    Integer;
    max_packet:    Integer;
    timeout:       Integer;
    pkt_nr:        Integer;
{$IFDEF NEW_LIBMYSQL_DLL}
    error:         Char;
{$ELSE}
    error:         TBool;
{$ENDIF}
    return_errno:  TBool;
    compress:      TBool;
{$IFDEF NEW_LIBMYSQL_DLL}
    no_send_ok:    TBool;
{$ENDIF}
    remain_in_buf: LongInt;
    length:        LongInt;
    buf_length:    LongInt;
    where_b:       LongInt;
{$IFDEF NEW_LIBMYSQL_DLL}
    return_status: Pointer;
    reading_or_writing: Char;
{$ELSE}
    more:          TBool;
{$ENDIF}
    save_char:     Char;
  end;

  MYSQL_FIELD = record
    name:       PChar;
    table:      PChar;
    def:        PChar;
    _type:      Byte;
    length:     Integer;
    max_length: Integer;
    flags:      Integer;
    decimals:   Integer;
  end;

  PMYSQL_FIELD = ^MYSQL_FIELD;
  MYSQL_FIELDS = array [0..$ff] of MYSQL_FIELD;
  PMYSQL_FIELDS = ^MYSQL_FIELDS;

  MYSQL_FIELD_OFFSET = Cardinal;

  MYSQL_ROW = array[00..$ff] of PChar;
  PMYSQL_ROW = ^MYSQL_ROW;

  PMYSQL_ROWS = ^MYSQL_ROWS;
  MYSQL_ROWS = record
    next:       PMYSQL_ROWS;
    data:       PMYSQL_ROW;
  end;

  MYSQL_ROW_OFFSET = PMYSQL_ROWS;

  MYSQL_DATA = record
    Rows:       TInt64;
    Fields:     Cardinal;
    Data:       PMYSQL_ROWS;
    Alloc:      MEM_ROOT;
  end;
  PMYSQL_DATA = ^MYSQL_DATA;

type
  _MYSQL_OPTIONS = record
    connect_timeout: Integer;
    clientFlag:      Integer;
    compress:        TBool;
    named_pipe:      TBool;
    port:            Integer;
    host:            PChar;
    init_command:    PChar;
    user:            PChar;
    password:        PChar;
    unix_socket:     PChar;
    db:              PChar;
    my_cnf_file:     PChar;
    my_cnf_group:    PChar;
    charset_dir:     PChar;
    charset_name:    PChar;
    use_ssl:         TBool;
    ssl_key:         PChar;
    ssl_cert:        PChar;
    ssl_ca:          PChar;
    ssl_capath:      PChar;
  end;
  PMYSQL_OPTIONS = ^_MYSQL_OPTIONS;

  MYSQL = record
    _net:            NET;
    connector_fd:    PChar;
    host:            PChar;
    user:            PChar;
    passwd:          PChar;
    unix_socket:     PChar;
    server_version:  PChar;
    host_info:       PChar;
    info:            PChar;
    db:              PChar;
    port:            Integer;
    client_flag:     Integer;
    server_capabilities: Integer;
    protocol_version: Integer;
    field_count:     Integer;
{$IFDEF NEW_LIBMYSQL_DLL}
    server_status:   Integer;
{$ENDIF}
    thread_id:       LongInt;
    affected_rows:   TInt64;
    insert_id:       TInt64;
    extra_info:      TInt64;
    packet_length:   LongInt;
    status:          mysql_status;
    fields:          PMYSQL_FIELD;
    field_alloc:     MEM_ROOT;
    free_me, reconnect: TBool;
    options:         _mysql_options;
    scramble_buff:   array[0..8] of Char;
    charset:         PChar;
{$IFDEF NEW_LIBMYSQL_DLL}
    server_language: Integer;
{$ENDIF}
  end;
  PMYSQL = ^MYSQL;

  MYSQL_RES = packed record
    row_count:       TInt64;
    field_count:     Integer;
    current_field:   Integer;
    fields:          PMYSQL_FIELD;
    data:            PMYSQL_DATA;
    data_cursor:     PMYSQL_ROWS;
    field_alloc:     MEM_ROOT;
    row:             PMYSQL_ROW;
    current_row:     PMYSQL_ROW;
    lengths:         PLongInt;
    handle:          PMYSQL;
    eof:             TBool;
  end;
  PMYSQL_RES = ^MYSQL_RES;

  TModifyType = (MODIFY_INSERT, MODIFY_UPDATE, MODIFY_DELETE);
  TQuoteOptions = (QUOTE_STRIP_CR,QUOTE_STRIP_LF);
  TQuoteOptionsSet = set of TQuoteOptions;

{************** Plain API Function types definition *************}

  Tmysql_debug = procedure(Debug: PChar);

  Tmysql_dump_debug_info = function(Handle: PMYSQL): Integer;

  Tmysql_init = function(Handle: PMYSQL): PMYSQL;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_connect = function(Handle: PMYSQL; const Host, User, Passwd: PChar):
    PMYSQL; {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_real_connect = function(Handle: PMYSQL;
    const Host, User, Passwd, Db: PChar; Port: Cardinal;
    unix_socket: PChar; clientflag: Cardinal): PMYSQL;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_close = procedure(Handle: PMYSQL);
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_query = function(Handle: PMYSQL; const Query: PChar): Integer;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_real_query = function(Handle: PMYSQL; const Query: PChar;
    len: Integer): Integer;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_select_db = function(Handle: PMYSQL; const Db: PChar): Integer;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_create_db = function(Handle: PMYSQL; const Db: PChar): Integer;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_drop_db = function(Handle: PMYSQL; const Db: PChar): Integer;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_shutdown = function(Handle: PMYSQL): Integer;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_refresh = function(Handle: PMYSQL; Options: Cardinal): Integer;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_kill = function(Handle: PMYSQL; Pid: longint): Integer;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_ping = function(Handle: PMYSQL): Integer;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_stat = function(Handle: PMYSQL): PChar;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_options = function(Handle: PMYSQL; Option: mysql_option;
    const Arg: PChar): Integer; {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_escape_string = function(PTo, PFrom: PChar; Len: Cardinal): Cardinal;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_get_server_info = function(Handle: PMYSQL): PChar;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_get_client_info = function: PChar;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_get_host_info = function(Handle: PMYSQL): PChar;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_get_proto_info = function(Handle: PMYSQL): Cardinal;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_list_dbs = function(Handle: PMYSQL; Wild: PChar): PMYSQL_RES;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_list_tables = function(Handle: PMYSQL; const Wild: PChar): PMYSQL_RES;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_list_fields = function(Handle: PMYSQL; const Table, Wild: PChar):
    PMYSQL_RES; {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_list_processes = function(Handle: PMYSQL): PMYSQL_RES;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_store_result = function(Handle: PMYSQL): PMYSQL_RES;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_use_result = function(Handle: PMYSQL): PMYSQL_RES;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_free_result = procedure(Result: PMYSQL_RES);
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_fetch_row = function(Result: PMYSQL_RES): PMYSQL_ROW;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_fetch_lengths = function(Result: PMYSQL_RES): PLongInt;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_fetch_field = function(Result: PMYSQL_RES): PMYSQL_FIELD;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

{$IFNDEF OLD_LIBMYSQL_DLL}
  Tmysql_data_seek = procedure(Result: PMYSQL_RES; Offset: TInt64);
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};
{$ELSE}
  Tmysql_data_seek = procedure(Result: PMYSQL_RES; Offset: Cardinal);
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};
{$ENDIF}

  Tmysql_row_seek = function(Result: PMYSQL_RES; Row: MYSQL_ROW_OFFSET):
    MYSQL_ROW_OFFSET; {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_field_seek = function(Result: PMYSQL_RES; Offset: mysql_field_offset):
    mysql_field_offset; {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};

  Tmysql_thread_id = function(Handle: PMYSQL): cardinal;
    {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};
  //EOZeos
  //Functions added by ArTee@dubaron.com:
  Tmysql_insert_id = function(Handle: PMYSQL):Int64;          {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};
  Tmysql_fetch_fields = function(Result: PMYSQL_RES):PMYSQL_FIELDS; {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};
  Tmysql_num_fields = function(Result: PMYSQL_RES):Integer;   {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF};
  //EOArTee

  //ZEOS:
{************* Plain API Function variables definition ************}

var
  mysql_debug:          Tmysql_debug;
  mysql_dump_debug_info: Tmysql_dump_debug_info;
  mysql_init:           Tmysql_init;
  mysql_connect:        Tmysql_connect;
  mysql_real_connect:   Tmysql_real_connect;
  mysql_close:          Tmysql_close;
  mysql_select_db:      Tmysql_select_db;
  mysql_create_db:      Tmysql_create_db;
  mysql_drop_db:        Tmysql_drop_db;
  mysql_query:          Tmysql_query;
  mysql_real_query:     Tmysql_query;
  mysql_shutdown:       Tmysql_shutdown;
  mysql_refresh:        Tmysql_refresh;
  mysql_kill:           Tmysql_kill;
  mysql_ping:           Tmysql_ping;
  mysql_stat:           Tmysql_stat;
  mysql_options:        Tmysql_options;
  mysql_escape_string:  Tmysql_escape_string;
  mysql_get_server_info: Tmysql_get_server_info;
  mysql_get_client_info: Tmysql_get_client_info;
  mysql_get_host_info:  Tmysql_get_host_info;
  mysql_get_proto_info: Tmysql_get_proto_info;
  mysql_list_dbs:       Tmysql_list_dbs;
  mysql_list_tables:    Tmysql_list_tables;
  mysql_list_fields:    Tmysql_list_fields;
  mysql_list_processes: Tmysql_list_processes;
  mysql_data_seek:      Tmysql_data_seek;
  mysql_row_seek:       Tmysql_row_seek;
  mysql_field_seek:     Tmysql_field_seek;
  mysql_fetch_row:      Tmysql_fetch_row;
  mysql_fetch_lengths:  Tmysql_fetch_lengths;
  mysql_fetch_field:    Tmysql_fetch_field;
  mysql_store_result:   Tmysql_store_result;
  mysql_use_result:     Tmysql_use_result;
  mysql_free_result:    Tmysql_free_result;
  mysql_thread_id:      Tmysql_thread_id;
  //EOZEOS
  //ArTee:
  mysql_insert_id:      Tmysql_insert_id;
  mysql_fetch_fields:   Tmysql_fetch_fields;
  mysql_num_fields:     Tmysql_num_fields;
  //EOArTEe

//ZEOS:
function MySqlLoadLib: Boolean;

var
     DLL: string = DEFAULT_DLL_LOCATION;

var  hDLL: THandle = 0;
     LibLoaded: Boolean = False;
//EOZEOS

//TMyDB Component definition by ArTee:

const MY_DEFAULT_PORT=3306;

type TQueryRow=Array of String;
     TQueryResult=Array of TQueryRow;
     TExtResult= record IsNull:Boolean;
                 end;
     TExtQueryRow = Array of TExtResult;
     TExtQueryResult = Array of TExtQueryRow;

     //Some types redefined
     //Mainly PChar to String conversion:

     TMySQLField = record
                     name,
                     table,
                     def: String;
                     _type: Byte;
                     length: Integer;
                     max_length: Integer;
                     flags: Integer;
                     decimals: Integer;
                   end;
     TMySQLFields = array of TMySQLField;

     TMyDB = class (TComponent)
     private
       MyHandle:MySQL;
       PMyHandle:PMySQL;
       FActive:Boolean;
       FHost:String;
       FPort:Integer;
       FUser:String;
       FPass:String;
       FDatabase:String;
       FLibrary:String;
       FSQL:String;
       FLastError:String;
       FHasResult:Boolean;
       FQueryResult:TQueryResult;
       FExtQueryResult:TExtQueryResult;
       FLastInsertID:Int64;
       FRowsAffected:Integer;
       FResultFields:TStringList;
       FResultTable:String;
       FResultAsString:String;
       FResultAsText:String;
       FResultAsHTML:String;
       FFieldNames:TStrings;
       FFields:TMySQLFields;
       FNumFields:Integer;
       FFetchRowLimit:Integer;
       FFetchMemoryLimit:Integer;
       FCharSet:String;
       FServerVersion:String;
       FHostInfo:String;
       FInfo:String;
       FRealConnect:Boolean;
       FUnixSock:String;
       FConnectOptions:Integer;
       ActivateOnLoad:Boolean;
       FOnError:TNotifyEvent;
       FOnBeforeQuery:TNotifyEvent;
       FOnSuccess:TNotifyEvent;
       FOnOpen:TNotifyEvent;
       FOnClose:TNotifyEvent;
       procedure StoreResult(Res: PMYSQL_RES);
     protected
       procedure Loaded; override;
     public
       procedure SetActive (DBActive:Boolean);
       Constructor Create (AOwner:TComponent); override;
       procedure Connect (Host, User, Pass:String);
       procedure Close;
       procedure Query (SQL:String);
       procedure SelectDatabase(Database:String);
       procedure CreateDatabase(Database:String);
       procedure DropDatabase(Database:String);
       procedure ListDatabases(wildcard:String='');
       procedure ListTables(wildcard:String='');
       procedure ListFields(table:String; wildcard:String='');
       procedure ListProcesses;
       procedure ShutDown;
       procedure Kill (Pid:Integer);
       procedure SetPort (Port:Integer);
       procedure SetRealConnect(DoRealConnect:Boolean);
       function Ping:Boolean;
       function GetLastError:String;
       function GetServerInfo:String;
       property LastInsertID:Int64 read FLastInsertID;
       property RowsAffected:Integer read FRowsAffected;
       property ResultFields:TStringList read FResultFields;
       property ResultTable:String read FResultTable;
       property DBHandle:MySQL read MyHandle;
       property HasResult:Boolean read FHasResult write FHasResult;
       property LastError:String read FLastError;
       property ResultSet:TQueryResult read FQueryResult;
       property ExtResultSet:TExtQueryResult read FExtQueryResult;
       property ServerInfo:String read GetServerInfo;
       property FieldNames:TStrings read FFieldNames;
       property Fields:TMySQLFields read FFields;
       property ResultAsString:String read FResultAsString;
       property ResultAsText:String read FResultAsText;
       property NumFields:Integer read FNumFields;
       property CharSet:String read FCharSet;
       property ServerVersion:String read FServerVersion;
       property Info:String read FInfo;
       property HostInfo:String read FHostInfo;
       property UnixSock:String read FUnixSock write FUnixSock;
     published
       property SQL:String read FSQL write FSQL;
       property Active:Boolean read FActive write SetActive;
       property Host:String read FHost write FHost;
       property Port:Integer read FPort write SetPort;
       property Database:String read FDatabase write SelectDatabase;
       property SharedLibrary:String read FLibrary write FLibrary;
       property User:String read FUser write FUser;
       property Password:String read FPass write FPass;
       property FetchRowLimit:Integer read FFetchRowLimit write FFetchRowLimit default 0;
       property FetchMemoryLimit:Integer read FFetchMemoryLimit write FFetchMemoryLimit default 2*1024*1024; //2Mb       //Events:
       property RealConnect:Boolean read FRealConnect write SetRealConnect;
       property OnError:TNotifyEvent read FOnError write FOnError;
       property OnBeforeQuery:TNotifyEvent read FOnBeforeQuery write FOnBeforeQuery;
       property OnOpen:TNotifyEvent read FOnOpen write FOnOpen;
       property OnClose:TNotifyEvent read FOnClose write FOnClose;
       property OnSuccess:TNotifyEvent read FOnSuccess write FOnSuccess;
     end;

procedure Register;

implementation


// Initialize MySQL dynamic library
function MySqlLoadLib: Boolean;
begin
  if hDLL = 0 then
  begin
    hDLL := GetModuleHandle(PChar(DLL));
    LibLoaded := False;
    if hDLL = 0 then
    begin
      hDLL := LoadLibrary(PChar(DLL));
      LibLoaded := True;
    end;
  end;

  if hDLL <> 0 then begin
    @mysql_debug           := GetProcAddress(hDLL,'mysql_debug');
    @mysql_dump_debug_info := GetProcAddress(hDLL,'mysql_dump_debug_info');
    @mysql_init            := GetProcAddress(hDLL,'mysql_init');
    @mysql_connect         := GetProcAddress(hDLL,'mysql_connect');
    @mysql_real_connect    := GetProcAddress(hDLL,'mysql_real_connect');
    @mysql_close           := GetProcAddress(hDLL,'mysql_close');
    @mysql_select_db       := GetProcAddress(hDLL,'mysql_select_db');
    @mysql_create_db       := GetProcAddress(hDLL,'mysql_create_db');
    @mysql_drop_db         := GetProcAddress(hDLL,'mysql_drop_db');
    @mysql_query           := GetProcAddress(hDLL,'mysql_query');
    @mysql_real_query      := GetProcAddress(hDLL,'mysql_real_query');
    @mysql_shutdown        := GetProcAddress(hDLL,'mysql_shutdown');
    @mysql_refresh         := GetProcAddress(hDLL,'mysql_refresh');
    @mysql_kill            := GetProcAddress(hDLL,'mysql_kill');
    @mysql_ping            := GetProcAddress(hDLL,'mysql_ping');
    @mysql_stat            := GetProcAddress(hDLL,'mysql_stat');
    @mysql_options         := GetProcAddress(hDLL,'mysql_options');
    @mysql_escape_string   := GetProcAddress(hDLL,'mysql_escape_string');
    @mysql_get_server_info := GetProcAddress(hDLL,'mysql_get_server_info');
    @mysql_get_client_info := GetProcAddress(hDLL,'mysql_get_client_info');
    @mysql_get_host_info   := GetProcAddress(hDLL,'mysql_get_host_info');
    @mysql_get_proto_info  := GetProcAddress(hDLL,'mysql_get_proto_info');
    @mysql_list_fields     := GetProcAddress(hDLL,'mysql_list_fields');
    @mysql_list_processes  := GetProcAddress(hDLL,'mysql_list_processes');
    @mysql_list_dbs        := GetProcAddress(hDLL,'mysql_list_dbs');
    @mysql_list_tables     := GetProcAddress(hDLL,'mysql_list_tables');
    @mysql_data_seek       := GetProcAddress(hDLL,'mysql_data_seek');
    @mysql_row_seek        := GetProcAddress(hDLL,'mysql_row_seek');
    @mysql_field_seek      := GetProcAddress(hDLL,'mysql_field_seek');
    @mysql_fetch_row       := GetProcAddress(hDLL,'mysql_fetch_row');
    @mysql_fetch_lengths   := GetProcAddress(hDLL,'mysql_fetch_lengths');
    @mysql_fetch_field     := GetProcAddress(hDLL,'mysql_fetch_field');
    @mysql_use_result      := GetProcAddress(hDLL,'mysql_use_result');
    @mysql_store_result    := GetProcAddress(hDLL,'mysql_store_result');
    @mysql_free_result     := GetProcAddress(hDLL,'mysql_free_result');
    @mysql_thread_id       := GetProcAddress(hDLL,'mysql_thread_id');
    //EOZEOS//
    //So far ZEOS, but we have some more library functions!
    //Added by artee@dubaron.com:
    @mysql_insert_id       := GetProcAddress(hDLL, 'mysql_insert_id');
    @mysql_fetch_fields    := GetProcAddress(hDLL, 'mysql_fetch_fields');
    @mysql_num_fields      := GetProcAddress(hDLL, 'mysql_num_fields');
    //EOArTee

    //ZEOS:
    Result := True;
  end else
    raise Exception.Create(Format('Library %s not found',[DLL]));
end;
//So far ZEOS

constructor TMyDB.Create;
begin
  FLibrary:=DEFAULT_DLL_LOCATION;
  DLL:=FLibrary;
  FHost:='localhost';
  FPort:=MY_DEFAULT_PORT;
  FActive:=False;
  ActivateOnLoad:=False;
  FFieldNames:=TStringList.Create;
  FRealConnect:=False;
  FConnectOptions:=_CLIENT_COMPRESS or _CLIENT_CONNECT_WITH_DB;
  inherited;
end;

procedure TMyDB.Loaded;
begin
  inherited;
  if ActivateOnLoad then
    SetActive(True);
end;

procedure TMyDB.Close;
begin
  try
    mysql_close(@MyHandle);
  except
    raise Exception.Create('An error occured while closing');
  end;
  FActive:=False;
  if Assigned(FOnClose) then
    FOnClose(Self);
end;

procedure TMyDB.Connect;
begin
  //Allow user to change shared library
  if FLibrary<>'' then
    DLL:=FLibrary;
  if (hDLL=0) and not MySQLLoadLib then exit;
  //Succesfully loaded
  if FActive then Close;  //Close if already active

  mysql_init(@MyHandle);  //backward compatability??
//  if MyHandle=nil then
//    exit;
  if FRealConnect then
    try
      PMyHandle:= mysql_real_connect(@MyHandle, PChar(String(Host)), PChar(String(User)), PChar(String(Pass)),
                 PChar(String(FDataBase)), FPort, nil {PChar(String(FUnixSock))}, 0{ FConnectOptions});
      FActive := PMyHandle<>nil;
    except
      FActive:=False;
    end
  else
    begin
      PMyHandle:=mysql_connect(@MyHandle, PChar(Host), PChar(User), PChar(Pass));
      FActive := PMyHandle<>nil;
      //Select database if assigned:
      if FActive and (FDataBase<>'') then
        mysql_select_db(@MyHandle, PChar(FDataBase));
    end;

  //Don't know why, but hangs if in componentstate:
  if FActive and not (csDesigning in ComponentState) then
    begin
      //Fill in some variables:
      //If compiled with wrong version, the MYSQL type may be wrong,
      //Therefore an try-except:
      try
      //It's too risky. i go figure out what's happening.
//        FServerVersion:=MyHandle.server_version;
//        FCharSet:=MyHandle.charset;
//        FHostInfo:=MyHandle.host_info;
//        FInfo:=MyHandle.info;
      except
        //Wrong DLL. Adjust compiler switches of unit MyDB.;
      end;
    end;
  if FActive and Assigned(FOnOpen) then
    FOnOpen(Self);
end;

procedure TMyDB.SetActive;
begin
  {
  if (csLoading in ComponentState) and
     not (csDesigning in ComponentState) then
    begin
      ActivateOnLoad:=DBActive;
      exit;
    end;}
  if DBActive and not FActive then
    Connect(FHost, FUser, FPass);
  if FActive and not DBActive then
    Close;
end;

procedure TMyDB.CreateDatabase;
begin
  if FActive then
    mysql_create_db(@MyHandle, PChar(Database));
end;

procedure TMyDB.DropDatabase;
begin
  if FActive then
    mysql_drop_db(@MyHandle, PChar(Database));
  FDatabase:='';
end;

procedure TMyDB.SelectDatabase;
begin
  if FActive then
    mysql_select_db(@MyHandle, PChar(Database));
  FDatabase:=Database;
end;

procedure TMyDB.Kill(Pid:Integer);
begin
  if FActive then
    mysql_kill(@MyHandle, Pid);
end;

function TMyDB.Ping;
begin
  Result:=False;
  if FActive then
    Result:=(mysql_ping(@MyHandle)<>0);
end;

procedure TMyDB.ShutDown;
begin
  if FActive then
    mysql_shutdown(@MyHandle);
end;

procedure TMyDB.StoreResult;
var i,j:Integer;
    row:mysql_row;
    fields:mysql_fields;
    TotMem:Integer;
begin
  FHasResult:=False;
  if Res<>nil then
    begin
      FHasResult:=True;
      //fetch rows
      SetLength (FQueryResult, Integer(res^.row_count));
      SetLength (FExtQueryResult, Integer(res^.row_count));
      TotMem:=0;
      for i:=0 to res^.row_count-1 do
        begin
          row:=mysql_fetch_row(res)^;
          SetLength (FQueryResult[i], res^.field_count);
          SetLength (FExtQueryResult[i], res^.field_count);
          for j:=0 to res^.field_count-1 do
            begin
              if row[j]=nil then
                FExtQueryResult[i,j].IsNull :=True;
              FQueryResult[i,j]:=row[j];
              TotMem:=4+length(FQueryResult[i,j]);
            end;
          //Check ranges; break if rowlimit or memory limit reached:
          if ((FFetchRowLimit<>0) and ((i+1)>=FFetchRowLimit)) or
             ((FFetchMemoryLimit<>0) and (TotMem>=FFetchMemoryLimit)) then
            break;
        end;

      //Convert to trivial types:
      if high(FQueryResult)>=0 then
        FResultAsString:=FQueryResult[0][0];

      //definitely not optimized for speed/memory use (ToDo):
      //ToDo = Only create text/html on property request...
      //However code is here now, it'll take 2 times more memory than necessary:
      FResultAsText:='';
      FResultAsHTML:='<TABLE>';
      for i:=0 to high(FQueryResult) do
        begin
          FResultAsText:=FResultAsText+FQueryResult[i][0];
          FResultAsHTML:=FResultAsHTML+'<TR>'+FQueryResult[i][0];
          for j:=1 to high(FQueryResult[0]) do
            begin
              FResultAsText:=FResultAsText+#9+FQueryResult[i][j];
              FResultAsHTML:=FResultAsHTML+'<TD>'+FQueryResult[i][j]+'</TD>';
            end;
          FResultAsText:=FResultAsText+#13+#10;
          FResultAsHTML:=FResultAsHTML+#13+#10;
        end;
      FResultAsHTML:=FResultAsHTML+'</TABLE>'+#13+#10;

      //Fetch field names
      FFieldNames.Clear;
      SetLength (FFields, mysql_num_fields(res));
      fields:=mysql_fetch_fields(res)^;
      for i:=0 to mysql_num_fields(res)-1 do
        begin
          FFieldNames.Add(fields[i].Name);
          with FFields[i] do begin
            //Copy data mainly for PChar/String converting
            //Makes field info available after resource handle is closed!
            name:=fields[i].name;
            table:=fields[i].table;
            def:=fields[i].def;
            _type:=fields[i]._type;
            length:=fields[i].length;
            max_length:=fields[i].max_length;
            flags:=fields[i].flags;
            decimals:=fields[i].decimals;
          end;
        end;
      //Some more vars:
      FNumFields:=mysql_num_fields(res);
      FRowsAffected:=MyHandle.affected_rows;
      FLastInsertID:=MyHandle.insert_id;
      mysql_free_result(res);
      FHasResult:=True;
      if Assigned (OnSuccess) then
        OnSuccess(Self);
    end
  else //Invalid Result
    begin
      SetLength (FQueryResult, 0);
      FResultAsString:='';
      FResultAsText:='';
      FResultAsHTML:='';
      FNumFields:=0;
      FRowsAffected:=-1;
      FLastInsertID:=-1;
      FFieldNames.Clear;
      FHasResult:=False;
      if Assigned (OnError) then
        OnError (Self);
    end;
end;

procedure TMyDB.Query;
begin
  if not FActive then
    SetActive(True); //Try once if client just performs query

  if FActive then
    begin
      //Allow user to view or edit query:
      FSQL:=SQL;
      if Assigned (OnBeforeQuery) then
        OnBeforeQuery(Self);
      SQL:=FSQL;

      //Perform actual query:
      if 0=mysql_query(@MyHandle, PChar(SQL)) then
        begin
          StoreResult(mysql_store_result(@MyHandle));
        end
      else
        begin
          //StoreResult is able to handle errors and will call OnError as well
          //Calling it with nill forces a result cleanup:
          StoreResult(nil);
        end;
    end;
end;

procedure TMyDB.ListDatabases;
begin
  if FActive then
    StoreResult(mysql_list_dbs(@MyHandle, PChar(wildcard)));
end;

procedure TMyDB.ListTables;
begin
  if FActive then
    StoreResult(mysql_list_tables(@MyHandle, PChar(wildcard)));
end;

procedure TMyDB.ListProcesses;
begin
  if FActive then
    StoreResult(mysql_list_processes(@MyHandle));
end;

procedure TMyDB.ListFields;
begin
  if FActive then
    StoreResult(mysql_list_fields(@MyHandle, PChar(table), PChar(wildcard)));
end;

function TMyDB.GetServerInfo;
begin
  if FActive then
    Result:=mysql_get_server_info(@MyHandle)
  else
    Result:='Inactive';
end;

procedure TMyDB.SetPort;
begin
  if (Port<=0) or (Port>65535) then //Simply don't accept value
    exit;
  if Port<>MY_DEFAULT_PORT then //Force real connect:
    FRealConnect:=True;
  FPort:=Port;
end;

procedure TMyDB.SetRealConnect;
begin
  if not DoRealConnect then //Only connect to default port:
    FPort:=MY_DEFAULT_PORT;
  FRealConnect:=DoRealConnect;
end;

function TMyDB.GetLastError;
//var B:array[01..MYSQL_ERRMSG_SIZE] of Char;
begin

  if FActive then
    begin
      SetLength(Result, 200);
      Result:=myhandle._net.last_error;
    end;
end;


procedure Register;
begin
  RegisterComponents('Kylix_OE', [TMyDB]);
end;


initialization

finalization
  if (hDLL <> 0) and LibLoaded then
    FreeLibrary(hDLL);
end.
