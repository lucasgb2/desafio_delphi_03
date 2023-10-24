program ControleNegociacao;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {FrmMain},
  UFrmBase in 'UFrmBase.pas' {FrmBase},
  UConsts in 'UConsts.pas',
  UFrmCadastroPessoa in 'UFrmCadastroPessoa.pas' {FrmCadastroPessoa},
  UFrmCadastroProduto in 'UFrmCadastroProduto.pas' {FrmCadastroProduto},
  uDM in 'uDM.pas' {DM: TDataModule},
  UPessoa in 'classes\UPessoa.pas',
  UProduto in 'classes\UProduto.pas',
  UId in 'classes\UId.pas',
  UNegociacao in 'classes\UNegociacao.pas',
  UDAOProduto in 'classes\UDAOProduto.pas',
  UDAOBase in 'classes\UDAOBase.pas',
  UProdutoController in 'classes\UProdutoController.pas',
  UPessoaController in 'classes\UPessoaController.pas',
  UDAOPessoa in 'classes\UDAOPessoa.pas',
  UFrmGerenciarNegociacao in 'UFrmGerenciarNegociacao.pas' {FrmGerenciarNegociacoes},
  UDAONegociacao in 'classes\UDAONegociacao.pas',
  UNegociacaoController in 'classes\UNegociacaoController.pas',
  UDAOSituacaoNegociacao in 'classes\UDAOSituacaoNegociacao.pas',
  USituacaoNegociacao in 'classes\USituacaoNegociacao.pas',
  UDMReport in 'UDMReport.pas' {DMReport: TDataModule},
  UFrmNegociacao in 'UFrmNegociacao.pas' {frmNegociacao},
  UFrmLimiteCredito in 'UFrmLimiteCredito.pas' {frmLimiteCredito},
  UDAOLimiteCredito in 'classes\UDAOLimiteCredito.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDMReport, DMReport);
  Application.Run;
end.
