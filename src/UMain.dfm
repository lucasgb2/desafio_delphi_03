object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Controle Negocia'#231#227'o'
  ClientHeight = 299
  ClientWidth = 635
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 280
    Width = 635
    Height = 19
    Panels = <>
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 16
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Produtor1: TMenuItem
        Caption = '&Produtor'
        OnClick = Produtor1Click
      end
      object Produto1: TMenuItem
        Caption = 'P&roduto'
        OnClick = Produto1Click
      end
      object Fornecedor1: TMenuItem
        Caption = '&Distribuidor'
        OnClick = Fornecedor1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object LimiteCrditoXFornecedor1: TMenuItem
        Caption = 'Limite Cr'#233'dito X Distribuidor'
        OnClick = LimiteCrditoXFornecedor1Click
      end
    end
    object Sair1: TMenuItem
      Caption = 'Negocia'#231#227'o'
      object GerenciarNegociaes1: TMenuItem
        Caption = 'Gerenciar &Negocia'#231#245'es'
        OnClick = GerenciarNegociaes1Click
      end
    end
    object Sair2: TMenuItem
      Caption = '&Sair'
      OnClick = Sair2Click
    end
  end
end
