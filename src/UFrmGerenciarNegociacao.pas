unit UFrmGerenciarNegociacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, System.UITypes,
  Vcl.StdCtrls, Vcl.ExtCtrls, UNegociacaoController, Vcl.Menus, UConsts;

type
  TFrmGerenciarNegociacoes = class(TForm)
    pnlControles: TPanel;
    btnAlterar: TButton;
    btnSair: TButton;
    btnNovo: TButton;
    gridNegociacao: TDBGrid;
    btnImprimir: TButton;
    btnAlterarSituacao: TButton;
    Panel1: TPanel;
    dsNegociacao: TDataSource;
    cbxDistribuidor: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cbxProdutor: TComboBox;
    cbxSituacao: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    popSituacao: TPopupMenu;
    Pendente1: TMenuItem;
    Aprovada1: TMenuItem;
    Cancelada1: TMenuItem;
    Finalizada1: TMenuItem;
    btnRemover: TButton;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnAlterarSituacaoClick(Sender: TObject);
    procedure cbxDistribuidorChange(Sender: TObject);
    procedure cbxProdutorChange(Sender: TObject);
    procedure cbxSituacaoChange(Sender: TObject);
    procedure Pendente1Click(Sender: TObject);
    procedure Aprovada1Click(Sender: TObject);
    procedure Cancelada1Click(Sender: TObject);
    procedure Finalizada1Click(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
  private
    FNegociacaoController:TNegociacaoController;
    procedure AutoWidthColumnGrid;
    procedure LoadNegociacoes();
    procedure AlterarSituacaoNegociacao(ASituacao: TEnumSituacaoNegociacao);
  public
    { Public declarations }
  end;

var
  FrmGerenciarNegociacoes: TFrmGerenciarNegociacoes;

implementation

uses
  UFrmNegociacao, UDMReport;

{$R *.dfm}

procedure TFrmGerenciarNegociacoes.AlterarSituacaoNegociacao(
  ASituacao: TEnumSituacaoNegociacao);
var
  situacao: string;
begin
  case ASituacao of
    negPendente: situacao := 'Pendente';
    negAprovado: situacao := 'Aprovada';
    negConcluir: situacao := 'Concluir';
    negCancelada: situacao := 'Cancelada';
  end;

  if MessageDlg(format(msgAlteracaoSituacao, [situacao, dsNegociacao.DataSet.FieldByName('Negociação').AsString] ),
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Self.FNegociacaoController.AlterarSituacaoNegociacao(dsNegociacao.DataSet.FieldByName('Negociação').AsInteger, ASituacao);
    ShowMessage(msgOperacaoSucesso);
    Self.LoadNegociacoes;
  end;
end;

procedure TFrmGerenciarNegociacoes.Aprovada1Click(Sender: TObject);
begin
  Self.AlterarSituacaoNegociacao(TEnumSituacaoNegociacao.negAprovado);
end;

procedure TFrmGerenciarNegociacoes.AutoWidthColumnGrid;
var
  i:integer;
begin
  for I := 0 to gridNegociacao.Columns.Count -1 do
    gridNegociacao.Columns[i].Width := Round(gridNegociacao.Width / gridNegociacao.Columns.Count);
end;

procedure TFrmGerenciarNegociacoes.btnAlterarClick(Sender: TObject);
var
  frm: TFrmNegociacao;
begin
  Application.CreateForm(TFrmNegociacao, frm);
  frm.IDNegociacao := dsNegociacao.DataSet.FieldByName('Negociação').AsInteger;
  frm.ShowModal;
  frm.Free;
  self.LoadNegociacoes;
end;

procedure TFrmGerenciarNegociacoes.btnAlterarSituacaoClick(Sender: TObject);
begin
  popSituacao.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TFrmGerenciarNegociacoes.btnImprimirClick(Sender: TObject);
begin
  DMReport.ShowReport(dsNegociacao.DataSet);
end;

procedure TFrmGerenciarNegociacoes.btnNovoClick(Sender: TObject);
var
  frm: TFrmNegociacao;
begin
  Application.CreateForm(TFrmNegociacao, frm);
  frm.ShowModal;
  frm.Free;
  self.LoadNegociacoes;
end;

procedure TFrmGerenciarNegociacoes.btnRemoverClick(Sender: TObject);
begin
  if MessageDlg(Format(msgConfirmaRemocaoNegociacao, [dsNegociacao.DataSet.FieldByName('Negociação').AsString]),
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if Self.FNegociacaoController.Delete(dsNegociacao.DataSet.FieldByName('Negociação').AsInteger) then
    begin
      ShowMessage(msgOperacaoSucesso);
      Self.LoadNegociacoes;
    end;
  end;
end;

procedure TFrmGerenciarNegociacoes.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmGerenciarNegociacoes.Cancelada1Click(Sender: TObject);
begin
  Self.AlterarSituacaoNegociacao(TEnumSituacaoNegociacao.negCancelada);
end;

procedure TFrmGerenciarNegociacoes.cbxDistribuidorChange(Sender: TObject);
begin
  Self.LoadNegociacoes;
end;

procedure TFrmGerenciarNegociacoes.cbxProdutorChange(Sender: TObject);
begin
  Self.LoadNegociacoes;
end;

procedure TFrmGerenciarNegociacoes.cbxSituacaoChange(Sender: TObject);
begin
  Self.LoadNegociacoes;
end;

procedure TFrmGerenciarNegociacoes.Finalizada1Click(Sender: TObject);
begin
  Self.AlterarSituacaoNegociacao(TEnumSituacaoNegociacao.negConcluir);
end;

procedure TFrmGerenciarNegociacoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Self.FNegociacaoController.Free;
end;

procedure TFrmGerenciarNegociacoes.FormCreate(Sender: TObject);
begin
  Self.FNegociacaoController := TNegociacaoController.Create;
  Self.FNegociacaoController.getDistribuidorController.PopulateStringsProdutor(cbxProdutor.Items);
  cbxProdutor.ItemIndex := 0;
  Self.FNegociacaoController.getProdutorController.PopulateStringsDistribuidor(cbxDistribuidor.Items);
  cbxDistribuidor.ItemIndex := 0;
  Self.FNegociacaoController.PopulateStringsSituacaoNegociacao(cbxSituacao.Items);
  cbxSituacao.ItemIndex := 0;

  Self.LoadNegociacoes();
end;

procedure TFrmGerenciarNegociacoes.LoadNegociacoes;
begin
  Self.dsNegociacao.DataSet := self.FNegociacaoController.getDataSetNegociacoes;
  Self.FNegociacaoController.getDAONegociacao.LoadDataSetNegociacoes(
    Integer(cbxDistribuidor.Items.Objects[cbxDistribuidor.ItemIndex]),
    Integer(cbxProdutor.Items.Objects[cbxProdutor.ItemIndex]),
    Integer(cbxSituacao.Items.Objects[cbxSituacao.ItemIndex]));
  Self.AutoWidthColumnGrid;
end;

procedure TFrmGerenciarNegociacoes.Pendente1Click(Sender: TObject);
begin
  Self.AlterarSituacaoNegociacao(TEnumSituacaoNegociacao.negPendente);
end;

end.
