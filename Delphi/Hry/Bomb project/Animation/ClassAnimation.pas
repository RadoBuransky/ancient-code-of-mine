unit ClassAnimation;

interface

uses ExtCtrls;

type TAnimation = class
     public
       constructor Create( iImage : TImage; iPath : string );
       destructor Destroy; override;
     end;

var Animation : TAnimation;

implementation

//==============================================================================
//==============================================================================
//
//                                 Constructor
//
//==============================================================================
//==============================================================================

constructor TAnimation.Create( iImage : TImage; iPath : string );
begin
  inherited Create;
end;

//==============================================================================
//==============================================================================
//
//                                  Destructor
//
//==============================================================================
//==============================================================================

destructor TAnimation.Destroy;
begin
  inherited;
end;

end.
