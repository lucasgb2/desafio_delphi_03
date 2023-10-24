unit UProdutoController;

interface

uses
  UProduto, UDAOProduto, System.Classes, System.SysUtils;

type
  TProdutoController = class
  private
    FProduto: TProduto;
    FDAOProduto: TDAOProduto;

  public
    function getProduto: TProduto;
    function getDAOProduto: TDAOProduto;
    procedure PopulateStrings(const AStrings: TStrings);
    constructor Create();
    destructor Destroy(); override;

  end;

implementation

{ TProdutoController }

constructor TProdutoController.Create;
begin
end;

destructor TProdutoController.Destroy;
begin
  if self.FProduto <> nil then
    self.FProduto.Free;
  if self.FDAOProduto <> nil then
    self.FDAOProduto.Free;
  inherited;
end;

function TProdutoController.getDAOProduto: TDAOProduto;
begin
  if self.FDAOProduto = nil then
    self.FDAOProduto := TDAOProduto.Create(self.getProduto);
  Result := self.FDAOProduto;
end;

function TProdutoController.getProduto: TProduto;
begin
  if self.FProduto = nil then
    self.FProduto := TProduto.Create;
  Result := self.FProduto;
end;

procedure TProdutoController.PopulateStrings(const AStrings: TStrings);
begin
  Self.getDAOProduto.LoadAll;
  Self.getDAOProduto.DataSetAllData.First;
  AStrings.Clear;
  while not Self.getDAOProduto.DataSetAllData.Eof do
  begin
    Self.getDAOProduto.PersistentObject := TProduto.Create;
    Self.getDAOProduto.SetDataClass;
    AStrings.AddObject(
      self.getDAOProduto.PersistentObject.Descricao+ ' - Valor Unitário: '+
      FormatFloat('#,##0.00', self.getDAOProduto.PersistentObject.PrecoVenda),
      self.getDAOProduto.PersistentObject);
    Self.getDAOProduto.DataSetAllData.Next;
  end;
end;

end.
