object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 298
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 160
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object MainMenu1: TMainMenu
    Left = 176
    Top = 24
    object MenuA1: TMenuItem
      Caption = 'Menu A'
      object Item11: TMenuItem
        Caption = 'Item1'
        Enabled = False
        Hint = 'Disabled menu item'
        OnClick = Item11Click
      end
      object Item21: TMenuItem
        Caption = 'Item2'
        Hint = 'Hinte menu 2'
        OnClick = Item21Click
      end
    end
    object MenuB1: TMenuItem
      Caption = 'Menu B'
      object Itemm1: TMenuItem
        Caption = 'Item m'
        object Submenu11: TMenuItem
          Caption = 'Submenu1'
          OnClick = Submenu11Click
        end
      end
      object Itemj1: TMenuItem
        Caption = 'Item j'
        Hint = 'Item J hint!'
        Visible = False
        OnClick = Itemj1Click
      end
    end
    object MenuC1: TMenuItem
      Caption = 'Menu C'
      object Citem1: TMenuItem
        Caption = 'C item a'
      end
      object Citemb1: TMenuItem
        Caption = 'C item b'
        object Subitemc1: TMenuItem
          Caption = 'Sub item c'
          object Supersubitemc11: TMenuItem
            Caption = 'Super sub item c 1'
          end
          object Supersubitemc21: TMenuItem
            Caption = 'Super sub item c 2'
            object Lasttreeitem1: TMenuItem
              Caption = 'Last tree item'
              OnClick = Lasttreeitem1Click
            end
          end
          object Supersubitemc31: TMenuItem
            Caption = 'Super sub item c 3'
            OnClick = Supersubitemc31Click
          end
        end
        object Subitemcbis1: TMenuItem
          Caption = 'Sub item c bis'
        end
      end
      object Citemc1: TMenuItem
        Caption = 'C item c'
        OnClick = Citemc1Click
      end
    end
  end
end
