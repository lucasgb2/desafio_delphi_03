unit UFrmLimiteCredito;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, UPessoaController, System.StrUtils;

type
  TfrmLimiteCredito = class(TFrmBase)
    cbxDistribuidor: TComboBox;
    Label1: TLabel;
    cbxProdutor: TComboBox;
    Label2: TLabel;
    EdtLimiteCredito: TLabeledEdit;
    procedure EdtLimiteCreditoExit(Sender: TObject);
    procedure EdtLimiteCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cbxDistribuidorChange(Sender: TObject);
  private
    { Private declarations }
  protected
    FPessoaController: TPessoaController;
    function BeforeSave(): Boolean; override;
    procedure SetDataClass(); override;
    procedure Save(); override;
    procedure SaveLimiteCredito(AIdProdutor, AIdDistribuidor: Integer);
    function LoadLimiteCredito(AIdProdutor, AIdDistribuidor: Integer): Boolean;
  public
    { Public declarations }
  end;

var
  frmLimiteCredito: TfrmLimiteCredito;

implementation

uses
  UConsts;

{$R *.dfm}

function TfrmLimiteCredito.BeforeSave: Boolean;
var
  limitecredito: Double;
begin
  inherited;
  if cbxDistribuidor.Text = '' then
    raise Exception.Create(Format(msgCampoRequerido, ['Distribuidor']));

  if cbxProdutor.Text = '' then
    raise Exception.Create(Format(msgCampoRequerido, ['Produtor']));

  if TryStrToFloat(EdtLimiteCredito.Text, limitecredito) = false then
    raise Exception.Create(Format(msgCampoRequerido, ['Limite de Crédito']));
  Result := True
end;

procedure TfrmLimiteCredito.cbxDistribuidorChange(Sender: TObject);
begin
  inherited;
  if (cbxDistribuidor.Text <> '') and (cbxProdutor.Text <> '') then
    Self.LoadLimiteCredito(Integer(cbxProdutor.Items.Objects[cbxProdutor.ItemIndex]), Integer(cbxDistribuidor.Items.Objects[cbxDistribuidor.ItemIndex]));
end;

procedure TfrmLimiteCredito.EdtLimiteCreditoExit(Sender: TObject);
begin
  inherited;
  if Trim(EdtLimiteCredito.Text) = '' then
    EdtLimiteCredito.Text := '0,00';
end;

procedure TfrmLimiteCredito.EdtLimiteCreditoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not CharInSet(key,['0'..'9', #8, #13, #44]) then
    Key := #0;
end;

procedure TfrmLimiteCredito.FormCreate(Sender: TObject);
begin
  inherited;
  Self.LimparCamposAoSalvar := False;
  FPessoaController := TPessoaController.Create;
  Self.FPessoaController.PopulateStringsProdutor(cbxProdutor.Items, False);
  Self.FPessoaController.PopulateStringsDistribuidor(cbxDistribuidor.Items, False);
end;

function TfrmLimiteCredito.LoadLimiteCredito(AIdProdutor, AIdDistribuidor: Integer): Boolean;
begin
  Result := Self.FPessoaController.getDAOLimiteCredito.Load(AIdProdutor, AIdDistribuidor);
  if Result then
    EdtLimiteCredito.Text := FloatToStr(Self.FPessoaController.getDAOLimiteCredito.LimiteCredito);
end;

procedure TfrmLimiteCredito.SaveLimiteCredito(AIdProdutor, AIdDistribuidor: Integer);
begin
  Self.FPessoaController.getDAOLimiteCredito.SaveLimiteCredito(AIdProdutor, AIdDistribuidor);
end;

procedure TfrmLimiteCredito.Save;
begin
  self.SaveLimiteCredito(Integer(cbxProdutor.Items.Objects[cbxProdutor.ItemIndex]), Integer(cbxDistribuidor.Items.Objects[cbxDistribuidor.ItemIndex]));
end;

procedure TfrmLimiteCredito.SetDataClass;
var
  limitecredito: Double;
begin
  inherited;
  if TryStrToFloat(EdtLimiteCredito.Text, limitecredito) then
    Self.FPessoaController.getDAOLimiteCredito.LimiteCredito := limitecredito;
end;

end.
