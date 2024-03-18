object DataModule2: TDataModule2
  OnDestroy = DataModuleDestroy
  Height = 614
  Width = 930
  PixelsPerInch = 120
  object pgcDBconnection: TPgConnection
    Username = 'stage2'
    Server = '142.132.213.151'
    LoginPrompt = False
    Database = 'rchat'
    Connected = True
    Left = 64
    Top = 40
    EncryptedPassword = 'CDFFACFF8BFF9EFF98FF9AFFD5FF'
  end
  object pgqGetLoggedInUser: TPgQuery
    Connection = pgcDBconnection
    Left = 64
    Top = 120
  end
end
