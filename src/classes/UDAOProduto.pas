unit UDAOProduto;

interface

uses
  UDAOBase, UProduto, System.SysUtils, Data.DB;

type
  TDAOProduto = class(TDAOBase)

  private
    FPersistentObject: TProduto;
    procedure SetPersistentObject(const Value: TProduto);

  public
    property PersistentObject: TProduto read FPersistentObject write SetPersistentObject;
    procedure SetDataClass; override;
    function Save(): Boolean; override;
    function Load(AId: Integer): Boolean;
    Constructor Create(); overload;
    Constructor Create(AObject: TProduto); overload;
    Constructor Create(AId: Integer); overload;

  end;

implementation

{ TDAOProduto }

constructor TDAOProduto.Create(AObject: TProduto);
begin
  Self.Create();
  Self.FPersistentObject := AObject;
  if Self.FPersistentObject.Id > 0 then
    Self.Load(Self.FPersistentObject.Id);
end;

constructor TDAOProduto.Create(AId: Integer);
begin
  Self.Create();
  if AId > 0 then
  begin
    Self.FPersistentObject := TProduto.Create;
    Self.Load(AId);
  end;
end;

constructor TDAOProduto.Create;
begin
  Self.Table := 'produto';
  Self.FieldKey := 'idproduto';
end;

function TDAOProduto.Load(AId: Integer): Boolean;
begin
  Self.GetQueryLoad(IntToStr(AId));
  Self.SetDataClass;
  Result := not self.GetQuery.IsEmpty;
end;

function TDAOProduto.Save: Boolean;
begin
  inherited;
  self.getValue('descricao').Value := self.FPersistentObject.Descricao;
  self.getValue('precovenda').Value := self.FPersistentObject.PrecoVenda;
  self.GetQuery.Post;
  self.GetQuery.ApplyUpdates();
  Result := True;
end;

procedure TDAOProduto.SetDataClass;
begin
  inherited;
  self.FPersistentObject.Id := self.getValue('idproduto').AsInteger;
  self.FPersistentObject.Descricao := self.getValue('descricao').AsString;
  self.FPersistentObject.PrecoVenda := self.getValue('precovenda').AsFloat;
end;

procedure TDAOProduto.SetPersistentObject(const Value: TProduto);
begin
  FPersistentObject := Value;
end;

end.
