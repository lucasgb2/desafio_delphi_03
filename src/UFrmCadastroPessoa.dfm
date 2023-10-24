inherited FrmCadastroPessoa: TFrmCadastroPessoa
  Caption = 'Cadastro Pessoa'
  ClientHeight = 234
  OnClose = FormClose
  ExplicitHeight = 273
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar1: TStatusBar
    Top = 215
    ExplicitTop = 215
  end
  inherited pnlControles: TPanel
    Top = 159
    ExplicitTop = 159
  end
  inherited pnlCampos: TPanel
    Height = 102
    ExplicitHeight = 102
    object EdtCPFCNPJ: TLabeledEdit
      Left = 24
      Top = 24
      Width = 214
      Height = 21
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = 'CPF/CNPJ'
      MaxLength = 14
      NumbersOnly = True
      TabOrder = 0
    end
    object EdtNome: TLabeledEdit
      Left = 24
      Top = 68
      Width = 547
      Height = 21
      EditLabel.Width = 27
      EditLabel.Height = 13
      EditLabel.Caption = 'Nome'
      TabOrder = 1
    end
  end
end
