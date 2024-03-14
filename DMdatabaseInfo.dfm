object DataModule2: TDataModule2
  OnDestroy = DataModuleDestroy
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object pgcDBconnection: TPgConnection
    Username = 'stage2'
    Server = '142.132.213.151'
    LoginPrompt = False
    Database = 'rchat'
    Connected = True
    Left = 120
    Top = 120
    EncryptedPassword = 'CDFFACFF8BFF9EFF98FF9AFFD5FF'
  end
  object pgqGetUser: TPgQuery
    Connection = pgcDBconnection
    Left = 200
    Top = 208
  end
end
