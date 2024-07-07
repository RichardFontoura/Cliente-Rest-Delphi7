object frmPrincipal: TfrmPrincipal
  Left = 597
  Top = 52
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Consome API'
  ClientHeight = 720
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sbrBarra: TStatusBar
    Left = 0
    Top = 701
    Width = 481
    Height = 19
    Panels = <>
  end
  object pnlCorpo: TPanel
    Left = 0
    Top = 0
    Width = 481
    Height = 701
    Align = alClient
    TabOrder = 1
    object lblLink: TLabel
      Left = 8
      Top = 8
      Width = 87
      Height = 13
      Caption = 'Link para Request'
    end
    object imgImagem: TImage
      Left = 8
      Top = 272
      Width = 465
      Height = 425
      Center = True
      Proportional = True
    end
    object edtLink: TEdit
      Left = 8
      Top = 24
      Width = 385
      Height = 21
      TabOrder = 0
    end
    object btnExceutar: TBitBtn
      Left = 400
      Top = 22
      Width = 75
      Height = 25
      Caption = 'Exceutar'
      TabOrder = 1
      OnClick = btnExceutarClick
    end
    object menResponse: TMemo
      Left = 8
      Top = 57
      Width = 465
      Height = 208
      Lines.Strings = (
        'menResponse')
      TabOrder = 2
    end
  end
end
