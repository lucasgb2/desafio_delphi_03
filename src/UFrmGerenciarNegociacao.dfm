object FrmGerenciarNegociacoes: TFrmGerenciarNegociacoes
  Left = 0
  Top = 0
  ActiveControl = btnNovo
  Caption = 'Gerenciar Negocia'#231#245'es'
  ClientHeight = 392
  ClientWidth = 818
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlControles: TPanel
    Left = 0
    Top = 336
    Width = 818
    Height = 56
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 342
    DesignSize = (
      818
      56)
    object btnAlterar: TButton
      Left = 93
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Alterar'
      TabOrder = 0
      OnClick = btnAlterarClick
    end
    object btnSair: TButton
      Left = 731
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Sair'
      TabOrder = 1
      OnClick = btnSairClick
    end
    object btnNovo: TButton
      Left = 12
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop]
      Caption = 'Nova'
      TabOrder = 2
      OnClick = btnNovoClick
    end
    object btnImprimir: TButton
      Left = 254
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Imprimir'
      TabOrder = 3
      OnClick = btnImprimirClick
    end
    object btnAlterarSituacao: TButton
      Left = 335
      Top = 16
      Width = 138
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Alterar Situa'#231#227'o'
      TabOrder = 4
      OnClick = btnAlterarSituacaoClick
    end
    object btnRemover: TButton
      Left = 174
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Remover'
      TabOrder = 5
      OnClick = btnRemoverClick
    end
  end
  object gridNegociacao: TDBGrid
    Left = 0
    Top = 113
    Width = 818
    Height = 223
    Align = alClient
    DataSource = dsNegociacao
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 818
    Height = 113
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 12
      Top = 24
      Width = 54
      Height = 13
      Caption = 'Distribuidor'
    end
    object Label2: TLabel
      Left = 12
      Top = 67
      Width = 42
      Height = 13
      Caption = 'Produtor'
    end
    object Label3: TLabel
      Left = 500
      Top = 24
      Width = 41
      Height = 13
      Caption = 'Situa'#231#227'o'
    end
    object Label4: TLabel
      Left = 12
      Top = 4
      Width = 32
      Height = 16
      Caption = 'Filtro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbxDistribuidor: TComboBox
      Left = 12
      Top = 40
      Width = 469
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 0
      OnChange = cbxDistribuidorChange
    end
    object cbxProdutor: TComboBox
      Left = 12
      Top = 83
      Width = 469
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 1
      OnChange = cbxProdutorChange
    end
    object cbxSituacao: TComboBox
      Left = 500
      Top = 40
      Width = 306
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 2
      OnChange = cbxSituacaoChange
    end
  end
  object dsNegociacao: TDataSource
    Left = 624
    Top = 208
  end
  object popSituacao: TPopupMenu
    Left = 528
    Top = 208
    object Pendente1: TMenuItem
      Caption = 'Pendente'
      OnClick = Pendente1Click
    end
    object Aprovada1: TMenuItem
      Caption = 'Aprovada'
      OnClick = Aprovada1Click
    end
    object Cancelada1: TMenuItem
      Caption = 'Cancelada'
      OnClick = Cancelada1Click
    end
    object Finalizada1: TMenuItem
      Caption = 'Conclu'#237'da'
      OnClick = Finalizada1Click
    end
  end
end
