object StoreForm: TStoreForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1052#1072#1075#1072#1079#1080#1085
  ClientHeight = 375
  ClientWidth = 529
  Color = clBtnFace
  Constraints.MaxHeight = 413
  Constraints.MaxWidth = 541
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object TitleLabel: TLabel
    Left = 220
    Top = 15
    Width = 89
    Height = 25
    Hint = #1052#1072#1075#1072#1079#1080#1085' :)'
    Caption = #1052#1040#1043#1040#1047#1048#1053
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object StoreFontPBox: TPaintBox
    Left = 15
    Top = 52
    Width = 498
    Height = 307
    Constraints.MaxHeight = 307
    Constraints.MaxWidth = 498
    OnPaint = StoreFontPBoxPaint
  end
  object BackGroundHP: TVirtualImage
    Left = 50
    Top = 67
    Width = 76
    Height = 112
    ImageCollection = TaskListForm.BackgroundImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 5
    ImageName = 'STOREFONE'
  end
  object FreeHP: TVirtualImage
    Left = 58
    Top = 79
    Width = 60
    Height = 85
    Hint = #1041#1091#1090#1099#1083#1105#1082' '#1079#1076#1086#1088#1086#1074#1100#1103'. '#1052#1086#1084#1077#1085#1090#1072#1083#1100#1085#1086' '#1091#1074#1077#1083#1080#1095#1080#1090' '#1074#1072#1096#1077' '#1079#1076#1086#1088#1086#1074#1100#1077'.'
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 0
    ImageName = 'HEALTHBUFF'
    ParentShowHint = False
    ShowHint = True
  end
  object BackGroundTothem: TVirtualImage
    Left = 167
    Top = 208
    Width = 76
    Height = 112
    ImageCollection = TaskListForm.BackgroundImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 5
    ImageName = 'STOREFONE'
  end
  object TothemBust: TVirtualImage
    Left = 176
    Top = 222
    Width = 60
    Height = 85
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 5
    ImageName = 'TOTEM'
    ParentShowHint = False
    ShowHint = True
  end
  object BackGroundHPBust: TVirtualImage
    Left = 284
    Top = 67
    Width = 76
    Height = 112
    ImageCollection = TaskListForm.BackgroundImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 5
    ImageName = 'STOREFONE'
  end
  object BackGroundXPbust: TVirtualImage
    Left = 401
    Top = 67
    Width = 76
    Height = 112
    ImageCollection = TaskListForm.BackgroundImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 5
    ImageName = 'STOREFONE'
  end
  object BackGoundCoins: TVirtualImage
    Left = 50
    Top = 208
    Width = 76
    Height = 112
    ImageCollection = TaskListForm.BackgroundImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 5
    ImageName = 'STOREFONE'
  end
  object BackGroundSecretBox: TVirtualImage
    Left = 401
    Top = 208
    Width = 76
    Height = 112
    ImageCollection = TaskListForm.BackgroundImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 5
    ImageName = 'STOREFONE'
  end
  object BackGroundFreeTask: TVirtualImage
    Left = 284
    Top = 208
    Width = 76
    Height = 112
    ImageCollection = TaskListForm.BackgroundImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 5
    ImageName = 'STOREFONE'
  end
  object BackGroundEXP: TVirtualImage
    Left = 167
    Top = 67
    Width = 76
    Height = 112
    ImageCollection = TaskListForm.BackgroundImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 5
    ImageName = 'STOREFONE'
  end
  object CoinsBust: TVirtualImage
    Left = 58
    Top = 223
    Width = 60
    Height = 85
    Hint = 
      #1050#1072#1088#1090#1086#1095#1082#1072' '#1084#1086#1085#1077#1090'. '#1055#1088#1080' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1080' '#1085#1086#1074#1086#1081' '#1079#1072#1076#1072#1095#1080' '#1074#1072#1096#1080' '#1084#1086#1085#1077#1090#1099' '#1091#1074#1077#1083#1080#1095#1072#1090 +
      #1089#1103'.'
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 4
    ImageName = 'MONEYTICKET'
    ParentShowHint = False
    ShowHint = True
  end
  object FreeXP: TVirtualImage
    Left = 176
    Top = 79
    Width = 60
    Height = 85
    Hint = #1041#1091#1090#1099#1083#1105#1082' '#1086#1087#1099#1090#1072'. '#1052#1086#1084#1077#1085#1090#1072#1083#1100#1085#1086' '#1091#1074#1077#1083#1080#1095#1080#1090' '#1074#1072#1096' '#1086#1087#1099#1090'.'
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 1
    ImageName = 'EXPBUFF'
    ParentShowHint = False
    ShowHint = True
  end
  object FreeTaskBust: TVirtualImage
    Left = 293
    Top = 222
    Width = 60
    Height = 85
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 6
    ImageName = 'FREETASK'
    ParentShowHint = False
    ShowHint = True
  end
  object FreeHPBust: TVirtualImage
    Left = 293
    Top = 79
    Width = 60
    Height = 85
    Hint = 
      #1050#1072#1088#1090#1086#1095#1082#1072' '#1079#1076#1086#1088#1086#1074#1100#1103'. '#1055#1088#1080' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1080' '#1085#1086#1074#1086#1081' '#1079#1072#1076#1072#1095#1080' '#1074#1072#1096#1077' '#1079#1076#1086#1088#1086#1074#1100#1077' '#1091#1074#1077 +
      #1083#1080#1095#1080#1090#1089#1103'.'
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 2
    ImageName = 'HPTICKET'
    ParentShowHint = False
    ShowHint = True
  end
  object SecretBox: TVirtualImage
    Left = 409
    Top = 222
    Width = 60
    Height = 85
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 7
    ImageName = 'SECRETBOX'
    ParentShowHint = False
    ShowHint = True
  end
  object FreeXPBust: TVirtualImage
    Left = 409
    Top = 79
    Width = 60
    Height = 85
    Hint = #1050#1072#1088#1090#1086#1095#1082#1072' '#1086#1087#1099#1090#1072'. '#1055#1088#1080' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1080' '#1085#1086#1074#1086#1081' '#1079#1072#1076#1072#1095#1080' '#1074#1072#1096' '#1086#1087#1099#1090' '#1091#1074#1077#1083#1080#1095#1080#1090#1089#1103'.'
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 3
    ImageName = 'XPTICKET'
    ParentShowHint = False
    ShowHint = True
  end
  object CoinsLabel: TLabel
    Left = 43
    Top = 30
    Width = 6
    Height = 15
    Hint = #1050#1086#1083'-'#1074#1086' '#1074#1072#1096#1080#1093' '#1084#1086#1085#1077#1090'.'
    Caption = '0'
    ParentShowHint = False
    ShowHint = True
  end
  object CoinsImage: TVirtualImage
    Left = 22
    Top = 31
    Width = 15
    Height = 15
    Hint = #1052#1086#1085#1077#1090#1099'.'
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 8
    ImageName = 'koin'
    ParentShowHint = False
    ShowHint = True
  end
  inline HPBustFrame: TFrame1
    Left = 284
    Top = 182
    Width = 76
    Height = 18
    TabOrder = 0
    ExplicitLeft = 284
    ExplicitTop = 182
    inherited BackGroundVirtmage: TVirtualImage
      OnClick = ButtonFrameBuyClick
    end
    inherited ButtonText: TLabel
      OnClick = ButtonFrameBuyClick
    end
  end
  inline HPFrame: TFrame1
    Left = 50
    Top = 182
    Width = 76
    Height = 18
    TabOrder = 1
    ExplicitLeft = 50
    ExplicitTop = 182
    inherited BackGroundVirtmage: TVirtualImage
      OnClick = ButtonFrameBuyClick
    end
    inherited ButtonText: TLabel
      OnClick = ButtonFrameBuyClick
    end
  end
  inline XPFrame: TFrame1
    Left = 167
    Top = 182
    Width = 76
    Height = 18
    TabOrder = 2
    ExplicitLeft = 167
    ExplicitTop = 182
    inherited BackGroundVirtmage: TVirtualImage
      OnClick = ButtonFrameBuyClick
    end
    inherited ButtonText: TLabel
      OnClick = ButtonFrameBuyClick
    end
  end
  inline XPBustFrame: TFrame1
    Left = 401
    Top = 182
    Width = 76
    Height = 18
    TabOrder = 3
    ExplicitLeft = 401
    ExplicitTop = 182
    inherited BackGroundVirtmage: TVirtualImage
      OnClick = ButtonFrameBuyClick
    end
    inherited ButtonText: TLabel
      OnClick = ButtonFrameBuyClick
    end
  end
  inline SecretBoxFrame: TFrame1
    Left = 401
    Top = 323
    Width = 76
    Height = 18
    TabOrder = 4
    ExplicitLeft = 401
    ExplicitTop = 323
    inherited BackGroundVirtmage: TVirtualImage
      OnClick = ButtonFrameBuyClick
    end
    inherited ButtonText: TLabel
      OnClick = ButtonFrameBuyClick
    end
  end
  inline FreeTaskBustFrame: TFrame1
    Left = 284
    Top = 323
    Width = 76
    Height = 18
    TabOrder = 5
    ExplicitLeft = 284
    ExplicitTop = 323
    inherited BackGroundVirtmage: TVirtualImage
      OnClick = ButtonFrameBuyClick
    end
    inherited ButtonText: TLabel
      OnClick = ButtonFrameBuyClick
    end
  end
  inline TothemBustFrame: TFrame1
    Left = 167
    Top = 323
    Width = 76
    Height = 18
    TabOrder = 6
    ExplicitLeft = 167
    ExplicitTop = 323
    inherited BackGroundVirtmage: TVirtualImage
      OnClick = ButtonFrameBuyClick
    end
    inherited ButtonText: TLabel
      OnClick = ButtonFrameBuyClick
    end
  end
  inline CoinsBustFrame: TFrame1
    Left = 50
    Top = 323
    Width = 76
    Height = 18
    TabOrder = 7
    ExplicitLeft = 50
    ExplicitTop = 323
    inherited BackGroundVirtmage: TVirtualImage
      OnClick = ButtonFrameBuyClick
    end
    inherited ButtonText: TLabel
      OnClick = ButtonFrameBuyClick
    end
  end
end
