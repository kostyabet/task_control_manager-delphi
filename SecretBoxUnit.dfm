object SecreteBoxForm: TSecreteBoxForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1077#1082#1088#1077#1090#1085#1072#1103' '#1082#1086#1088#1086#1073#1086#1095#1082#1072
  ClientHeight = 270
  ClientWidth = 424
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object RandomBustImage: TVirtualImage
    Left = 124
    Top = 42
    Width = 175
    Height = 175
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 7
    ImageName = 'SECRETBOX'
  end
  object TitleLabel: TLabel
    Left = 88
    Top = 8
    Width = 243
    Height = 28
    Caption = #1057#1045#1050#1056#1045#1058#1053#1040#1071' '#1050#1054#1056#1054#1041#1054#1063#1050#1040
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inline OpenButtonFrame: TFrame1
    Left = 112
    Top = 225
    Width = 200
    Height = 30
    TabOrder = 0
    ExplicitLeft = 112
    ExplicitTop = 225
    ExplicitWidth = 200
    ExplicitHeight = 30
    inherited BackGroundVirtmage: TVirtualImage
      Width = 200
      Height = 30
      Proportional = False
      OnClick = SearchRandomBust
      ExplicitWidth = 200
      ExplicitHeight = 30
    end
    inherited ButtonText: TLabel
      Left = 57
      Top = 2
      Width = 85
      Height = 25
      Caption = #1054#1058#1050#1056#1067#1058#1068
      Font.Height = -18
      OnClick = SearchRandomBust
      ExplicitLeft = 57
      ExplicitTop = 2
      ExplicitWidth = 85
      ExplicitHeight = 25
    end
  end
end
