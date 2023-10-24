unit UFrmNegociacao;

interface

uses
  UProduto, UPessoa, UNegociacao, UNegociacaoController, UID,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, Data.DB, Vcl.StdCtrls,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.Samples.Spin, Vcl.ExtCtrls, Math,
  Vcl.ComCtrls, UConsts;

type
  TfrmNegociacao = class(TFrmBase)
    cbxDistribuidor: TComboBox;
    cbxProdutor: TComboBox;
    cbxProduto: TComboBox;
    spnQuantidade: TSpinEdit;
    btnAdicionar: TButton;
    cbxSituacao: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Produto: TLabel;
    spin: TLabel;
    Label3: TLabel;
    DBGrid1: TDBGrid;
    cdsProdutos: TClientDataSet;
    cdsProdutosidproduto: TIntegerField;
    cdsProdutosdescricao: TStringField;
    cdsProdutosquantidade: TFloatField;
    cdsProdutostotal: TFloatField;
    cdsProdutosprecounitario: TFloatField;
    cdsProdutostotalgeral: TFloatField;
    cdsProdutostotalgeralagregate: TAggregateField;
    dsProdutos: TDataSource;
    Panel2: TPanel;
    edtTotalGeral: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure cdsProdutosCalcFields(DataSet: TDataSet);
    procedure btnAdicionarClick(Sender: TObject);
    procedure cdsProdutosAfterDelete(DataSet: TDataSet);
  private
    FNegociacaoController : TNegociacaoController;
    FIDNegociacao: Integer;
    procedure SetIDNegociacao(const Value: Integer);
  public
    property IDNegociacao: Integer read FIDNegociacao write SetIDNegociacao;
    procedure SetDataScreen; override;
    procedure SetDataClass; override;
    function BeforeSave:boolean; override;
    function Load(AId: Integer): Boolean; override;
    procedure Save; override;
    procedure ClearFields(); override;
  end;

var
  frmNegociacao: TfrmNegociacao;

implementation

{$R *.dfm}

{ TFrmBase1 }

function TfrmNegociacao.BeforeSave: boolean;
begin
  if cbxDistribuidor.ItemIndex < 0 then
    raise Exception.Create(Format(msgCampoRequerido, ['Distribuidor']));

  if cbxProdutor.ItemIndex < 0 then
    raise Exception.Create(Format(msgCampoRequerido, ['Produtor']));

  Result := FNegociacaoController.getNegociacao.Validar(
    Self.FNegociacaoController.getDAONegociacao.getSaldoLimiteCreditoPessoa(
      Integer(cbxDistribuidor.Items.Objects[cbxDistribuidor.ItemIndex]),
      Integer(cbxProdutor.Items.Objects[cbxProdutor.ItemIndex])
      ));
end;

procedure TfrmNegociacao.btnAdicionarClick(Sender: TObject);
var
  produto: TProduto;
begin
  if cbxProduto.ItemIndex < 0 then
  begin
    cbxProduto.SetFocus;
    raise Exception.Create(Format(msgCampoRequerido, ['Produto']));
  end;

  produto := TProduto(cbxProduto.Items.Objects[cbxProduto.ItemIndex]);
  cdsProdutos.Append;
  cdsProdutosidproduto.AsInteger := produto.Id;
  cdsProdutosdescricao.AsString  := produto.Descricao;
  cdsProdutosquantidade.AsFloat  := spnQuantidade.Value;
  cdsProdutosprecounitario.AsFloat  := produto.PrecoVenda;
  cdsProdutostotal.AsFloat := RoundTo(spnQuantidade.Value * produto.PrecoVenda, -2);
  cdsProdutos.Post;
  self.FNegociacaoController.getNegociacao.ItemsIsModificado := true;

  spnQuantidade.Value := 1;
  cbxProduto.ItemIndex := -1;
end;

procedure TfrmNegociacao.cdsProdutosAfterDelete(DataSet: TDataSet);
begin
  inherited;
  self.FNegociacaoController.getNegociacao.ItemsIsModificado := true;
end;

procedure TfrmNegociacao.cdsProdutosCalcFields(DataSet: TDataSet);
var
  total: Double;
begin
  cdsProdutostotalgeral.AsFloat := cdsProdutosquantidade.AsFloat * cdsProdutosprecounitario.AsFloat;
  if TryStrToFloat(cdsProdutostotalgeralagregate.AsString, total) then
    edtTotalGeral.Text := FormatFloat('#,##0.00', total);
end;

procedure TfrmNegociacao.ClearFields;
begin
  inherited;
end;

procedure TfrmNegociacao.FormCreate(Sender: TObject);
begin
  inherited;
  cdsProdutos.CreateDataSet;
  Self.FecharJanelaAoSalvar := True;
  Self.FNegociacaoController := TNegociacaoController.Create;
  Self.FNegociacaoController.getDistribuidorController.PopulateStringsProdutor(cbxProdutor.Items, False);
  Self.FNegociacaoController.getProdutorController.PopulateStringsDistribuidor(cbxDistribuidor.Items, False);
  Self.FNegociacaoController.getProdutoController.PopulateStrings(cbxProduto.Items);
  Self.FNegociacaoController.PopulateStringsSituacaoNegociacao(cbxSituacao.Items, False);
  cbxSituacao.ItemIndex := 0;
end;

function TfrmNegociacao.Load(AId: Integer): Boolean;
begin
  Result := Self.FNegociacaoController.getDAONegociacao.Load(AId);
end;

procedure TfrmNegociacao.Save;
begin
  inherited;
  Self.FNegociacaoController.getDAONegociacao.Save;
end;

procedure TfrmNegociacao.SetDataClass;
var
  item: TNegociacaoItem;
begin
  inherited;
  Self.FNegociacaoController.getNegociacao.Produtor := TPessoa.Create(Integer(cbxProdutor.Items.Objects[cbxProdutor.ItemIndex]));
  Self.FNegociacaoController.getNegociacao.Distribuidor := TPessoa.Create(Integer(cbxDistribuidor.Items.Objects[cbxDistribuidor.ItemIndex]));
  Self.FNegociacaoController.getNegociacao.Situacao := TEnumSituacaoNegociacao(Integer(cbxSituacao.Items.Objects[cbxSituacao.ItemIndex]));
  if self.FNegociacaoController.getNegociacao.DataInclusao = nullDate then
    self.FNegociacaoController.getNegociacao.DataInclusao := Now;
  cdsProdutos.First;
  //Somente manipular itens se de fato foi modificado
  if self.FNegociacaoController.getNegociacao.ItemsIsModificado then
  begin
    self.FNegociacaoController.getNegociacao.Items.Clear;
    while not cdsProdutos.Eof do
    begin
      item := TNegociacaoItem.Create(TProduto.Create(cdsProdutosidproduto.AsInteger), cdsProdutosquantidade.AsFloat, cdsProdutosprecounitario.AsFloat);
      self.FNegociacaoController.getNegociacao.Items.Add(item);

      cdsProdutos.Next;
    end;
  end;
end;

procedure TfrmNegociacao.SetDataScreen;
var
  I: Integer;
begin
  inherited;
  for I := 0 to cbxProdutor.Items.Count -1 do
    if Integer(cbxProdutor.Items.Objects[i]) = Self.FNegociacaoController.getNegociacao.Produtor.Id then
    begin
      cbxProdutor.ItemIndex := i;
      break;
    end;

  for I := 0 to cbxDistribuidor.Items.Count -1 do
    if Integer(cbxDistribuidor.Items.Objects[i]) = Self.FNegociacaoController.getNegociacao.Distribuidor.Id then
    begin
      cbxDistribuidor.ItemIndex := i;
      break;
    end;

  for I := 0 to cbxSituacao.Items.Count -1 do
    if Integer(cbxSituacao.Items.Objects[i]) = Integer(Self.FNegociacaoController.getNegociacao.Situacao) then
    begin
      cbxSituacao.ItemIndex := i;
      break;
    end;

  for I := 0 to Self.FNegociacaoController.getNegociacao.Items.Count - 1 do
  begin
    cdsProdutos.Append;
    cdsProdutosidproduto.AsInteger := Self.FNegociacaoController.getNegociacao.Items[i].Produto.Id;
    cdsProdutosdescricao.AsString := Self.FNegociacaoController.getNegociacao.Items[i].Produto.Descricao;
    cdsProdutosquantidade.AsFloat := Self.FNegociacaoController.getNegociacao.Items[i].Quantidade;
    cdsProdutosprecounitario.AsFloat := Self.FNegociacaoController.getNegociacao.Items[i].Preco;
    cdsProdutostotal.AsFloat := Self.FNegociacaoController.getNegociacao.Items[i].Quantidade * Self.FNegociacaoController.getNegociacao.Items[i].Preco;
    cdsProdutos.Post;
  end;
end;

procedure TfrmNegociacao.SetIDNegociacao(const Value: Integer);
begin
  FIDNegociacao := Value;
  Self.EdtId.Text := IntToStr(FIDNegociacao);
  Self.EdtIdExit(self);
end;

end.
