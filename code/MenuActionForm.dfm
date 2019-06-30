object MenuSearchForm: TMenuSearchForm
  Left = 0
  Top = 0
  Caption = 'Buscador de men'#250
  ClientHeight = 269
  ClientWidth = 242
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 250
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblPath: TLabel
    Left = 7
    Top = 240
    Width = 106
    Height = 13
    Align = alCustom
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    Caption = 'Path'
    EllipsisPosition = epEndEllipsis
    ExplicitTop = 289
    ExplicitWidth = 243
  end
  object lblCount: TLabel
    Left = 226
    Top = 216
    Width = 6
    Height = 13
    Align = alCustom
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = '0'
  end
  object edFind: TEdit
    Left = 7
    Top = 8
    Width = 226
    Height = 21
    Align = alCustom
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    OnChange = edFindChange
  end
  object btnExecute: TButton
    Left = 119
    Top = 236
    Width = 114
    Height = 25
    Align = alCustom
    Anchors = [akRight, akBottom]
    Caption = 'Ejecutar men'#250
    Default = True
    Enabled = False
    TabOrder = 3
    OnClick = btnExecuteClick
  end
  object lbMenuItems: TListBox
    Left = 7
    Top = 35
    Width = 226
    Height = 180
    Style = lbOwnerDrawVariable
    AutoComplete = False
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    DoubleBuffered = False
    ItemHeight = 14
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = lbMenuItemsClick
    OnDrawItem = lbMenuItemsDrawItem
    OnMeasureItem = lbMenuItemsMeasureItem
  end
  object chkOnlyExecutables: TCheckBox
    Left = 8
    Top = 216
    Width = 153
    Height = 17
    Align = alCustom
    Anchors = [akLeft, akBottom]
    Caption = 'Mostrar solo los ejecutables'
    TabOrder = 2
    OnClick = chkOnlyExecutablesClick
  end
end
