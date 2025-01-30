object UViewPrincipal: TUViewPrincipal
  Left = 0
  Top = 0
  Caption = 'Processar Lista'
  ClientHeight = 527
  ClientWidth = 565
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object gbPrincipal: TGroupBox
    Left = 0
    Top = 0
    Width = 565
    Height = 527
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 492
    ExplicitHeight = 343
    object Label1: TLabel
      Left = 2
      Top = 304
      Width = 561
      Height = 15
      Align = alBottom
      Caption = 'Registros filho'
      ExplicitTop = 177
      ExplicitWidth = 75
    end
    object Label2: TLabel
      Left = 2
      Top = 64
      Width = 561
      Height = 15
      Align = alBottom
      Caption = 'Registros pai'
      ExplicitWidth = 67
    end
    object btnListaNormal: TButton
      Left = 8
      Top = 16
      Width = 137
      Height = 25
      Caption = 'Processar Lista Normal'
      DragCursor = crHourGlass
      TabOrder = 0
      OnClick = btnListaNormalClick
    end
    object btnListaTask: TButton
      Left = 154
      Top = 16
      Width = 169
      Height = 25
      Caption = 'Processar Lista ITask'
      DragCursor = crHourGlass
      TabOrder = 1
      OnClick = btnListaTaskClick
    end
    object mmResult: TMemo
      Left = 346
      Top = 17
      Width = 217
      Height = 55
      Lines.Strings = (
        '')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
    end
    object dbgFilho: TDBGrid
      Left = 2
      Top = 319
      Width = 561
      Height = 206
      Align = alBottom
      DataSource = dsFilho
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
    object dbgPai: TDBGrid
      Left = 2
      Top = 79
      Width = 561
      Height = 225
      Align = alBottom
      DataSource = dsPai
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object dsFilho: TDataSource
    Left = 352
    Top = 328
  end
  object dsPai: TDataSource
    Left = 352
    Top = 144
  end
end
