unit UNegociacaoController;

interface

uses
  UDAONegociacao, UDAOSituacaoNegociacao, USituacaoNegociacao, UPessoaController,
  UConsts, UProdutoController, System.Classes, Data.DB, UNegociacao, Sysutils;

type
  TNegociacaoController = class

  private
    FDAONegociacao: TDAONegociacao;
    FDAOSituacaoNegociacao: TDAOSituacaoNegociacao;
    FNegociacao: TNegociacao;
    FDistribuidorController: TPessoaController;
    FProdutorController: TPessoaController;
    FSituacaoNegociacao: TSituacaoNegociacao;
    FProdutoController: TProdutoController;

  public
    function getDAONegociacao: TDAONegociacao;
    function getDAOSituacaoNegociacao: TDAOSituacaoNegociacao;
    function getDistribuidorController: TPessoaController;
    function getProdutorController: TPessoaController;
    function getProdutoController: TProdutoController;
    function getDataSetNegociacoes: TDataSet;
    function getNegociacao: TNegociacao;
    procedure PopulateStringsSituacaoNegociacao(const AStrings:TStrings; ATodos: Boolean = True);
    procedure AlterarSituacaoNegociacao(AId: Integer; ASituacao:TEnumSituacaoNegociacao);
    function Delete(AIdNegociacao: Integer): Boolean;

    Destructor Destroy; override;
  end;

implementation


{ TNegociacaoController }

procedure TNegociacaoController.AlterarSituacaoNegociacao(AId: Integer;
  ASituacao:TEnumSituacaoNegociacao);
var
  saldo : Double;
  validacaoOk: Boolean;
begin
  //Se for aprovar valida-se o limite de crédito.
  validacaoOk := True;
  Self.getDAONegociacao.Load(AId);
  saldo := Self.getDAONegociacao.getSaldoLimiteCreditoPessoa(self.getNegociacao.Distribuidor.Id, self.getNegociacao.Produtor.Id);
  if (ASituacao = TEnumSituacaoNegociacao.negAprovado) then
    validacaoOk := Self.getNegociacao.ValidarLimiteCredito(saldo);

  if validacaoOk then
  begin
    if self.getDAONegociacao.Load(AId) then
    begin
      self.getNegociacao.Situacao := ASituacao;
      self.getNegociacao.DataSituacao := now();
      self.getDAONegociacao.Save;
    end;
  end;
end;

function TNegociacaoController.Delete(AIdNegociacao: Integer):Boolean;
begin
  Result:= False;
  if self.getDAONegociacao.Load(AIdNegociacao) then
  begin
    Self.getDAONegociacao.Delete;
    Result:= true;
  end;
end;

destructor TNegociacaoController.Destroy;
begin
  TUtils.FreeObject(FDistribuidorController);
  TUtils.FreeObject(FDAONegociacao);
  TUtils.FreeObject(FProdutorController);
  TUtils.FreeObject(FDAOSituacaoNegociacao);
  TUtils.FreeObject(FNegociacao);
  inherited;
end;

function TNegociacaoController.getDistribuidorController: TPessoaController;
begin
  if Self.FDistribuidorController = nil then
    Self.FDistribuidorController := TPessoaController.Create();
  Result := Self.FDistribuidorController;
end;

function TNegociacaoController.getNegociacao: TNegociacao;
begin
  if Self.FNegociacao = nil then
    Self.FNegociacao := TNegociacao.Create;
  Result := Self.FNegociacao;
end;

function TNegociacaoController.getDaoNegociacao: TDAONegociacao;
begin
  if Self.FDaoNegociacao = nil then
    Self.FDaoNegociacao := TDAONegociacao.Create(Self.getNegociacao);
  Result := Self.FDaoNegociacao;
end;

function TNegociacaoController.getDAOSituacaoNegociacao: TDAOSituacaoNegociacao;
begin
  if Self.FDAOSituacaoNegociacao = nil then
  begin
    FSituacaoNegociacao := TSituacaoNegociacao.Create;
    Self.FDAOSituacaoNegociacao := TDAOSituacaoNegociacao.Create(FSituacaoNegociacao);
  end;
  Result := self.FDAOSituacaoNegociacao;
end;

function TNegociacaoController.getDataSetNegociacoes: TDataSet;
begin
  Result := Self.getDAONegociacao.getDataSetNegociacaoes;
end;

function TNegociacaoController.getProdutoController: TProdutoController;
begin
  if Self.FProdutoController = nil then
    Self.FProdutoController := TProdutoController.Create;
  Result := Self.FProdutoController;
end;

function TNegociacaoController.getProdutorController: TPessoaController;
begin
  if Self.FProdutorController = nil then
    Self.FProdutorController := TPessoaController.Create();
  Result := Self.FProdutorController;
end;

procedure TNegociacaoController.PopulateStringsSituacaoNegociacao(
  const AStrings: TStrings; ATodos: Boolean);
begin
  Self.getDAOSituacaoNegociacao.LoadAll;
  Self.getDAOSituacaoNegociacao.DataSetAllData.First;
  AStrings.Clear;
  if ATodos then
    AStrings.AddObject('TODOS', TObject(0));
  while not Self.getDAOSituacaoNegociacao.DataSetAllData.Eof do
  begin
    Self.getDAOSituacaoNegociacao.SetDataClass;
    AStrings.AddObject(self.getDAOSituacaoNegociacao.PersistentObject.Descricao, TObject(self.getDAOSituacaoNegociacao.PersistentObject.Id));
    Self.getDAOSituacaoNegociacao.DataSetAllData.Next;
  end;
end;

end.
