unit UDAOSituacaoNegociacao;

interface

uses
  UDAOBase, USituacaoNegociacao, System.SysUtils, Data.DB;

type
  TDAOSituacaoNegociacao = class(TDAOBase)

  private
    FPersistentObject: TSituacaoNegociacao;
    procedure SetPersistentObject(const Value: TSituacaoNegociacao);

  public
    property PersistentObject:TSituacaoNegociacao read FPersistentObject write SetPersistentObject;
    procedure SetDataClass; override;
    function Load(AId: Integer): Boolean;
    Constructor Create(); overload;
    Constructor Create(AObject: TSituacaoNegociacao); overload;
    Constructor Create(AId: Integer); overload;

  end;

implementation

{ TDAOSituacaoNegociacao }

constructor TDAOSituacaoNegociacao.Create(AObject: TSituacaoNegociacao);
begin
  Self.Create();
  Self.FPersistentObject := AObject;
  if Self.FPersistentObject.Id > 0 then
    Self.Load(Self.FPersistentObject.Id);
end;

constructor TDAOSituacaoNegociacao.Create(AId: Integer);
begin
  Self.Create();
  if AId > 0 then
  begin
    Self.FPersistentObject := TSituacaoNegociacao.Create;
    Self.Load(AId);
  end;
end;

procedure TDAOSituacaoNegociacao.SetDataClass;
begin
  inherited;
  self.FPersistentObject.Id := self.getValue('idsituacaonegociacao').AsInteger;
  self.FPersistentObject.Descricao := self.getValue('descricao').AsString;
end;

procedure TDAOSituacaoNegociacao.SetPersistentObject(
  const Value: TSituacaoNegociacao);
begin
  FPersistentObject := Value;
end;

constructor TDAOSituacaoNegociacao.Create;
begin
  Self.Table := 'situacaonegociacao';
  Self.FieldKey := 'idsituacaonegociacao';
end;

function TDAOSituacaoNegociacao.Load(AId: Integer): Boolean;
begin
  Self.GetQueryLoad(IntToStr(AId));
  Self.SetDataClass;
  Result := not self.GetQuery.IsEmpty;
end;

end.
