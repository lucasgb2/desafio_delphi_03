object DMReport: TDMReport
  OldCreateOrder = False
  Height = 355
  Width = 531
  object frxNegociacao: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45220.472225949070000000
    ReportOptions.LastChange = 45222.824425185190000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 168
    Top = 96
    Datasets = <
      item
        DataSet = frxdsNegociacao
        DataSetName = 'dsNegociacao'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 26.456710000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 257.008040000000000000
          Top = 1.000000000000000000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Relat'#243'rio de Negocia'#231#245'es')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Align = baRight
          Left = 600.945270000000000000
          Top = 3.779530000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] [Time]'
            '')
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 105.826840000000000000
        Width = 755.906000000000000000
        object Memo2: TfrxMemoView
          Left = 2.779530000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Negociacao')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 79.370130000000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Produtor')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 257.008040000000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Distribuidor')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 434.645950000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cadastro')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 600.945270000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data Situ.')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 510.236550000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Situa'#231#227'o')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 676.535870000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 151.181200000000000000
        Width = 755.906000000000000000
        DataSet = frxdsNegociacao
        DataSetName = 'dsNegociacao'
        RowCount = 0
        object dsNegociacaoprodutor: TfrxMemoView
          Left = 79.370130000000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          DataField = 'Produtor'
          DataSet = frxdsNegociacao
          DataSetName = 'dsNegociacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsNegociacao."Produtor"]')
          ParentFont = False
        end
        object dsNegociacaocontrato: TfrxMemoView
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'Negocia'#231#227'o'
          DataSet = frxdsNegociacao
          DataSetName = 'dsNegociacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsNegociacao."Negocia'#231#227'o"]')
          ParentFont = False
        end
        object dsNegociacaodistribuidor: TfrxMemoView
          Left = 257.008040000000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          DataField = 'Distribuidor'
          DataSet = frxdsNegociacao
          DataSetName = 'dsNegociacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsNegociacao."Distribuidor"]')
          ParentFont = False
        end
        object dsNegociacaodataCadastro: TfrxMemoView
          Left = 434.645950000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'Data Inclus'#227'o'
          DataSet = frxdsNegociacao
          DataSetName = 'dsNegociacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsNegociacao."Data Inclus'#227'o"]')
          ParentFont = False
        end
        object dsNegociacaodataAprovacao: TfrxMemoView
          Left = 510.236550000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Situa'#231#227'o'
          DataSet = frxdsNegociacao
          DataSetName = 'dsNegociacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsNegociacao."Situa'#231#227'o"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 600.945270000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DataField = 'Data situa'#231#227'o'
          DataSet = frxdsNegociacao
          DataSetName = 'dsNegociacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsNegociacao."Data situa'#231#227'o"]')
          ParentFont = False
        end
        object dsNegociacaovalortotal: TfrxMemoView
          Left = 672.756340000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DataSet = frxdsNegociacao
          DataSetName = 'dsNegociacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[dsNegociacao."Total"]')
          ParentFont = False
        end
      end
    end
  end
  object datasourceNegociacao: TDataSource
    DataSet = cdsFake
    Left = 168
    Top = 152
  end
  object cdsFake: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 96
    object cdsFakeProdutor: TStringField
      FieldName = 'Produtor'
      Size = 30
    end
    object cdsFakeDistribuidor: TStringField
      FieldName = 'Distribuidor'
      Size = 30
    end
    object cdsFakeNegociação: TIntegerField
      FieldName = 'Negocia'#231#227'o'
    end
    object cdsFakeDatasituação: TStringField
      FieldName = 'Data situa'#231#227'o'
    end
    object cdsFakeTotal: TFloatField
      FieldName = 'Total'
    end
    object cdsFakeSituação: TStringField
      FieldName = 'Situa'#231#227'o'
    end
    object cdsFakeDataInclusão: TStringField
      FieldName = 'Data Inclus'#227'o'
    end
  end
  object frxdsNegociacao: TfrxDBDataset
    UserName = 'dsNegociacao'
    CloseDataSource = False
    FieldAliases.Strings = (
      'Produtor=Produtor'
      'Distribuidor=Distribuidor'
      'Negocia'#231#227'o=Negocia'#231#227'o'
      'Data situa'#231#227'o=Data situa'#231#227'o'
      'Total=Total'
      'Situa'#231#227'o=Situa'#231#227'o'
      'Data Inclus'#227'o=Data Inclus'#227'o')
    DataSource = datasourceNegociacao
    BCDToCurrency = False
    Left = 168
    Top = 216
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 408
    Top = 32
    object StringField1: TStringField
      FieldName = 'produtor'
      Size = 50
    end
    object StringField2: TStringField
      FieldName = 'distribuidor'
      Size = 50
    end
    object DateField1: TDateField
      FieldName = 'dataCadastro'
    end
    object FloatField1: TFloatField
      FieldName = 'valortotal'
    end
    object DateField2: TDateField
      FieldName = 'dataSituacao'
    end
    object StringField3: TStringField
      FieldName = 'situacao'
      Size = 15
    end
    object IntegerField1: TIntegerField
      FieldName = 'negociacaocodigo'
    end
  end
end
