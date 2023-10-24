unit UNegociacao;

interface

uses
  UId, UPessoa, System.Generics.Collections, UConsts, UProduto, Math, System.SysUtils;

type
  TNegociacaoItem = class(TID)
  private
    FProduto: TProduto;
    FQuantidade: Double;
    FPreco: Double;
    procedure SetProduto(const Value: TProduto);
    procedure SetQuantidade(const Value: Double);
    procedure SetPreco(const Value: Double);

  public
    property Produto:TProduto read FProduto write SetProduto;
    property Quantidade:Double read FQuantidade write SetQuantidade;
    property Preco:Double read FPreco write SetPreco;
    Constructor Create(AProduto: TProduto; AQuantidade: Double; APreco: Double); overload;
    Constructor Create(AIDItem: Integer; AProduto: TProduto; AQuantidade: Double; APreco: Double); overload;
    Destructor Destroy(); override;
  end;


type
  TNegociacao = class(TId)
  private
    FDistribuidor: TPessoa;
    FProdutor: TPessoa;
    FSituacao: TEnumSituacaoNegociacao;
    FItems: TObjectList<TNegociacaoItem>;
    FItemsIsModificado: Boolean;
    FDataSituacao: TDateTime;
    FDataInclusao: TDateTime;
    procedure SetDistribuidor(const Value: TPessoa);
    procedure SetProdutor(const Value: TPessoa);
    procedure SetSituacao(const Value: TEnumSituacaoNegociacao);
    procedure SetItems(const Value: TObjectList<TNegociacaoItem>);
    function getTotalNegociacao: Double;
    procedure SetDataInclusao(const Value: TDateTime);
    procedure SetDataSituacao(const Value: TDateTime);

  public
    property ItemsIsModificado: Boolean read FItemsIsModificado write FItemsIsModificado;
    property Produtor: TPessoa read FProdutor write SetProdutor;
    property Distribuidor: TPessoa read FDistribuidor write SetDistribuidor;
    property Situacao: TEnumSituacaoNegociacao read FSituacao write SetSituacao;
    property Items: TObjectList<TNegociacaoItem> read FItems write SetItems;
    property DataInclusao: TDateTime read FDataInclusao write SetDataInclusao;
    property DataSituacao: TDateTime read FDataSituacao write SetDataSituacao;
    function Validar(ASaldoProdutor: Double):Boolean;
    function ValidarLimiteCredito(ASaldoProdutor: Double): Boolean;

    Constructor Create();
    Destructor Destroy(); override;
  end;

implementation



{ TPedidoCompra }

constructor TNegociacao.Create;
begin
  FProdutor := TPessoa.Create;
  FDistribuidor := TPessoa.Create;
  FSituacao := TEnumSituacaoNegociacao.negPendente;
  FItems := TObjectList<TNegociacaoItem>.Create;
  FItemsIsModificado := False;
  FDataSituacao := nullDate;
  FDataInclusao := nullDate;
end;

destructor TNegociacao.Destroy;
begin
  TUtils.FreeObject(FItems);
  TUtils.FreeObject(FProdutor);
  TUtils.FreeObject(FDistribuidor);
  inherited;
end;

function TNegociacao.getTotalNegociacao: Double;
var
  item: TNegociacaoItem;
begin
  Result:= 0;
  for item in Self.Items do
    Result := Result + RoundTo(item.Quantidade * item.Preco, -2);
end;

procedure TNegociacao.SetDataInclusao(const Value: TDateTime);
begin
  FDataInclusao := Value;
end;

procedure TNegociacao.SetDataSituacao(const Value: TDateTime);
begin
  FDataSituacao := Value;
end;

procedure TNegociacao.SetDistribuidor(const Value: TPessoa);
begin
  FDistribuidor := Value;
end;

procedure TNegociacao.SetItems(const Value: TObjectList<TNegociacaoItem>);
begin
  FItems := Value;
end;

procedure TNegociacao.SetProdutor(const Value: TPessoa);
begin
  FProdutor := Value;
end;

procedure TNegociacao.SetSituacao(const Value: TEnumSituacaoNegociacao);
begin
  FSituacao := Value;
end;

function TNegociacao.Validar(ASaldoProdutor: Double): Boolean;
begin
  if (Self.Distribuidor = nil) or ((Self.Distribuidor <> nil) and (Self.Distribuidor.Id <= 0)) then
    raise Exception.Create(Format(msgCampoRequerido, ['Distribuidor']));

  if (Self.Produtor = nil) or ((Self.Produtor <> nil) and (Self.Produtor.Id <= 0)) then
    raise Exception.Create(Format(msgCampoRequerido, ['Produtor']));

  if (Self.Items.Count <= 0) then
    raise Exception.Create(Format(msgCampoRequerido, ['Produtos']));

  Result := Self.ValidarLimiteCredito(ASaldoProdutor);
end;

function TNegociacao.ValidarLimiteCredito(ASaldoProdutor: Double): Boolean;
begin
  if (ASaldoProdutor < Self.getTotalNegociacao) then
    raise Exception.Create(Format(msgLimiteCreditoProdutorInsuficiente, [formatFloat('#,##0.00', ASaldoProdutor)]));
  Result := True;
end;

{ TNegociacaoItems }

constructor TNegociacaoItem.Create(AIDItem: Integer; AProduto: TProduto; AQuantidade: Double; APreco: Double);
begin
  Self.Id := AIDItem;
  Self.Create(AProduto, AQuantidade, APreco);
end;

destructor TNegociacaoItem.Destroy;
begin
  TUtils.FreeObject(FProduto);
  inherited;
end;

constructor TNegociacaoItem.Create(AProduto: TProduto; AQuantidade: Double; APreco: Double);
begin
  Self.FProduto := AProduto;
  Self.FQuantidade := AQuantidade;
  Self.FPreco := APreco;
end;

procedure TNegociacaoItem.SetPreco(const Value: Double);
begin
  FPreco := Value;
end;

procedure TNegociacaoItem.SetProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TNegociacaoItem.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

end.
