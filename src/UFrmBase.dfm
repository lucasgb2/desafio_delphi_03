object FrmBase: TFrmBase
  Left = 0
  Top = 0
  ActiveControl = EdtId
  Caption = 'FrmBase'
  ClientHeight = 298
  ClientWidth = 582
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 279
    Width = 582
    Height = 19
    Panels = <>
  end
  object pnlControles: TPanel
    Left = 0
    Top = 223
    Width = 582
    Height = 56
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      582
      56)
    object Button1: TButton
      Left = 96
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 495
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Sair'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 15
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop]
      Caption = 'Alterar'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object pnlCodigo: TPanel
    Left = 0
    Top = 0
    Width = 582
    Height = 57
    Align = alTop
    TabOrder = 2
    object EdtId: TLabeledEdit
      Left = 24
      Top = 23
      Width = 121
      Height = 21
      EditLabel.Width = 33
      EditLabel.Height = 13
      EditLabel.Caption = 'C'#243'digo'
      NumbersOnly = True
      TabOrder = 0
      OnExit = EdtIdExit
    end
  end
  object pnlCampos: TPanel
    Left = 0
    Top = 57
    Width = 582
    Height = 166
    Align = alClient
    TabOrder = 3
  end
end
