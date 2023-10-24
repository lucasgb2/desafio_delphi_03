unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, UConsts;

type
  TFrmMain = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Produtor1: TMenuItem;
    Fornecedor1: TMenuItem;
    N1: TMenuItem;
    LimiteCrditoXFornecedor1: TMenuItem;
    Sair1: TMenuItem;
    GerenciarNegociaes1: TMenuItem;
    Sair2: TMenuItem;
    Produto1: TMenuItem;
    procedure Sair2Click(Sender: TObject);
    procedure Produtor1Click(Sender: TObject);
    procedure Fornecedor1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure GerenciarNegociaes1Click(Sender: TObject);
    procedure LimiteCrditoXFornecedor1Click(Sender: TObject);
  private
    procedure CreateFormPessoa(const AEntidade: TEnumEntidadePessoa);

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  UFrmCadastroPessoa, UFrmCadastroProduto, UFrmGerenciarNegociacao,
  UFrmLimiteCredito;

{$R *.dfm}

procedure TFrmMain.CreateFormPessoa(const AEntidade: TEnumEntidadePessoa);
var
  frmPessoa: TFrmCadastroPessoa;
begin
  Application.CreateForm(TFrmCadastroPessoa, frmPessoa);
  frmPessoa.TipoEndtidade := AEntidade;
  frmPessoa.ShowModal;
  frmPessoa.Free;
end;

procedure TFrmMain.Fornecedor1Click(Sender: TObject);
begin
  Self.CreateFormPessoa(TEnumEntidadePessoa.pesDistribuidor);
end;

procedure TFrmMain.GerenciarNegociaes1Click(Sender: TObject);
var
  frmNegociacao: TFrmGerenciarNegociacoes;
begin
  Application.CreateForm(TFrmGerenciarNegociacoes, frmNegociacao);
  frmNegociacao.ShowModal;
  frmNegociacao.Free;
end;

procedure TFrmMain.LimiteCrditoXFornecedor1Click(Sender: TObject);
var
  frmLimite:TfrmLimiteCredito;
begin
  Application.CreateForm(TfrmLimiteCredito, frmLimite);
  frmLimite.ShowModal;
  frmLimite.Free;
end;

procedure TFrmMain.Produto1Click(Sender: TObject);
var
  frmProduto: TFrmCadastroProduto;
begin
  Application.CreateForm(TFrmCadastroProduto, frmProduto);
  frmProduto.ShowModal;
  frmProduto.Free;
end;

procedure TFrmMain.Produtor1Click(Sender: TObject);
begin
  Self.CreateFormPessoa(TEnumEntidadePessoa.pesProdutor);
end;

procedure TFrmMain.Sair2Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
