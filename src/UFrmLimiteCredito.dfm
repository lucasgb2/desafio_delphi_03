inherited frmLimiteCredito: TfrmLimiteCredito
  ActiveControl = nil
  Caption = 'Limite Cr'#233'dito Produtor X Distribuidor'
  ClientWidth = 583
  ExplicitWidth = 599
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar1: TStatusBar
    Width = 583
    ExplicitWidth = 583
  end
  inherited pnlControles: TPanel
    Width = 583
    ExplicitWidth = 583
    inherited Button2: TButton [0]
      Left = 496
      ExplicitLeft = 496
    end
    inherited Button3: TButton [1]
    end
    inherited Button1: TButton [2]
      Left = 15
      ExplicitLeft = 15
    end
  end
  inherited pnlCodigo: TPanel
    Width = 583
    Visible = False
    ExplicitWidth = 583
    inherited EdtId: TLabeledEdit
      Left = 15
      Top = 19
      EditLabel.ExplicitLeft = 15
      EditLabel.ExplicitTop = 3
      EditLabel.ExplicitWidth = 33
      ExplicitLeft = 15
      ExplicitTop = 19
    end
  end
  inherited pnlCampos: TPanel
    Width = 583
    ExplicitWidth = 583
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
    object cbxDistribuidor: TComboBox
      Left = 12
      Top = 24
      Width = 469
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 0
      OnChange = cbxDistribuidorChange
    end
    object cbxProdutor: TComboBox
      Left = 12
      Top = 67
      Width = 469
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 1
      OnChange = cbxDistribuidorChange
    end
    object EdtLimiteCredito: TLabeledEdit
      Left = 12
      Top = 112
      Width = 141
      Height = 21
      EditLabel.Width = 65
      EditLabel.Height = 13
      EditLabel.BiDiMode = bdLeftToRight
      EditLabel.Caption = 'Limite Cr'#233'dito'
      EditLabel.ParentBiDiMode = False
      TabOrder = 2
      Text = '0,00'
      OnExit = EdtLimiteCreditoExit
      OnKeyPress = EdtLimiteCreditoKeyPress
    end
  end
end
