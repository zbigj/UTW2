object DataModule2: TDataModule2
  OldCreateOrder = False
  Height = 392
  Width = 791
  object linkDB: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=E:\Delphi 10\project\UTW\UTW2.FDB'
      'DriverID=FB')
    Left = 32
    Top = 16
  end
  object kursanciDS: TDataSource
    DataSet = kursanciQuery
    Left = 432
    Top = 256
  end
  object kursanciQuery: TFDQuery
    Connection = linkDB
    SQL.Strings = (
      
        'select k.nazwisko,k.imie,k.dataur,k.email,k.telefon1,kr.nazwa,m.' +
        'nazwa,k.ulica,k.nrdomu,k.nrlokalu,k.pesel,k.plec,k.nrdowos, k.id' +
        '_kursant, g.nazwa , k.ulica|| '#39' '#39' || k.nrDomu || '#39' / '#39' || k.nrLo' +
        'kalu'
      
        'from kursant k join miasto m on k.id_miasto=m.id_miasto join kra' +
        'j kr on k.id_kraj=kr.id_kraj '
      
        'join wyksztalcenie w on k.id_wyksztalcenie=w.id_wyksztalcenie jo' +
        'in grupaInwalidzka g on g.id_grupaInwalidzka=k.id_grupaInwalidzk' +
        'a order by k.nazwisko')
    Left = 296
    Top = 256
  end
  object HistoriaWplatQuery: TFDQuery
    MasterSource = kursanciDS
    MasterFields = 'ID_KURSANT'
    Connection = linkDB
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      
        'select w.czaswplaty,w.kwota,w.tytulwplaty from wplata w where w.' +
        'id_kursant=:id_kursant  order by w.czaswplaty')
    Left = 296
    Top = 40
    ParamData = <
      item
        Name = 'ID_KURSANT'
        DataType = ftInteger
        ParamType = ptInput
        Value = 19
      end>
  end
  object historiaWplatDS: TDataSource
    DataSet = HistoriaWplatQuery
    Left = 432
    Top = 40
  end
  object obecneZajeciaQuery: TFDQuery
    MasterSource = kursanciDS
    MasterFields = 'ID_KURSANT'
    Connection = linkDB
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      
        'select k.nazwa,u.oplatazakurs-coalesce(w.kwota,0) from uczestnic' +
        'twoWKursie u join semestrzajec s on u.id_semestrzajec=s.id_semes' +
        'trzajec join kurs k on s.id_kurs=k.id_kurs left outer join wplat' +
        'a w on w.id_uczestnictwowkursie=u.id_uczestnictwowkursie where u' +
        '.id_kursant=:id_kursant')
    Left = 296
    Top = 88
    ParamData = <
      item
        Name = 'ID_KURSANT'
        DataType = ftInteger
        ParamType = ptInput
        Value = 19
      end>
  end
  object obecneZajeciaDS: TDataSource
    DataSet = obecneZajeciaQuery
    Left = 432
    Top = 88
  end
  object SemestryQuery: TFDQuery
    MasterSource = kursanciDS
    MasterFields = 'ID_KURSANT'
    Connection = linkDB
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      
        'select s.nazwa, s.kwota-coalesce(w.kwota,0) from oplatazasemestr' +
        ' o join semestr s on o.id_semestr=s.id_semestr left outer join w' +
        'plata w on o.id_kursant=w.id_kursant and o.id_semestr=w.id_semes' +
        'tr where w.id_uczestnictwowkursie is null and o.id_kursant=:id_k' +
        'ursant')
    Left = 296
    Top = 144
    ParamData = <
      item
        Name = 'ID_KURSANT'
        DataType = ftInteger
        ParamType = ptInput
        Value = 19
      end>
  end
  object SemestryDS: TDataSource
    DataSet = SemestryQuery
    Left = 432
    Top = 144
  end
  object operatorzyQuery: TFDQuery
    Connection = linkDB
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      
        'select o.nazwiskoIImie, o.id_operator from operator o order by o' +
        '.nazwiskoIImie')
    Left = 296
    Top = 200
  end
  object operatorzyDS: TDataSource
    DataSet = operatorzyQuery
    Left = 432
    Top = 200
  end
  object scratchQuery: TFDQuery
    Connection = linkDB
    Left = 304
    Top = 312
  end
end
