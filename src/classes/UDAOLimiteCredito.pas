unit UDAOLimiteCredito;

interface

uses
  UDAOBase, System.SysUtils, Data.DB, FireDAC.Comp.Client;

type
  TDAOLimiteCredito = class(TDAOBase)

  private
    FQueryLimiteCredito: TFDQuery;
    FLimiteCredito: Double;
    procedure SetLimiteCredito(const Value: Double);
    function getQueryLimteCredito(): TFDQuery;
  public
    property LimiteCredito: Double read FLimiteCredito write SetLimiteCredito;
    procedure SetDataClass; override;
    function SaveLimiteCredito(AIdProdutor, AIdDistribuidor: Integer): Boolean; overload;
    function Load(AIdProdutor, AIdDistribuidor: Integer): Boolean;

    Constructor Create(); overload;
  end;

implementation

{ TDAOLimiteCredito }

constructor TDAOLimiteCredito.Create;
begin

end;

function TDAOLimiteCredito.getQueryLimteCredito: TFDQuery;
begin
  if FQueryLimiteCredito = nil then
    FQueryLimiteCredito := Self.GetNewQuery;
  Result := FQueryLimiteCredito;
end;

function TDAOLimiteCredito.Load(AIdProdutor, AIdDistribuidor: Integer): Boolean;
begin
  Self.getQueryLimteCredito.Close;
  Self.getQueryLimteCredito.SQL.Clear;
  Self.getQueryLimteCredito.SQL.Add('select * from pessoalimitecredito where idpessoaprodutor = :idprodutor and idpessoadistribuidor = :iddistribuidor');
  Self.getQueryLimteCredito.ParamByName('idprodutor').AsInteger := AIdProdutor;
  Self.getQueryLimteCredito.ParamByName('iddistribuidor').AsInteger := AIdDistribuidor;
  Self.getQueryLimteCredito.Open;
  Result := not Self.getQueryLimteCredito.IsEmpty;
  Self.SetDataClass;
end;

function TDAOLimiteCredito.SaveLimiteCredito(AIdProdutor, AIdDistribuidor: Integer): Boolean;
begin
  if self.getQueryLimteCredito.IsEmpty then
    self.getQueryLimteCredito.Insert
  else
    self.getQueryLimteCredito.Edit;
  self.getQueryLimteCredito.FieldByName('limitecredito').AsFloat := Self.LimiteCredito;
  self.getQueryLimteCredito.FieldByName('idpessoaprodutor').AsFloat := AIdProdutor;
  self.getQueryLimteCredito.FieldByName('idpessoadistribuidor').AsFloat := AIdDistribuidor;
  self.getQueryLimteCredito.Post;
  self.getQueryLimteCredito.ApplyUpdates();
  Result := true;
end;

procedure TDAOLimiteCredito.SetDataClass;
begin
  inherited;
  Self.LimiteCredito := self.getQueryLimteCredito.FieldByName('limitecredito').AsFloat;
end;

procedure TDAOLimiteCredito.SetLimiteCredito(const Value: Double);
begin
  Self.FLimiteCredito := Value;
end;

end.
