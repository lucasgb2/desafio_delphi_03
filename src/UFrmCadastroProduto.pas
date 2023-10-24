unit UFrmCadastroProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, UProdutoController, Math;

type
  TFrmCadastroProduto = class(TFrmBase)
    EdtDescricao: TLabeledEdit;
    EdtPrecoVenda: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure EdtPrecoVendaKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPrecoVendaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FProdutoController: TProdutoController;
  protected
    procedure SetDataScreen; override;
    procedure SetDataClass; override;
    function BeforeSave:boolean; override;
    function Load(AId: Integer): Boolean; override;
    procedure Save; override;
    procedure ClearFields(); override;
  end;

var
  FrmCadastroProduto: TFrmCadastroProduto;

implementation

{$R *.dfm}

{ TFrmCadastroProduto }

function TFrmCadastroProduto.BeforeSave:boolean;
begin
  inherited;
  Self.FProdutoController.getProduto.validar;
  Result := True;
end;

procedure TFrmCadastroProduto.ClearFields;
begin
  inherited;
  EdtPrecoVenda.Text := '0,00';
end;

procedure TFrmCadastroProduto.EdtPrecoVendaExit(Sender: TObject);
begin
  inherited;
  if Trim(EdtPrecoVenda.Text) = '' then
    EdtPrecoVenda.Text := '0,00';
end;

procedure TFrmCadastroProduto.EdtPrecoVendaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not CharInSet(key,['0'..'9', #8, #13, #44]) then
    Key := #0;
end;

procedure TFrmCadastroProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Self.FProdutoController.Free;
end;

procedure TFrmCadastroProduto.FormCreate(Sender: TObject);
begin
  inherited;
  FProdutoController := TProdutoController.Create;
end;

function TFrmCadastroProduto.Load(AId: Integer): Boolean;
begin
  Result := Self.FProdutoController.getDAOProduto.Load(AId);
end;

procedure TFrmCadastroProduto.Save;
begin
  inherited;
  FProdutoController.getDAOProduto.Save;
end;

procedure TFrmCadastroProduto.SetDataClass;
begin
  inherited;
  FProdutoController.getProduto.Descricao := EdtDescricao.Text;
  FProdutoController.getProduto.PrecoVenda := RoundTo(StrToFloat(EdtPrecoVenda.Text), -2);
end;

procedure TFrmCadastroProduto.SetDataScreen;
begin
  inherited;
  EdtDescricao.Text := FProdutoController.getProduto.Descricao;
  EdtPrecoVenda.Text := FloatToStr(FProdutoController.getProduto.PrecoVenda);
end;



end.
