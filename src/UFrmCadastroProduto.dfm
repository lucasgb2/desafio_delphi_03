inherited FrmCadastroProduto: TFrmCadastroProduto
  Caption = 'Cadastro Produto'
  ClientHeight = 247
  OnClose = FormClose
  OnCreate = FormCreate
  ExplicitHeight = 286
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar1: TStatusBar
    Top = 228
    ExplicitTop = 228
  end
  inherited pnlControles: TPanel
    Top = 172
  end
  inherited pnlCodigo: TPanel
    inherited EdtId: TLabeledEdit
      NumbersOnly = True
      OnExit = EdtIdExit
    end
  end
  inherited pnlCampos: TPanel
    Height = 115
    ExplicitLeft = 0
    ExplicitTop = 57
    ExplicitWidth = 582
    ExplicitHeight = 166
    object EdtDescricao: TLabeledEdit
      Left = 24
      Top = 20
      Width = 547
      Height = 21
      EditLabel.Width = 46
      EditLabel.Height = 13
      EditLabel.Caption = 'Descri'#231#227'o'
      MaxLength = 100
      TabOrder = 0
    end
    object EdtPrecoVenda: TLabeledEdit
      Left = 24
      Top = 64
      Width = 214
      Height = 21
      EditLabel.Width = 75
      EditLabel.Height = 13
      EditLabel.BiDiMode = bdLeftToRight
      EditLabel.Caption = 'Pre'#231'o de Venda'
      EditLabel.ParentBiDiMode = False
      TabOrder = 1
      Text = '0,00'
      OnExit = EdtPrecoVendaExit
      OnKeyPress = EdtPrecoVendaKeyPress
    end
  end
end
