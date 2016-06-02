unit ClassMyListView;

interface

uses ComCtrls, Classes;

type TMyListView = class( TListView )
     private
       procedure FOnColumnClick( Sender: TObject; Column: TListColumn );
     public
       constructor Create( AOwner : TComponent ); override;
     end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents( 'Standard' , [TMyListView] );
end;

procedure TMyListView.FOnColumnClick( Sender: TObject; Column: TListColumn );
begin
  
end;

constructor TMyListView.Create( AOwner : TComponent );
begin
  OnColumnClick := FOnColumnClick;
end;

end.
