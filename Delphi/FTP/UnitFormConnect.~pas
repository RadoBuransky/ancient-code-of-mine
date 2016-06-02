unit UnitFormConnect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, NMFtp;

type
  TFormConnect = class(TForm)
    Label1: TLabel;
    EditHost: TEdit;
    Label2: TLabel;
    EditPort: TEdit;
    Label3: TLabel;
    EditUserName: TEdit;
    Label4: TLabel;
    EditPassword: TEdit;
    ButtonGO: TButton;
    ButtonCancel: TButton;
    EditTimeOut: TEdit;
    Label5: TLabel;
    procedure ButtonGOClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
  private
    { Private declarations }
    NMFTP : TNMFTP;

    procedure AuthenticationFailed( var Handled : boolean );
    procedure ConnectionFailed( Sender : TObject );
  public
    { Public declarations }

    procedure MyShowModal( iNMFTP : TNMFTP );
  end;

var
  FormConnect: TFormConnect;

implementation

uses ScktComp;

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                  Events
//
//==============================================================================
//==============================================================================

procedure TFormConnect.AuthenticationFailed( var Handled : boolean );
begin
  MessageDlg( 'Nespr·vne meno uûÌvateæa alebo jeho heslo!' , mtError , [mbOK] , 0 );
  Handled := True;
end;

procedure TFormConnect.ConnectionFailed( Sender : TObject );
begin
  MessageDlg( 'Ned· sa naviazaù spojenie so serverom!' , mtError , [mbOK] , 0 );
  Close;
end;

//==============================================================================
//==============================================================================
//
//                                Inicializ·cia
//
//==============================================================================
//==============================================================================

procedure TFormConnect.MyShowModal( iNMFTP : TNMFTP );
begin
  NMFTP := iNMFTP;
  NMFTP.OnAuthenticationFailed := AuthenticationFailed;
  NMFTP.OnConnectionFailed := ConnectionFailed;

  ButtonGO.Enabled := True;
  Cursor := crDefault;

  inherited ShowModal;
end;

//==============================================================================
//==============================================================================
//
//                                     GO!
//
//==============================================================================
//==============================================================================

procedure TFormConnect.ButtonGOClick(Sender: TObject);
begin
  if (EditHost.Text = '') or
     (EditUserName.Text = '') or
     (EditPassword.Text = '') or
     (EditPort.Text = '') or
     (EditTimeOut.Text = '') then
       begin
         MessageDlg( 'Nezadali ste vöetky vstupnÈ ˙daje!' , mtError , [mbOK] , 0 );
         exit;
       end;

  with NMFTP do
    begin
      Host := EditHost.Text;
      UserID := EditUserName.Text;
      Password := EditPassword.Text;
      try
        Port := StrToInt( EditPort.Text );
      except
        on EConvertError do
          begin
            MessageDlg( 'Nespr·vne ËÌslo portu (odpor˙Ëa sa 21)!' , mtError , [mbOK] , 0 );
            exit;
          end;
      end;

      try
        TimeOut := StrToInt( EditTimeOut.Text );
      except
        on EConvertError do
          begin
            MessageDlg( 'Nespr·vny timeout (odpor˙Ëa sa 5000)!' , mtError , [mbOK] , 0 );
            exit;
          end;
      end;

      Self.ButtonGO.Enabled := False;
      Self.Cursor := crHourGlass;
      try
        Connect;
      finally
        Self.Close;
      end;
    end;
end;

procedure TFormConnect.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

end.
