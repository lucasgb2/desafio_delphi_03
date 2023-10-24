unit UFactoryObject;

interface

uses
  UProduto, UDAOProduto;

type
  TFactoryObject = class

  public
    class function CreateProduto(): TProduto;
  end;

implementation

{ TFactoryObject }

class function TFactoryObject.CreateProduto: TProduto;
var
  produto: TProduto;
begin
  produto := TProduto.Create;

end;

end.
