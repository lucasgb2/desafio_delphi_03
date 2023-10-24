unit UPedidoCompra;

interface

uses
  UId, UPessoa, System.Contnrs;

type
  TNegociacaoCompra = class(TId)
  private
    FDistribuidor: TPessoa;
    FProdutor: TPessoa;
    FProdutos: TObjectList;
    procedure SetDistribuidor(const Value: TPessoa);
    procedure SetProdutor(const Value: TPessoa);
    procedure SetProdutos(const Value: TObjectList);

  public
    property Produtor: TPessoa read FProdutor write SetProdutor;
    property Distribuidor: TPessoa read FDistribuidor write SetDistribuidor;
    property Produtos: TObjectList read FProdutos write SetProdutos;


    Constructor Create();
  end;

implementation



{ TPedidoCompra }

constructor TNegociacaoCompra.Create;
begin

end;

procedure TNegociacaoCompra.SetDistribuidor(const Value: TPessoa);
begin
  FDistribuidor := Value;
end;

procedure TNegociacaoCompra.SetProdutor(const Value: TPessoa);
begin
  FProdutor := Value;
end;

procedure TNegociacaoCompra.SetProdutos(const Value: TObjectList);
begin
  FProdutos := Value;
end;

end.
