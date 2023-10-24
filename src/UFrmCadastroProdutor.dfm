inherited FrmCadastroProdutor: TFrmCadastroProdutor
  Caption = 'Cadastro Produtor'
  ClientHeight = 193
  ExplicitHeight = 232
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar1: TStatusBar
    Top = 174
    ExplicitLeft = 0
    ExplicitTop = 279
    ExplicitWidth = 582
  end
  inherited Panel1: TPanel
    Top = 118
    ExplicitTop = 223
    ExplicitWidth = 582
  end
  object EdtNome: TLabeledEdit
    Left = 16
    Top = 24
    Width = 555
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome'
    TabOrder = 2
  end
  object EdtCPFCNPJ: TLabeledEdit
    Left = 16
    Top = 72
    Width = 555
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = 'CPF/CNPJ'
    TabOrder = 3
  end
end
