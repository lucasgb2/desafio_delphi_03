unit UFrmCadastroPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, UConsts, UPessoaController;

type
  TFrmCadastroPessoa = class(TFrmBase)
    EdtCPFCNPJ: TLabeledEdit;
    EdtNome: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  protected
    FPessoaController: TPessoaController;
    FTipoEndtidade: TEnumEntidadePessoa;
    procedure SetTipoEndtidade(const Value: TEnumEntidadePessoa);
    function BeforeSave(): Boolean; override;
    procedure SetDataClass(); override;
    procedure SetDataScreen(); override;
    procedure Save(); override;
    function Load(AId: Integer): Boolean; override;


  public
    { Public declarations }
    property TipoEndtidade: TEnumEntidadePessoa read FTipoEndtidade write SetTipoEndtidade;
  end;

var
  FrmCadastroPessoa: TFrmCadastroPessoa;

implementation

{$R *.dfm}

{ TFrmCadastroPessoa }

function TFrmCadastroPessoa.BeforeSave: Boolean;
begin
  Self.FPessoaController.getPessoa.Validar;
  Result := True;
end;

procedure TFrmCadastroPessoa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FPessoaController.Free;
end;

procedure TFrmCadastroPessoa.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FecharJanelaAoSalvar := True;
  FPessoaController := TPessoaController.Create;
end;

function TFrmCadastroPessoa.Load(AId: Integer): Boolean;
begin
  Result := Self.FPessoaController.getDAOPessoa.Load(AId);
end;

procedure TFrmCadastroPessoa.Save;
begin
  FPessoaController.getDAOPessoa.Save;
end;

procedure TFrmCadastroPessoa.SetDataClass;
begin
  Self.FPessoaController.getPessoa.Nome := EdtNome.Text;
  Self.FPessoaController.getPessoa.CPFCNPJ := EdtCPFCNPJ.Text;
  Self.FPessoaController.getPessoa.TipoEntidade := Self.TipoEndtidade;
end;

procedure TFrmCadastroPessoa.SetDataScreen;
begin
  EdtNome.Text := Self.FPessoaController.getPessoa.Nome;
  EdtCPFCNPJ.Text := Self.FPessoaController.getPessoa.CPFCNPJ;
  Self.TipoEndtidade := self.FPessoaController.getPessoa.TipoEntidade;
end;

procedure TFrmCadastroPessoa.SetTipoEndtidade(const Value: TEnumEntidadePessoa);
begin
  FTipoEndtidade := Value;
  case FTipoEndtidade of
    pesProdutor: Self.Caption := 'Cadastro Produtor';
    pesDistribuidor: Self.Caption := 'Cadastro Distribuidor';
  end;
end;

end.
