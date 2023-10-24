unit UDAOPessoa;

interface

uses
 UDAOBase, UPessoa, System.SysUtils, Data.DB, UConsts;

type
  TDAOPessoa = class(TDAOBase)

  private
    FPersistentObject: TPessoa;
    procedure SetPersistentObject(const Value: TPessoa);

  public
    property PeristentObject: TPessoa read FPersistentObject write SetPersistentObject;
    function Save(): Boolean; override;
    function Load(AId: Integer): Boolean;
    procedure SetDataClass; override;

    Constructor Create(); overload;
    Constructor Create(AId: Integer); overload;
    Constructor Create(AObject: TPessoa); overload;
  end;

implementation

{ TDAOPessoa }

constructor TDAOPessoa.Create(AObject: TPessoa);
begin
  Self.Create;
  Self.FPersistentObject := AObject;
  Self.Load(Self.FPersistentObject.Id);
end;

constructor TDAOPessoa.Create;
begin
  Self.Table := 'pessoa';
  Self.FieldKey := 'idpessoa';
end;

constructor TDAOPessoa.Create(AId: Integer);
begin
  Self.Create;
  if AId > 0 then
  begin
    Self.FPersistentObject := TPessoa.Create;
    Self.Load(AId);
  end;
end;

function TDAOPessoa.Load(AId: Integer): Boolean;
begin
  Self.GetQueryLoad(IntToStr(AId));
  Self.SetDataClass;
  Result := not self.GetQuery.IsEmpty;
end;

function TDAOPessoa.Save: Boolean;
begin
  inherited;
  self.getValue('nome').Value := self.FPersistentObject.Nome;
  self.getValue('cpfcnpj').Value := self.FPersistentObject.CPFCNPJ;
  self.getValue('tipoentidade').Value := Integer(self.FPersistentObject.TipoEntidade);
  self.GetQuery.Post;
  self.GetQuery.ApplyUpdates();
  Result := true;
end;

procedure TDAOPessoa.SetDataClass;
begin
  inherited;
  if not self.GetQuery.IsEmpty then
  begin
    self.FPersistentObject.Id := self.getValue('idpessoa').AsInteger;
    self.FPersistentObject.Nome := self.getValue('nome').AsString;
    self.FPersistentObject.CPFCNPJ := self.getValue('cpfcnpj').AsString;
    self.FPersistentObject.TipoEntidade := TEnumEntidadePessoa(self.getValue('tipoentidade').AsInteger);
  end;
end;

procedure TDAOPessoa.SetPersistentObject(const Value: TPessoa);
begin
  FPersistentObject := Value;
end;

end.
