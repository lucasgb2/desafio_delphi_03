unit UPessoa;

interface

uses
  UConsts, UId, System.SysUtils;

type
  TPessoa = class(TId)
  private
    FCPFCNPJ: String;
    FNome: String;
    FTipoEntidade: TEnumEntidadePessoa;
    procedure SetCPFCNPJ(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetTipoEntidade(const Value: TEnumEntidadePessoa);

  public
    property Nome: String read FNome write SetNome;
    property CPFCNPJ: String read FCPFCNPJ write SetCPFCNPJ;
    property TipoEntidade: TEnumEntidadePessoa read FTipoEntidade write SetTipoEntidade;
    procedure Validar();
end;

implementation

{ TPessoa }

procedure TPessoa.SetCPFCNPJ(const Value: String);
begin
  FCPFCNPJ := Value;
end;

procedure TPessoa.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TPessoa.SetTipoEntidade(const Value: TEnumEntidadePessoa);
begin
  FTipoEntidade := Value;
end;

procedure TPessoa.Validar;
begin
  if Self.CPFCNPJ = EmptyStr then
    raise Exception.Create(Format(msgCampoRequerido, ['CPF/CNPJ'] ));

  if (Length(Self.CPFCNPJ) = 11) and (TUtils.ValidarCPF(Self.CPFCNPJ) = false) then
    raise Exception.Create(msgCPFInvalido);

  if (Length(Self.CPFCNPJ) = 14) and (TUtils.ValidarCNPJ(Self.CPFCNPJ) = false) then
    raise Exception.Create(msgCNPJInvalido);

  if (Length(Self.CPFCNPJ) <> 11) and (Length(Self.CPFCNPJ) <> 14) then
    raise Exception.Create(msgCNPJCPFInvalido);

  if Self.Nome = EmptyStr then
    raise Exception.Create(Format(msgCampoRequerido, ['Nome'] ));
end;

end.
