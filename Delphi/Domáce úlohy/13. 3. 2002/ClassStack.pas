unit ClassStack;

interface

type

//==============================================================================
// TStackItem class
//==============================================================================

     TStackItem = class
     private
       FEnglish : string;
       FSlovak  : string;
       FNext    : TStackItem;

     public
       constructor Create( English, Slovak : string; Next : TStackItem );
       destructor  Destroy; override;

       property    English : string  read FEnglish;
       property    Slovak : string   read FSlovak;
       property    Next : TStackItem read FNext write FNext;
     end;

//==============================================================================
// TStack class
//==============================================================================

     TStack = class
     private
       First     : TStackItem;
       Last      : TStackItem;

       procedure   FreeStack;
       
     public
       constructor Create;
       destructor  Destroy; override;

       procedure   Push( NewItem : TStackItem );
       function    Pop : TStackItem;
     end;

implementation

//==============================================================================
//==============================================================================
//
// TStackItem class
//
//==============================================================================
//==============================================================================

constructor TStackItem.Create( English, Slovak : string; Next : TStackItem );
begin
  inherited Create;

  FEnglish := English;
  FSlovak  := Slovak;
  FNext    := Next;
end;

destructor TStackItem.Destroy;
begin
  inherited;
end;

//==============================================================================
//==============================================================================
//
// TStack class
//
//==============================================================================
//==============================================================================

constructor TStack.Create;
begin
  inherited;

  First := nil;
  Last  := nil;
end;

destructor TStack.Destroy;
begin
  FreeStack;

  inherited;
end;

//==============================================================================
// P R I V A T E
//==============================================================================

procedure TStack.FreeStack;
var S : TStackItem;
begin
  while (First <> nil) do
    begin
      S := First.Next;
      First.Free;
      First := S;
    end;
end;

//==============================================================================
// P U B L I C
//==============================================================================

procedure TStack.Push( NewItem : TStackItem );
var S, Before : TStackItem;
begin
  Before := nil;
  S      := First;

  if (S = nil) then
    begin
      First := NewItem;
      Last  := NewItem;
    end
  else
    begin
      repeat
        if (NewItem.English < S.English) then
          begin
            if (S = First) then
              begin
                First      := NewItem;
                First.Next := S;
              end
            else
              begin
                Before.Next  := NewItem;
                NewItem.Next := S;
              end;
            exit;
          end;

        Before := S;
        S      := S.Next;
      until (S = nil);

      Last.Next := NewItem;
      Last      := NewItem;
    end;
end;

function TStack.Pop : TStackItem;
begin
  Result := First;

  if (First <> nil) then
    begin
      First := First.Next;
      if (First = nil) then
        Last := nil;
    end;
end;

end.
