object DataModule2: TDataModule2
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 614
  Width = 930
  PixelsPerInch = 120
  object pgcDBconnection: TPgConnection
    Username = 'stage2'
    Server = '142.132.213.151'
    LoginPrompt = False
    AfterDisconnect = pgcDBconnectionAfterDisconnect
    OnConnectionLost = pgcDBconnectionConnectionLost
    Database = 'rchat'
    Options.Charset = 'UTF8'
    Connected = True
    Left = 64
    Top = 8
    EncryptedPassword = 'CDFFACFF8BFF9EFF98FF9AFFD5FF'
  end
  object pgqGetLoggedInUser: TPgQuery
    Connection = pgcDBconnection
    Left = 64
    Top = 88
  end
  object pgqDelete: TPgQuery
    Connection = pgcDBconnection
    Left = 67
    Top = 182
  end
  object pgqGetUsers: TPgQuery
    Connection = pgcDBconnection
    SQL.Strings = (
      'SELECT * FROM tbl_gebruikers')
    FetchRows = 100
    Left = 64
    Top = 272
    object pgqGetUsersgbr_id: TIntegerField
      FieldName = 'gbr_id'
    end
    object pgqGetUsersgbr_naam: TStringField
      FieldName = 'gbr_naam'
      Required = True
      Size = 35
    end
    object pgqGetUsersgbr_winkelnaam: TStringField
      FieldName = 'gbr_winkelnaam'
      Required = True
      Size = 75
    end
    object pgqGetUsersgbr_tel: TStringField
      FieldName = 'gbr_tel'
      Required = True
      Size = 15
    end
    object pgqGetUsersgbr_email: TStringField
      FieldName = 'gbr_email'
      Required = True
      Size = 75
    end
    object pgqGetUsersgbr_nicknaam: TStringField
      FieldName = 'gbr_nicknaam'
      Required = True
      Size = 50
    end
    object pgqGetUsersgbr_wachtwoord: TStringField
      FieldName = 'gbr_wachtwoord'
      Required = True
      FixedChar = True
      Size = 65
    end
  end
  object pgqGetGroups: TPgQuery
    Connection = pgcDBconnection
    SQL.Strings = (
      'SELECT * FROM tbl_groepen')
    FetchRows = 100
    Options.ReturnParams = True
    Left = 224
    Top = 272
    object pgqGetGroupsgro_id: TIntegerField
      FieldName = 'gro_id'
    end
    object pgqGetGroupsgro_naam: TStringField
      FieldName = 'gro_naam'
      Required = True
      Size = 75
    end
    object pgqGetGroupsgro_igenaar: TIntegerField
      FieldName = 'gro_igenaar'
      Required = True
    end
    object pgqGetGroupsgro_aangemaakt: TDateTimeField
      FieldName = 'gro_aangemaakt'
      Required = True
    end
    object pgqGetGroupsgro_del: TBooleanField
      FieldName = 'gro_del'
      Required = True
    end
    object pgqGetGroupsgro_profielfoto: TBlobField
      FieldName = 'gro_profielfoto'
    end
    object pgqGetGroupsgro_beschrijving: TMemoField
      FieldName = 'gro_beschrijving'
      BlobType = ftMemo
    end
  end
  object pgqCheckExistingUser: TPgQuery
    Connection = pgcDBconnection
    Left = 67
    Top = 362
  end
  object pgqGetSelectedGroup: TPgQuery
    Connection = pgcDBconnection
    Left = 224
    Top = 360
  end
  object pgqGetSelectedGroupOwner: TPgQuery
    Connection = pgcDBconnection
    Left = 224
    Top = 448
  end
  object pgqGetGroupMembers: TPgQuery
    Connection = pgcDBconnection
    Left = 224
    Top = 536
  end
  object tmrLogin: TTimer
    Interval = 1
    OnTimer = tmrLoginTimer
    Left = 224
    Top = 8
  end
  object pgqGetSelectedLog: TPgQuery
    Connection = pgcDBconnection
    Left = 224
    Top = 184
  end
  object pgqGetAllLogs: TPgQuery
    Connection = pgcDBconnection
    Left = 224
    Top = 88
  end
  object pgqSearchUser: TPgQuery
    Connection = pgcDBconnection
    FetchRows = 100
    Left = 64
    Top = 448
  end
  object pgqGroepsleden: TPgQuery
    Connection = pgcDBconnection
    Left = 64
    Top = 536
  end
end
