unit UDMReport;

interface

uses
  System.SysUtils, System.Classes, Data.DB, frxClass, frxDBSet,
  Datasnap.DBClient;

type
  TDMReport = class(TDataModule)
    frxNegociacao: TfrxReport;
    datasourceNegociacao: TDataSource;
    cdsFake: TClientDataSet;
    frxdsNegociacao: TfrxDBDataset;
    ClientDataSet1: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    DateField1: TDateField;
    FloatField1: TFloatField;
    DateField2: TDateField;
    StringField3: TStringField;
    IntegerField1: TIntegerField;
    cdsFakeProdutor: TStringField;
    cdsFakeDistribuidor: TStringField;
    cdsFakeNegociação: TIntegerField;
    cdsFakeDatasituação: TStringField;
    cdsFakeTotal: TFloatField;
    cdsFakeSituação: TStringField;
    cdsFakeDataInclusão: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowReport(ADataSet: TDataSet);
  end;

var
  DMReport: TDMReport;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TDMReport.ShowReport(ADataSet: TDataSet);
begin
  frxdsNegociacao.DataSet := ADataSet;
  frxNegociacao.ShowReport();
end;

end.
