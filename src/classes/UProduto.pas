unit UProduto;

interface
uses
  UId, System.SysUtils;

type
  TProduto = class(TId)
  private
    FDescricao: String;
    FPrecoVenda: Double;
    procedure SetDescricao(const Value: String);
    procedure SetPrecoVenda(const Value: Double);

  public
    property Descricao:String read FDescricao write SetDescricao;
    property PrecoVenda:Double read FPrecoVenda write SetPrecoVenda;
    procedure validar();

    Constructor Create(); overload;
    Constructor Create(AID: Integer); overload;
    Constructor Create(AID: Integer; ADescricao: String; APrecoVenda: Double); overload;

  end;

implementation

uses
  UConsts;

{ TProduto }

constructor TProduto.Create(AID: Integer);
begin
  Self.Create;
  Self.Id := AID;
end;

constructor TProduto.Create(AID: Integer; ADescricao: String;
  APrecoVenda: Double);
begin
  Self.Create(AID);
  Self.Descricao := ADescricao;
  Self.PrecoVenda := APrecoVenda;
end;

constructor TProduto.Create;
begin
  Self.Id := 0;
  Self.Descricao := '';
  Self.PrecoVenda := 0;
end;

procedure TProduto.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TProduto.SetPrecoVenda(const Value: Double);
begin
  FPrecoVenda := Value;
end;

procedure TProduto.validar;
begin
  if Self.Descricao = '' then
    raise Exception.Create(Format(msgCampoRequerido, ['Descrição']));

  if Self.PrecoVenda <= 0 then
    raise Exception.Create(Format(msgCampoRequerido, ['Preço de venda']));


end;

end.
