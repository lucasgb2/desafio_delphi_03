unit UPessoaController;

interface
uses
  UPessoa, UDAOPessoa, UConsts, System.Classes, UDAOLimiteCredito;

Type
  TPessoaController = class
  private
    FPessoa: TPessoa;
    FDAOPessoa: TDAOPessoa;
    FDAOLimiteCredito: TDAOLimiteCredito;
    procedure PopulateStringsPessoa(const AStrings:TStrings; const ATipo:TEnumEntidadePessoa; ATodos: Boolean = True);

  public
    function getPessoa: TPessoa;
    function getDAOPessoa: TDAOPessoa;
    function getDAOLimiteCredito: TDAOLimiteCredito;
    procedure PopulateStringsProdutor(const AStrings:TStrings; ATodos: Boolean = True);
    procedure PopulateStringsDistribuidor(const AStrings:TStrings; ATodos: Boolean = True);
    constructor Create();
    destructor Destroy(); override;
  end;

implementation

{ TPessoaController }

constructor TPessoaController.Create;
begin
end;

destructor TPessoaController.Destroy;
begin
  TUtils.FreeObject(Self.FPessoa);
  TUtils.FreeObject(Self.FDAOPessoa);
end;

function TPessoaController.getDAOLimiteCredito: TDAOLimiteCredito;
begin
  if self.FDAOLimiteCredito = nil then
    self.FDAOLimiteCredito := TDAOLimiteCredito.Create;
  result := self.FDAOLimiteCredito;
end;

function TPessoaController.getDAOPessoa: TDAOPessoa;
begin
  if self.FDAOPessoa = nil then
    self.FDAOPessoa := TDAOPessoa.Create(self.getPessoa);
  Result := self.FDAOPessoa;
end;

function TPessoaController.getPessoa: TPessoa;
begin
  if self.FPessoa = nil then
    self.FPessoa := TPessoa.create();
  Result := self.FPessoa;
end;

procedure TPessoaController.PopulateStringsDistribuidor(
  const AStrings: TStrings; ATodos: Boolean);
begin
  Self.PopulateStringsPessoa(AStrings, TEnumEntidadePessoa.pesDistribuidor, ATodos);
end;

procedure TPessoaController.PopulateStringsPessoa(const AStrings: TStrings;
  const ATipo: TEnumEntidadePessoa; ATodos: Boolean);
begin
  Self.getDAOPessoa.LoadAll;
  Self.getDAOPessoa.DataSetAllData.First;
  AStrings.Clear;
  if ATodos then
    AStrings.AddObject('TODOS', TObject(0));
  while not Self.getDAOPessoa.DataSetAllData.Eof do
  begin
    Self.getDAOPessoa.SetDataClass;
    if self.getDAOPessoa.PeristentObject.TipoEntidade = ATipo then
      AStrings.AddObject(self.getDAOPessoa.PeristentObject.Nome, TObject(self.getDAOPessoa.PeristentObject.Id));
    Self.getDAOPessoa.DataSetAllData.Next;
  end;
end;

procedure TPessoaController.PopulateStringsProdutor(const AStrings: TStrings; ATodos: Boolean);
begin
  Self.PopulateStringsPessoa(AStrings, TEnumEntidadePessoa.pesProdutor, ATodos);
end;

end.
