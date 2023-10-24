unit UDAOBase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDAOBase = class
  private
    FQuery: TFDQuery;
    FTable: String;
    FFieldKey: String;
    procedure SetTable(const Value: String);
    procedure SetFieldKey(const Value: String);

  protected
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
    procedure ConfigureFieldKey(const AQuery: TFDQuery; AFieldName: String);

  public
    property Table:String read FTable write SetTable;
    property FieldKey:String read FFieldKey write SetFieldKey;
    function GetQuery():TFDQuery;
    function GetNewQuery():TFDQuery;
    function GetQueryLoad(AKeyValue: String):Boolean;
    function getValue(AField: String):TField;
    function Save: Boolean; virtual;
    procedure Delete; virtual;
    procedure SetDataClass; virtual; abstract;
    procedure LoadAll;
    function DataSetAllData:TDataSet;
    procedure DeleteAll(const Query: TFDQuery);

  end;

implementation
uses
  UDM;

{ TDAOBase }

procedure TDAOBase.Commit;
begin
  DM.FDConnection1.Transaction.Commit;
end;

procedure TDAOBase.ConfigureFieldKey(const AQuery: TFDQuery;
  AFieldName: String);
begin
  AQuery.FieldByName(AFieldName).Required := false;
  AQuery.FieldByName(AFieldName).ReadOnly := true;
  AQuery.FieldByName(AFieldName).AutoGenerateValue := TAutoRefreshFlag.arAutoInc;
end;

function TDAOBase.DataSetAllData: TDataSet;
begin
  Result := Self.GetQuery;
end;

procedure TDAOBase.Delete;
begin
  if not self.GetQuery.IsEmpty then
  begin
    self.GetQuery.Delete;
    self.GetQuery.ApplyUpdates();
  end;
end;

procedure TDAOBase.DeleteAll(const Query: TFDQuery);
begin
  Query.First;
  while not Query.Eof do
  begin
    Query.Delete;
    Query.Next;
  end;
end;

function TDAOBase.GetNewQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.CachedUpdates := True;
  Result.Connection := DM.FDConnection1;
end;

function TDAOBase.GetQuery: TFDQuery;
begin
  if Self.FQuery = nil then
  begin
    Self.FQuery := TFDQuery.Create(nil);
    Self.FQuery.CachedUpdates := True;
    Self.FQuery.Connection := DM.FDConnection1;
  end;

  Result := Self.FQuery;
end;

function TDAOBase.GetQueryLoad(AKeyValue: String): Boolean;
begin
  Self.GetQuery.Close;
  Self.GetQuery.SQL.Clear;
  Self.GetQuery.SQL.Add('select * from '+self.Table+' where '+Self.FieldKey+' = '+AKeyValue);
  Self.GetQuery.Open();

  {Para funcionar autoinc, se faz necessário os campo chave na query ter estas prop. alteradas}
  Self.ConfigureFieldKey(self.GetQuery, Self.FieldKey);

  Result := not Self.GetQuery.IsEmpty;
end;

function TDAOBase.getValue(AField: String): TField;
begin
  Result := Self.GetQuery.FieldByName(AField);
end;

procedure TDAOBase.LoadAll;
begin
  Self.GetQuery.Close;
  Self.GetQuery.SQL.Clear;
  Self.GetQuery.SQL.Add('select * from '+self.Table);
  Self.GetQuery.Open();
end;

procedure TDAOBase.Rollback;
begin
  DM.FDConnection1.Transaction.Rollback;
end;

function TDAOBase.Save: Boolean;
begin
  if self.GetQuery.IsEmpty then
    self.GetQuery.Insert
  else
    self.GetQuery.Edit;
  Result := True;
end;

procedure TDAOBase.SetFieldKey(const Value: String);
begin
  FFieldKey := Value;
end;

procedure TDAOBase.SetTable(const Value: String);
begin
  FTable := Value;
end;

procedure TDAOBase.StartTransaction;
begin
  DM.FDConnection1.Transaction.StartTransaction;
end;

end.
