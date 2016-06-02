unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ClassDBF;

type
  THlavneOkno = class(TForm)
    MainMenu: TMainMenu;
    MainSubor: TMenuItem;
    SuborOtvorit: TMenuItem;
    SuborKoniec: TMenuItem;
    OpenDialog: TOpenDialog;
    Memo: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HlavneOkno: THlavneOkno;
  DBF : Tdbf;

implementation

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                 Constructor
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.FormCreate(Sender: TObject);
var I : integer;
    FldDesc : TFldDesc;
begin
  DBF := TDBf.Create( 'fakodb.dbf' );

  Memo.Clear;
  with Memo.Lines do
    begin
      Add( 'H E A D E R :' );
      Add( '=============' );
      Add( '' );

      case DBF.Header.Compatibility of
        $03 : Add( 'Compatibility : plain' );
        $04 : Add( 'Compatibility : plain' );
        $05 : Add( 'Compatibility : plain' );
        $43 : Add( 'Compatibility : with .dbv memo variable size' );
        $B3 : Add( 'Compatibility : with .dbv and .dbt memo' );
        $83 : Add( 'Compatibility : with .dbt memo' );
        $8B : Add( 'Compatibility : with .dbt memo in dBase IV. format' );
        $8E : Add( 'Compatibility : with SQL table' );
        $F5 : Add( 'Compatibility : with .fmp memo' );
      end;
      Add( 'Last update : ' + IntToStr( DBF.Header.Den ) +
           '.' + IntToStr( DBF.Header.Mesiac ) +
           '.' + IntToStr( DBF.Header.Rok ));
      Add( 'Number of records : ' + IntToStr( DBF.Header.Records ) );
      Add( 'Header size : ' + IntToStr( DBF.Header.HeaderSize ) );
      Add( 'Record size : ' + IntToStr( DBF.Header.RecordSize ) );
      case DBF.Header.Transaction of
        $01 : Add( 'Transaction : begin trasaction' );
        $00 : Add( 'Transaction : ignored' );
      end;
      case DBF.Header.Encryption of
        $01 : Add( 'Encryption : encrypted' );
        $00 : Add( 'Encryption : normal visible' );
      end;
      case DBF.Header.LanguageDriver of
        $01 : Add( 'Language ID : codepage 437 DOS USA' );
        $02 : Add( 'Language ID : codepage 850 DOS Multilingual' );
        $03 : Add( 'Language ID : codepage 1251 Windows ANSI' );
        $C8 : Add( 'Language ID : codepage 1250 Windows EE' );
        $00 : Add( 'Language ID : ignored' );
      end;
      Add( '' );

      Add( 'F I E L D   D E S C R I P T O R S :' );
      Add( '===================================' );
      for I := 0 to DBF.Header.FldDescs.Count-1 do
        begin
          FldDesc := TFldDesc( DBF.Header.FldDescs[I]^ );
          Add( '' );
          Add( '   ' + IntToStr( I+1 ) + '. ' + FldDesc.FldName );
          case FldDesc.FldType of
            'C' : Add( '   Field type : char' );
            'D' : Add( '   Field type : date' );
            'N' : Add( '   Field type : numeric' );
          end;
          Add( '   Filed offset from record begin : ' + IntToStr( FldDesc.FldAddr ) );
          Add( '   Filed length : ' + IntToStr( FldDesc.FldLength ) );
          Add( '' );
        end;
    end;

  for I := 1 to 2 do
    Memo.Lines.Add( DBF.Cells( I , 2 ) );

  DBF.Free;
end;

//==============================================================================
//==============================================================================
//
//                                 Destructor
//
//==============================================================================
//==============================================================================

//==============================================================================
//==============================================================================
//
//                                 Main menu
//
//==============================================================================
//==============================================================================

end.
