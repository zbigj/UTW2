object DataModule2: TDataModule2
  OldCreateOrder = False
  Height = 392
  Width = 791
  object linkDB: TFDConnection
    Left = 32
    Top = 16
  end
  object FDQuery1: TFDQuery
    Connection = linkDB
    Left = 120
    Top = 32
  end
  object DataSource1: TDataSource
    Left = 200
    Top = 32
  end
end
