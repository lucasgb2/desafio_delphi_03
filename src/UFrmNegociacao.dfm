inherited frmNegociacao: TfrmNegociacao
  ActiveControl = nil
  Caption = 'Negocia'#231#227'o'
  ClientHeight = 504
  ClientWidth = 823
  ExplicitWidth = 839
  ExplicitHeight = 543
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar1: TStatusBar
    Top = 485
    Width = 823
    Panels = <
      item
        Text = '[CTRL + DEL] Remover produto'
        Width = 50
      end>
    ExplicitTop = 485
    ExplicitWidth = 823
  end
  inherited pnlControles: TPanel
    Top = 429
    Width = 823
    ExplicitTop = 429
    ExplicitWidth = 823
    inherited Button3: TButton [0]
      Left = 8
      Visible = False
      ExplicitLeft = 8
    end
    inherited Button1: TButton [1]
      Left = 8
      ExplicitLeft = 8
    end
    inherited Button2: TButton [2]
      Left = 736
      ExplicitLeft = 736
    end
  end
  inherited pnlCodigo: TPanel
    Width = 823
    Visible = False
    ExplicitWidth = 823
    inherited EdtId: TLabeledEdit
      Left = 12
      EditLabel.ExplicitLeft = 12
      EditLabel.ExplicitTop = 7
      EditLabel.ExplicitWidth = 33
      ExplicitLeft = 12
    end
  end
  inherited pnlCampos: TPanel
    Width = 823
    Height = 144
    Align = alTop
    ExplicitWidth = 823
    ExplicitHeight = 144
    object Label1: TLabel
      Left = 12
      Top = 8
      Width = 54
      Height = 13
      Caption = 'Distribuidor'
    end
    object Label2: TLabel
      Left = 12
      Top = 51
      Width = 42
      Height = 13
      Caption = 'Produtor'
    end
    object Produto: TLabel
      Left = 12
      Top = 99
      Width = 42
      Height = 13
      Caption = 'Produtor'
    end
    object spin: TLabel
      Left = 583
      Top = 99
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object Label3: TLabel
      Left = 500
      Top = 8
      Width = 41
      Height = 13
      Caption = 'Situa'#231#227'o'
    end
    object cbxDistribuidor: TComboBox
      Left = 12
      Top = 24
      Width = 469
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 0
    end
    object cbxProdutor: TComboBox
      Left = 12
      Top = 67
      Width = 469
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 1
    end
    object cbxProduto: TComboBox
      Left = 12
      Top = 115
      Width = 565
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 2
    end
    object spnQuantidade: TSpinEdit
      Left = 583
      Top = 115
      Width = 121
      Height = 22
      MaxValue = 999
      MinValue = 1
      TabOrder = 3
      Value = 1
    end
    object btnAdicionar: TButton
      Left = 710
      Top = 113
      Width = 96
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 4
      OnClick = btnAdicionarClick
    end
    object cbxSituacao: TComboBox
      Left = 500
      Top = 24
      Width = 306
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 5
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 201
    Width = 823
    Height = 187
    Align = alClient
    DataSource = dsProdutos
    Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'idproduto'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Descri'#231#227'o'
        Width = 393
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'quantidade'
        Title.Caption = 'Quantidade'
        Width = 103
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'precounitario'
        Title.Caption = 'Unit'#225'rio'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'total'
        Title.Caption = 'Total Produto'
        Width = 119
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 388
    Width = 823
    Height = 41
    Align = alBottom
    TabOrder = 5
    object edtTotalGeral: TEdit
      AlignWithMargins = True
      Left = 658
      Top = 4
      Width = 161
      Height = 33
      Align = alRight
      Alignment = taRightJustify
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Text = '0.00'
    end
  end
  object cdsProdutos: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    AfterDelete = cdsProdutosAfterDelete
    OnCalcFields = cdsProdutosCalcFields
    Left = 656
    Top = 312
    object cdsProdutosidproduto: TIntegerField
      FieldName = 'idproduto'
    end
    object cdsProdutosdescricao: TStringField
      FieldName = 'descricao'
      Size = 50
    end
    object cdsProdutosquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object cdsProdutostotal: TFloatField
      FieldName = 'total'
    end
    object cdsProdutosprecounitario: TFloatField
      FieldName = 'precounitario'
    end
    object cdsProdutostotalgeral: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'totalgeral'
    end
    object cdsProdutostotalgeralagregate: TAggregateField
      FieldName = 'totalgeralagregate'
      Active = True
      DisplayName = ''
      Expression = 'SUM(totalgeral)'
    end
  end
  object dsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 736
    Top = 312
  end
end
