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
  object pgqDelete: TPgQuery
    Connection = pgcDBconnection
    Left = 67
    Top = 214
  end
  object pgqGetUsers: TPgQuery
    Connection = pgcDBconnection
    SQL.Strings = (
      'SELECT * FROM tbl_gebruikers')
    Left = 64
    Top = 304
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
    Left = 64
    Top = 392
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
end
