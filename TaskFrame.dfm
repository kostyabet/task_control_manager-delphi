object TaskOutputFrame: TTaskOutputFrame
  Left = 0
  Top = 0
  Width = 604
  Height = 54
  TabOrder = 0
  object BackGroundVImage: TVirtualImage
    Left = 0
    Top = 0
    Width = 604
    Height = 54
    Align = alClient
    ImageCollection = TaskListForm.BackgroundImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 2
    ImageName = 'TASK_FON'
    OnDblClick = CustomDblClick
    ExplicitTop = 4
  end
  object ExpVImage: TVirtualImage
    Left = 485
    Top = 33
    Width = 5
    Height = 13
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 1
    ImageName = 'EXPBUFF'
  end
  object XPLabel: TLabel
    Left = 491
    Top = 32
    Width = 24
    Height = 15
    Caption = '8888'
  end
  object HpLabel: TLabel
    Left = 533
    Top = 33
    Width = 24
    Height = 15
    Caption = '8888'
  end
  object HpVImage: TVirtualImage
    Left = 523
    Top = 34
    Width = 9
    Height = 13
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 0
    ImageName = 'HEALTHBUFF'
  end
  object MoneyVImage: TVirtualImage
    Left = 559
    Top = 35
    Width = 11
    Height = 11
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 8
    ImageName = 'koin'
  end
  object MoneyLabel: TLabel
    Left = 571
    Top = 33
    Width = 24
    Height = 15
    Caption = '8888'
  end
  object ComplexityVImage: TVirtualImage
    Left = 4
    Top = 4
    Width = 3
    Height = 46
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 9
    ImageName = 'EazyComplexity'
    OnDblClick = CustomDblClick
  end
  object SubTasksLabel: TLabel
    Left = 269
    Top = 6
    Width = 76
    Height = 15
    Caption = #1055#1054#1044#1047#1040#1044#1040#1063#1048
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SubTasksResLabel: TLabel
    Left = 351
    Top = 6
    Width = 17
    Height = 15
    Caption = '0/0'
  end
  object TaskLabel: TLabel
    Left = 15
    Top = 3
    Width = 64
    Height = 15
    Caption = #1053#1040#1047#1042#1040#1053#1048#1045
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    OnDblClick = CustomDblClick
  end
  object DeadLineLabel: TLabel
    Left = 15
    Top = 18
    Width = 63
    Height = 15
    Caption = #1057#1076#1077#1083#1072#1090#1100' '#1076#1086':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    OnDblClick = CustomDblClick
  end
  object AboutLabel: TLabel
    Left = 15
    Top = 32
    Width = 55
    Height = 15
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    OnDblClick = CustomDblClick
  end
  inline ApplyButtonFrame: TFrame1
    Left = 485
    Top = 9
    Width = 110
    Height = 20
    TabOrder = 0
    ExplicitLeft = 485
    ExplicitTop = 9
    ExplicitWidth = 110
    ExplicitHeight = 20
    inherited BackGroundVirtmage: TVirtualImage
      Width = 110
      Height = 20
      Proportional = False
      OnClick = ApplyButtonClick
      ExplicitWidth = 110
      ExplicitHeight = 20
    end
    inherited ButtonText: TLabel
      Left = 18
      Top = 2
      Width = 78
      Caption = #1042#1067#1055#1054#1051#1053#1048#1058#1068
      OnClick = ApplyButtonClick
      ExplicitLeft = 18
      ExplicitTop = 2
      ExplicitWidth = 78
    end
  end
  inline ChangeSubTasksFrame: TFrame1
    Left = 267
    Top = 25
    Width = 100
    Height = 20
    TabOrder = 1
    ExplicitLeft = 267
    ExplicitTop = 25
    ExplicitWidth = 100
    ExplicitHeight = 20
    inherited BackGroundVirtmage: TVirtualImage
      Width = 100
      Height = 20
      Proportional = False
      OnClick = ChangeSubTasksFrameClick
      ExplicitWidth = 100
      ExplicitHeight = 20
    end
    inherited ButtonText: TLabel
      Left = 22
      Top = 2
      Width = 56
      Caption = #1054#1058#1050#1056#1067#1058#1068
      OnClick = ChangeSubTasksFrameClick
      ExplicitLeft = 22
      ExplicitTop = 2
      ExplicitWidth = 56
    end
  end
end
