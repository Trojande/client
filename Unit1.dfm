object Form1: TForm1
  Left = 278
  Top = 164
  Width = 549
  Height = 372
  Caption = 'Client'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 541
    Height = 345
    Align = alClient
    Caption = 'Host IP'
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 40
      Width = 44
      Height = 13
      Caption = 'HOST IP:'
    end
    object Edit1: TEdit
      Left = 8
      Top = 56
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object Button1: TButton
      Left = 32
      Top = 88
      Width = 83
      Height = 25
      Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103
      TabOrder = 1
      OnClick = Button1Click
    end
    object Edit2: TEdit
      Left = 152
      Top = 296
      Width = 273
      Height = 21
      TabOrder = 2
      OnKeyPress = Edit2KeyPress
    end
    object Memo1: TMemo
      Left = 152
      Top = 8
      Width = 369
      Height = 281
      ReadOnly = True
      TabOrder = 3
    end
    object Button2: TButton
      Left = 432
      Top = 296
      Width = 89
      Height = 25
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
      TabOrder = 4
      OnClick = Button2Click
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 136
      Width = 105
      Height = 33
      Caption = #1055#1086#1076#1082#1083#1102#1095#1072#1090#1100#1089#1103' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
      TabOrder = 5
      WordWrap = True
    end
    object Button3: TButton
      Left = 32
      Top = 296
      Width = 75
      Height = 25
      Caption = 'Button3'
      TabOrder = 6
      OnClick = Button3Click
    end
  end
  object sSkinManager1: TsSkinManager
    InternalSkins = <>
    MenuSupport.IcoLineSkin = 'ICOLINE'
    MenuSupport.ExtraLineFont.Charset = DEFAULT_CHARSET
    MenuSupport.ExtraLineFont.Color = clWindowText
    MenuSupport.ExtraLineFont.Height = -11
    MenuSupport.ExtraLineFont.Name = 'MS Sans Serif'
    MenuSupport.ExtraLineFont.Style = []
    SkinDirectory = 'Data\Skins'
    SkinName = 'Air'
    SkinInfo = '8'
    ThirdParty.ThirdEdits = 
      'TEdit'#13#10'TMemo'#13#10'TMaskEdit'#13#10'TSpinEdit'#13#10'TLabeledEdit'#13#10'THotKey'#13#10'TList' +
      'Box'#13#10'TCheckListBox'#13#10'TRichEdit'#13#10'TDateTimePicker'#13#10'TCategoryButtons' +
      #13#10'TFileListBox'#13#10
    ThirdParty.ThirdButtons = 'TButton'#13#10
    ThirdParty.ThirdBitBtns = 'TBitBtn'#13#10
    ThirdParty.ThirdCheckBoxes = 'TCheckBox'#13#10'TRadioButton'#13#10'TGroupButton'#13#10
    ThirdParty.ThirdGroupBoxes = 'TGroupBox'#13#10'TRadioGroup'#13#10
    ThirdParty.ThirdListViews = 'TListView'#13#10
    ThirdParty.ThirdPanels = 'TPanel'#13#10'TPage'#13#10'TGridPanel'#13#10'TTabPage'#13#10
    ThirdParty.ThirdGrids = 'TStringGrid'#13#10'TDrawGrid'#13#10'TValueListEditor'#13#10
    ThirdParty.ThirdTreeViews = 'TTreeView'#13#10
    ThirdParty.ThirdComboBoxes = 'TComboBox'#13#10'TComboBoxEx'#13#10'TColorBox'#13#10
    ThirdParty.ThirdWWEdits = ' '#13#10
    ThirdParty.ThirdVirtualTrees = ' '#13#10
    ThirdParty.ThirdGridEh = ' '#13#10
    ThirdParty.ThirdPageControl = 'TPageControl'#13#10
    ThirdParty.ThirdTabControl = 'TTabControl'#13#10'TTabbedNotebook'#13#10
    ThirdParty.ThirdToolBar = 'TToolBar'#13#10
    ThirdParty.ThirdStatusBar = 'TStatusBar'#13#10
    ThirdParty.ThirdSpeedButton = 'TSpeedButton'#13#10
    ThirdParty.ThirdScrollControl = 'TScrollBox'#13#10
    ThirdParty.ThirdUpDown = 'TSpinButton'#13#10'TUpDown'#13#10
    ThirdParty.ThirdScrollBar = 'TScrollBar'#13#10
    ThirdParty.ThirdStaticText = 'TStaticText'#13#10
    ThirdParty.ThirdNativePaint = ' '#13#10
    Left = 256
    Top = 16
  end
  object TcpClient1: TTcpClient
    RemotePort = '3001'
    OnConnect = TcpClient1Connect
    OnDisconnect = TcpClient1Disconnect
    OnError = TcpClient1Error
    Left = 228
    Top = 16
  end
  object TcpServer2: TTcpServer
    Active = True
    LocalPort = '3001'
    OnAccept = TcpServer2Accept
    Left = 204
    Top = 16
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 152
    Top = 16
  end
  object TcpClient3: TTcpClient
    RemotePort = '3002'
    Left = 176
    Top = 16
  end
  object IdFTPServer1: TIdFTPServer
    Active = True
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 21
    Greeting.NumericCode = 220
    Greeting.Text.Strings = (
      'Indy FTP Server ready.')
    Greeting.TextCode = '220'
    MaxConnectionReply.NumericCode = 0
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 500
    ReplyUnknownCommand.Text.Strings = (
      'Syntax error, command unrecognized.')
    ReplyUnknownCommand.TextCode = '500'
    AnonymousAccounts.Strings = (
      'anonymous'
      'ftp'
      'guest')
    SystemType = 'WIN32'
    Left = 72
    Top = 232
  end
end
