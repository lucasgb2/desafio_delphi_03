unit UDAONegociacao;

interface
uses
  UDAOBase, UNegociacao, System.SysUtils, UDAOPessoa, FireDAC.Comp.Client, Data.DB;

type
  TDAONegociacao = class(TDAOBase)

  private
    FQueryProdutos: TFDQuery;
    FQueryNegociacoes: TFDQuery;
    FPersistentObject: TNegociacao;
    FDAODistribuidor: TDAOPessoa;
    FDAOProdutor: TDAOPessoa;
    function getQueryProdutos:TFDQuery;
    function getQueryNegociacoes: TFDQuery;
    function getDAODistribuidor: TDAOPessoa;
    function getDAOProdutor: TDAOPessoa;
    procedure SetPersistentObject(const Value: TNegociacao);
  public
    property PersistentObject: TNegociacao read FPersistentObject write SetPersistentObject;
    procedure SetDataClass; override;
    function Save(): Boolean; override;
    function Load(AId: Integer): Boolean;
    procedure Delete(); override;
    function getDataSetNegociacaoes: TDataSet;
    procedure LoadDataSetNegociacoes(ADistribuidor: Integer = 0; AProdutor: Integer = 0; ASituacao: Integer = 0);
    function getSaldoLimiteCreditoPessoa(AIdDistribuidor, AIdProdutor: Integer):Double;

    Constructor Create(); overload;
    Constructor Create(AObject: TNegociacao); overload;
    Destructor Destroy(); override;
  end;

implementation

uses
  UConsts, UDAOProduto;

{ TDAONegociacao }

constructor TDAONegociacao.Create(AObject: TNegociacao);
begin
  Self.Create;
  Self.PersistentObject := AObject;
  Self.Load(Self.PersistentObject.Id);
end;

procedure TDAONegociacao.Delete;
begin
  try
    StartTransaction;
    self.DeleteAll(self.getQueryProdutos);
    self.getQueryProdutos.ApplyUpdates();
    inherited;
    Commit
  except on e:Exception do
    begin
      Rollback;
      raise Exception.Create(Format(msgFalhaRemover, ['Negociação', e.Message]));

    end;
  end;
end;

destructor TDAONegociacao.Destroy;
begin
  TUtils.FreeObject(FQueryProdutos);
  TUtils.FreeObject(FQueryNegociacoes);
  inherited;
end;

constructor TDAONegociacao.Create;
begin
  Self.Table := 'negociacao';
  Self.FieldKey := 'idnegociacao';
end;

function TDAONegociacao.getDAODistribuidor: TDAOPessoa;
begin
  if FDAODistribuidor = nil then
    Self.FDAODistribuidor := TDAOPessoa.Create;
  Result := Self.FDAODistribuidor;
end;

function TDAONegociacao.getDAOProdutor: TDAOPessoa;
begin
  if FDAOProdutor = nil then
    Self.FDAOProdutor := TDAOPessoa.Create;
  Result := Self.FDAOProdutor;
end;

function TDAONegociacao.getDataSetNegociacaoes: TDataSet;
begin
  Result := getQueryNegociacoes;
end;

function TDAONegociacao.getQueryNegociacoes: TFDQuery;
begin
  if FQueryNegociacoes = nil then
    FQueryNegociacoes := Self.GetNewQuery;
  Result := FQueryNegociacoes;
end;

function TDAONegociacao.getQueryProdutos: TFDQuery;
begin
  if FQueryProdutos = nil then
    FQueryProdutos := self.GetNewQuery;
  Result := FQueryProdutos;
end;

function TDAONegociacao.getSaldoLimiteCreditoPessoa(AIdDistribuidor, AIdProdutor: Integer): Double;
const
  SQL =
      ' WITH '+
      ' limiteUtilizado AS ( '+
      '      SELECT '+
      '          coalesce(sum(negp.quantidade * negp.preco), 0) AS saldo '+
      '      FROM negociacao as neg '+
      '      LEFT JOIN negociacaoprodutos AS negp ON negp.idnegociacao = neg.idnegociacao '+
      '      WHERE neg.idprodutor = :idprodutor '+
      '        AND neg.iddistribuidor = :iddistribuidor '+
      '        AND neg.idsituacao = 2 '+
      '  ), '+

      '  limiteProdutor AS ( '+
      '      SELECT lim.limitecredito '+
      '      FROM pessoalimitecredito AS lim '+
      '      WHERE lim.idpessoaprodutor = :idprodutor '+
      '        AND lim.idpessoadistribuidor = :iddistribuidor '+
      ' ) '+

      ' SELECT (limiteProdutor.limitecredito - limiteUtilizado.saldo) AS saldo '+
      '    FROM limiteUtilizado '+
      '    JOIN limiteProdutor ON TRUE ';
var
  query : TFDQuery;
begin
  query:= Self.GetNewQuery;
  try
    query.SQL.Add(SQL);
    query.ParamByName('iddistribuidor').AsInteger := AIdDistribuidor;
    query.ParamByName('idprodutor').AsInteger := AIdProdutor;
    query.Open();
    Result := query.FieldByName('saldo').AsFloat;
  finally
    query.Free;
  end;
end;

function TDAONegociacao.Load(AId: Integer): Boolean;
begin
  Self.GetQueryLoad(IntToStr(AId));
  Self.getQueryProdutos.Close;
  Self.getQueryProdutos.Open('select * from negociacaoprodutos where idnegociacao = '+IntToStr(AId));
  Self.SetDataClass;
  Result := not self.GetQuery.IsEmpty;
end;

procedure TDAONegociacao.LoadDataSetNegociacoes(ADistribuidor, AProdutor, ASituacao: Integer);
const
  SQL : String =
    ' SELECT '+
    '    neg.idnegociacao AS "Negociação", '+
    '    produtor.nome AS "Produtor", '+
    '    distribuidor.nome AS "Distribuidor", '+
    '    situ.descricao AS "Situação", '+
    '    CAST(neg.datacadastro AS DATE) AS "Data Inclusão", '+
    '    CASE WHEN neg.datasituacao = ''30.12.1899'' THEN '+
    '        ''''                '+
    '    ELSE                    '+
    '   (extract(day from neg.datasituacao)||''/''||extract(month from neg.datasituacao)||''/''||extract(year from neg.datasituacao)) '+
    '    END AS "Data Situação", '+
    '    cast(round(sum(negp.quantidade * negp.preco), 2) AS CHAR(10)) AS "Total" '+
    ' FROM negociacao as neg '+
    ' JOIN pessoa AS produtor ON produtor.idpessoa = neg.idprodutor '+
    ' JOIN pessoa AS distribuidor ON distribuidor.idpessoa = neg.iddistribuidor '+
    ' JOIN situacaonegociacao AS situ ON situ.idsituacaonegociacao = neg.idsituacao '+
    ' JOIN negociacaoprodutos AS negp ON negp.idnegociacao = neg.idnegociacao '+
    ' WHERE '+
    ' CASE WHEN :idprodutor > 0 THEN '+
    '    neg.idprodutor = :idprodutor '+
    ' ELSE true END '+
    ' AND '+
    ' CASE WHEN :iddistribuidor > 0 THEN '+
    '    neg.iddistribuidor = :iddistribuidor '+
    ' ELSE true END '+
    ' AND '+
    ' CASE WHEN :idsituacao > 0 THEN '+
    '    neg.idsituacao = :idsituacao '+
    ' ELSE true END '+
    ' GROUP BY 1, 2, 3, 4, 5, 6';
begin
  self.getDataSetNegociacaoes;
  Self.getQueryNegociacoes.close;
  Self.getQueryNegociacoes.SQL.Clear;
  Self.getQueryNegociacoes.SQL.Add(SQL);
  Self.getQueryNegociacoes.ParamByName('iddistribuidor').AsInteger := ADistribuidor;
  Self.getQueryNegociacoes.ParamByName('idprodutor').AsInteger := AProdutor;
  Self.getQueryNegociacoes.ParamByName('idsituacao').AsInteger := ASituacao;
  Self.getQueryNegociacoes.Open();
end;

function TDAONegociacao.Save: Boolean;
var
  I: Integer;
  idNegocicao: Integer;
  queryItem: TFDQuery;
begin
  inherited;
  Result := False;
  queryItem := Self.GetNewQuery;
  try
    try
      Self.StartTransaction;

      self.getValue('idprodutor').Value := self.FPersistentObject.Produtor.Id;
      self.getValue('iddistribuidor').Value := self.FPersistentObject.Distribuidor.Id;
      self.getValue('idsituacao').Value := Integer(self.FPersistentObject.Situacao);
      self.getValue('datacadastro').Value := self.FPersistentObject.DataInclusao;
      self.getValue('datasituacao').Value := self.FPersistentObject.DataSituacao;

      self.GetQuery.Post;
      self.GetQuery.ApplyUpdates();

      idNegocicao := Self.getValue(Self.FieldKey).AsInteger;

      if Self.FPersistentObject.ItemsIsModificado then
      begin
        queryItem.Open('select * from negociacaoprodutos where idnegociacao = '+IntToStr(idNegocicao));
        Self.ConfigureFieldKey(queryItem, 'iditem');
        Self.DeleteAll(queryItem);

        for I := 0 to Self.FPersistentObject.Items.Count -1 do
        begin
          queryItem.Append;
          queryItem.FieldByName('idnegociacao').AsInteger := idNegocicao;
          queryItem.FieldByName('idproduto').AsInteger := Self.FPersistentObject.Items[i].Produto.Id;
          queryItem.FieldByName('quantidade').AsFloat := Self.FPersistentObject.Items[i].Quantidade;
          queryItem.FieldByName('preco').AsFloat := Self.FPersistentObject.Items[i].Preco;
          queryItem.Post;
        end;
        if not queryItem.IsEmpty then
          queryItem.ApplyUpdates();
      end;

      Self.Commit;
      Result := true;
    except on e: Exception do
      begin
        Self.Rollback;
        raise Exception.Create(Format(msgFalhaPersistir, ['Negociacao', e.Message]));
      end;
    end;
  finally
    queryItem.Free;
  end;
end;

procedure TDAONegociacao.SetDataClass;
begin
  inherited;
  if not Self.GetQuery.IsEmpty then
  begin
    getDAOProdutor.PeristentObject := Self.PersistentObject.Produtor;
    getDAOProdutor.Load(Self.getValue('idprodutor').AsInteger);

    getDAODistribuidor.PeristentObject := self.PersistentObject.Distribuidor;
    getDAODistribuidor.Load(Self.getValue('iddistribuidor').AsInteger);

    Self.FPersistentObject.DataInclusao := Self.getValue('datacadastro').AsDateTime;
    Self.FPersistentObject.DataSituacao := Self.getValue('datasituacao').AsDateTime;

    Self.FPersistentObject.Situacao := TEnumSituacaoNegociacao(Self.getValue('idsituacao').AsInteger);

    self.getQueryProdutos.First;
    self.FPersistentObject.Items.Clear;
    while not self.getQueryProdutos.Eof do
    begin
      self.FPersistentObject.Items.Add(TNegociacaoItem.Create(
        Self.getQueryProdutos.FieldByName('iditem').AsInteger,
        TDAOProduto.Create(Self.getQueryProdutos.FieldByName('idproduto').AsInteger).PersistentObject,
        Self.getQueryProdutos.FieldByName('quantidade').AsFloat,
        Self.getQueryProdutos.FieldByName('preco').AsFloat
        ));
      self.getQueryProdutos.next;
    end;
    Self.FPersistentObject.ItemsIsModificado := False;
  end;
end;

procedure TDAONegociacao.SetPersistentObject(const Value: TNegociacao);
begin
  FPersistentObject := Value;
end;

end.
