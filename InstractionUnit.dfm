object InstractionForm: TInstractionForm
  Left = 0
  Top = 0
  Caption = 'InstractionForm'
  ClientHeight = 311
  ClientWidth = 855
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object InstractionFontPBox: TPaintBox
    Left = 8
    Top = 8
    Width = 834
    Height = 289
    OnPaint = InstractionFontPBoxPaint
  end
  object HeadLineLabel: TLabel
    Left = 20
    Top = 18
    Width = 78
    Height = 15
    Caption = 'HeadLineLabel'
  end
  object AboutNewTaskLabel: TLabel
    Left = 20
    Top = 72
    Width = 107
    Height = 15
    Caption = 'AboutNewTaskLabel'
  end
  object ComplexityLabel: TLabel
    Left = 20
    Top = 112
    Width = 89
    Height = 15
    Caption = 'ComplexityLabel'
  end
  object StoreLabel: TLabel
    Left = 20
    Top = 152
    Width = 55
    Height = 15
    Caption = 'StoreLabel'
  end
  object VirtualImage1: TVirtualImage
    Left = 34
    Top = 173
    Width = 9
    Height = 17
    Hint = #1084#1086#1084#1077#1085#1090#1072#1083#1100#1085#1086' '#1087#1086#1087#1086#1083#1085#1103#1077#1090' '#1079#1076#1086#1088#1086#1074#1100#1077
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 0
    ImageName = 'HEALTHBUFF'
    ParentShowHint = False
    ShowHint = True
  end
  object Label1: TLabel
    Left = 49
    Top = 173
    Width = 149
    Height = 15
    Hint = #1084#1086#1084#1077#1085#1090#1072#1083#1100#1085#1086' '#1087#1086#1087#1086#1083#1085#1103#1077#1090' '#1079#1076#1086#1088#1086#1074#1100#1077
    Caption = '- '#1073#1091#1090#1099#1083#1086#1095#1082#1072' '#1089#1086' '#1079#1076#1086#1088#1086#1074#1100#1077#1084';'
    ParentShowHint = False
    ShowHint = True
  end
  object VirtualImage2: TVirtualImage
    Left = 34
    Top = 194
    Width = 9
    Height = 17
    Hint = #1084#1086#1084#1077#1085#1090#1072#1083#1100#1085#1086' '#1087#1086#1087#1086#1083#1085#1103#1077#1090' '#1086#1087#1099#1090
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 1
    ImageName = 'EXPBUFF'
    ParentShowHint = False
    ShowHint = True
  end
  object Label2: TLabel
    Left = 49
    Top = 194
    Width = 127
    Height = 15
    Hint = #1084#1086#1084#1077#1085#1090#1072#1083#1100#1085#1086' '#1087#1086#1087#1086#1083#1085#1103#1077#1090' '#1079#1076#1086#1088#1086#1074#1100#1077
    Caption = '- '#1073#1091#1090#1099#1083#1086#1095#1082#1072' '#1089' '#1086#1087#1099#1090#1086#1084';'
    ParentShowHint = False
    ShowHint = True
  end
  object VirtualImage3: TVirtualImage
    Left = 241
    Top = 173
    Width = 9
    Height = 17
    Hint = 
      #1072#1082#1090#1080#1074#1080#1088#1091#1077#1090' '#1091#1074#1077#1083#1080#1095#1077#1085#1080#1077' '#1079#1076#1088#1086#1088#1086#1074#1100#1103': '#1087#1088#1080#1084#1077#1085#1103#1077#1090#1089#1103' '#1087#1088#1080' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1080' '#1079#1072#1076#1072 +
      #1095#1080
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 2
    ImageName = 'HPTICKET'
    ParentShowHint = False
    ShowHint = True
  end
  object Label3: TLabel
    Left = 256
    Top = 173
    Width = 150
    Height = 15
    Hint = 
      #1072#1082#1090#1080#1074#1080#1088#1091#1077#1090' '#1091#1074#1077#1083#1080#1095#1077#1085#1080#1077' '#1079#1076#1088#1086#1088#1086#1074#1100#1103': '#1087#1088#1080#1084#1077#1085#1103#1077#1090#1089#1103' '#1087#1088#1080' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1080' '#1079#1072#1076#1072 +
      #1095#1080
    Caption = '- '#1073#1086#1085#1091#1089' '#39#1073#1086#1083#1100#1096#1077' '#1079#1076#1086#1088#1086#1074#1100#1103#39';'
    ParentShowHint = False
    ShowHint = True
  end
  object VirtualImage4: TVirtualImage
    Left = 241
    Top = 194
    Width = 9
    Height = 17
    Hint = #1072#1082#1090#1080#1074#1080#1088#1091#1077#1090' '#1091#1074#1077#1083#1080#1095#1077#1085#1080#1077' '#1086#1087#1099#1090#1072': '#1087#1088#1080#1084#1077#1085#1103#1077#1090#1089#1103' '#1087#1088#1080' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1080' '#1079#1072#1076#1072#1095#1080
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 3
    ImageName = 'XPTICKET'
    ParentShowHint = False
    ShowHint = True
  end
  object Label4: TLabel
    Left = 256
    Top = 194
    Width = 134
    Height = 15
    Hint = #1072#1082#1090#1080#1074#1080#1088#1091#1077#1090' '#1091#1074#1077#1083#1080#1095#1077#1085#1080#1077' '#1086#1087#1099#1090#1072': '#1087#1088#1080#1084#1077#1085#1103#1077#1090#1089#1103' '#1087#1088#1080' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1080' '#1079#1072#1076#1072#1095#1080
    Caption = '- '#1073#1086#1085#1091#1089' '#39#1073#1086#1083#1100#1096#1077' '#1086#1087#1099#1090#1072#39';'
    ParentShowHint = False
    ShowHint = True
  end
  object VirtualImage5: TVirtualImage
    Left = 452
    Top = 173
    Width = 9
    Height = 17
    Hint = #1072#1082#1090#1080#1074#1080#1088#1091#1077#1090' '#1091#1074#1077#1083#1080#1095#1077#1085#1080#1077' '#1084#1086#1085#1077#1090': '#1087#1088#1080#1084#1077#1085#1103#1077#1090#1089#1103' '#1087#1088#1080' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1080' '#1079#1072#1076#1072#1095#1080
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 4
    ImageName = 'MONEYTICKET'
    ParentShowHint = False
    ShowHint = True
  end
  object Label5: TLabel
    Left = 466
    Top = 173
    Width = 134
    Height = 15
    Hint = #1072#1082#1090#1080#1074#1080#1088#1091#1077#1090' '#1091#1074#1077#1083#1080#1095#1077#1085#1080#1077' '#1084#1086#1085#1077#1090': '#1087#1088#1080#1084#1077#1085#1103#1077#1090#1089#1103' '#1087#1088#1080' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1080' '#1079#1072#1076#1072#1095#1080
    Caption = '- '#1073#1086#1085#1091#1089' '#39#1073#1086#1083#1100#1096#1077' '#1084#1086#1085#1077#1090#39';'
    ParentShowHint = False
    ShowHint = True
  end
  object VirtualImage6: TVirtualImage
    Left = 451
    Top = 194
    Width = 12
    Height = 17
    Hint = 
      #1074#1086#1079#1074#1088#1072#1097#1072#1077#1090' '#1074' '#1085#1086#1088#1084#1091' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1088#1086#1089#1088#1086#1095#1077#1085#1086#1081' '#1079#1072#1076#1072#1095#1080' '#1087#1088#1080' '#1077#1105' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1080 +
      ': '#1072#1082#1090#1080#1074#1080#1088#1091#1077#1090#1089#1103' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 5
    ImageName = 'TOTEM'
    ParentShowHint = False
    ShowHint = True
  end
  object Label6: TLabel
    Left = 466
    Top = 194
    Width = 85
    Height = 15
    Hint = 
      #1074#1086#1079#1074#1088#1072#1097#1072#1077#1090' '#1074' '#1085#1086#1088#1084#1091' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1088#1086#1089#1088#1086#1095#1077#1085#1086#1081' '#1079#1072#1076#1072#1095#1080' '#1087#1088#1080' '#1077#1105' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1080 +
      ': '#1072#1082#1090#1080#1074#1080#1088#1091#1077#1090#1089#1103' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
    Caption = '- '#1073#1086#1085#1091#1089' '#39#1090#1086#1090#1077#1084#39';'
    ParentShowHint = False
    ShowHint = True
  end
  object VirtualImage7: TVirtualImage
    Left = 636
    Top = 173
    Width = 12
    Height = 17
    Hint = 
      #1079#1072#1085#1091#1083#1103#1077#1090' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1088#1086#1089#1088#1086#1095#1077#1085#1086#1081' '#1079#1072#1076#1072#1095#1080' '#1087#1088#1080' '#1077#1105' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1080': '#1072#1082#1090#1080#1074#1080#1088#1091 +
      #1077#1090#1089#1103' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 6
    ImageName = 'FREETASK'
    ParentShowHint = False
    ShowHint = True
  end
  object Label7: TLabel
    Left = 651
    Top = 173
    Width = 155
    Height = 15
    Hint = 
      #1079#1072#1085#1091#1083#1103#1077#1090' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1088#1086#1089#1088#1086#1095#1077#1085#1086#1081' '#1079#1072#1076#1072#1095#1080' '#1087#1088#1080' '#1077#1105' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1080': '#1072#1082#1090#1080#1074#1080#1088#1091 +
      #1077#1090#1089#1103' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
    Caption = '- '#1073#1086#1085#1091#1089' '#39#1073#1077#1089#1087#1083#1072#1090#1085#1072#1103' '#1079#1072#1076#1072#1095#1072#39';'
    ParentShowHint = False
    ShowHint = True
  end
  object VirtualImage8: TVirtualImage
    Left = 636
    Top = 194
    Width = 12
    Height = 17
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 7
    ImageName = 'SECRETBOX'
    ParentShowHint = False
    ShowHint = True
  end
  object Label8: TLabel
    Left = 651
    Top = 194
    Width = 109
    Height = 15
    Hint = #1089#1091#1085#1076#1091#1082' '#1080#1079' '#1082#1086#1090#1086#1088#1086#1075#1086' '#1084#1086#1078#1077#1090' '#1074#1099#1087#1072#1089#1090#1100' '#1083#1102#1073#1086#1081' '#1080#1079' 8-'#1084#1080' '#1087#1088#1077#1076#1084#1077#1090#1086#1074
    Caption = '- '#1089#1083#1091#1095#1072#1081#1085#1099#1081' '#1073#1086#1085#1091#1089';'
    ParentShowHint = False
    ShowHint = True
  end
  object AboutBonusesLabel: TLabel
    Left = 20
    Top = 217
    Width = 105
    Height = 15
    Caption = 'AboutBonusesLabel'
  end
  object AnotherLabel: TLabel
    Left = 20
    Top = 238
    Width = 71
    Height = 15
    Caption = 'AnotherLabel'
  end
  object VirtualImage9: TVirtualImage
    Left = 197
    Top = 113
    Width = 9
    Height = 15
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 9
    ImageName = 'EazyComplexity'
  end
  object VirtualImage10: TVirtualImage
    Left = 238
    Top = 113
    Width = 9
    Height = 15
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 10
    ImageName = 'MediumComplexity'
  end
  object VirtualImage11: TVirtualImage
    Left = 289
    Top = 113
    Width = 9
    Height = 15
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 11
    ImageName = 'HighComplexity'
  end
end
