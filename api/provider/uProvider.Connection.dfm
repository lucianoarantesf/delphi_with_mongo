object ProviderConnection: TProviderConnection
  Height = 168
  Width = 368
  object dbsConnection: TFDConnection
    Params.Strings = (
      'Server=LOCALHOST'
      'DriverID=Mongo')
    LoginPrompt = False
    Left = 32
    Top = 40
  end
  object FDPhysMongoDriverLink: TFDPhysMongoDriverLink
    Left = 240
    Top = 32
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 104
    Top = 8
  end
end
