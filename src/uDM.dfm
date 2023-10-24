object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 275
  Width = 491
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Workspace\Desafio\desafio_delphi_03\data\DATABASE.FD' +
        'B'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=127.0.0.1'
      'Port=3050'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 96
    Top = 88
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 192
    Top = 88
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 304
    Top = 88
  end
end
