unit UId;

interface

type
  TId = class
  private
    FId: Integer;
    procedure SetId(const Value: Integer);

  public
    property Id:Integer read FId write SetId;

    Constructor Create(); overload;
    Constructor Create(AId: Integer); overload;
  end;

implementation

{ TId }

constructor TId.Create;
begin
  Self.Id := -1;
end;

constructor TId.Create(AId: Integer);
begin
  Self.Create;
  FId := AId;
end;

procedure TId.SetId(const Value: Integer);
begin
  FId := Value;
end;

end.
