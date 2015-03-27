unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, sSkinManager, ComCtrls, ExtCtrls, sPanel,
  acSlider, jpeg, WinSock, Sockets, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, httpapp, IdTCPServer,
  IdCustomHTTPServer, IdHTTPServer, IdFTPServer, IdMultipartFormData;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    sSkinManager1: TsSkinManager;
    Edit2: TEdit;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    TcpClient1: TTcpClient;
    TcpServer2: TTcpServer;
    IdHTTP1: TIdHTTP;
    TcpClient3: TTcpClient;
    CheckBox1: TCheckBox;
    IdFTPServer1: TIdFTPServer;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure TcpClient1Error(Sender: TObject; SocketError: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TcpClient1Connect(Sender: TObject);
    procedure TcpClient1Disconnect(Sender: TObject);
    procedure TcpServer2Accept(Sender: TObject;
      ClientSocket: TCustomIpClient);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var
mstream, stream:TmemoryStream;
b:Boolean;
procedure SendFile(ip: string);
var
  http: TIdHTTP;
  stream: TIdMultiPartFormDataStream;
begin
http := TIdHTTP.Create(Form1);
stream := TIdMultiPartFormDataStream.Create();
http.Request.ContentType:='multipart/form-data';
stream.AddFile('file','Data\1.jpg','multipart/form-data');
http.Post('http://192.168.100.14:3000/screen', stream);
stream.Free;
http.Free;
end;

function GetURIEncodedString(original : string): string;
var
i : integer;
s:string;
begin
 s:='';
 for i:=1 to length(original) do
  if original[i]=' ' then
  s:=s+'%20' else s:=s+original[i];
  Result:=s;
end;

Function poslvh(x:string):integer;
var i,ans:integer;
begin
  for i:= 1 to length(x) do
  if x[i]='/' then ans:=i;
  poslvh:=ans;
end;

Function GetLocalIP : String;
Var WSAData: TWSAData;
    P: PHostEnt;
    Name: array[0..$FF] of Char;
Begin
  WSAStartup($0101, WSAData);
  GetHostName(Name, $FF);
  P := GetHostByName(Name);
  Result := inet_ntoa(PInAddr(P.h_addr_list^)^);
  WSACleanup;
End;

function get_screen():TMemoryStream;
var
  jpg:TJPEGImage;
  BMP:TBitmap;
  FileName:string;
  ms:TMemoryStream;
begin
  ms := TMemoryStream.Create;
  Jpg := TJPEGImage.Create;
  FileName := ExtractFilePath( Application.ExeName) + 'Data\1.jpg';
  bmp := TBitmap.Create;
  bmp.Width := Screen.Width;
  bmp.Height := Screen.Height;
  BitBlt(bmp.Canvas.Handle, 0,0, Screen.Width, Screen.Height, GetDC(0), 0,0,SRCCOPY);
  Jpg.Assign(Bmp);
  //Jpg.SaveToFile(filename);
  jpg.SaveToStream(ms);
  ms.Position:=0;
  Result := ms;
  //sleep(500);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if button1.Caption='Подключиться'
    then
      if edit1.text<>'' then
        begin
          TcpClient1.RemoteHost:=edit1.Text;
          TcpClient1.active:=true;
          TcpClient1.Sendln('Connected');
        end else Memo1.Lines.add('['+ TimeToStr(now)+ '] Поле "HOST IP" - пусто ')
    else
      begin
        TcpClient1.Sendln('Disconnected');
        Tcpclient1.Active:=false;
      end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var  s:string;
      f:textfile;
begin
  b:=false;
  AssignFile(f,'Data\config.cfg');
  Reset(f);
  Readln(f,s);
  edit1.Text:=s;
  CloseFile(f);
  edit2.Enabled:=false;
  button2.Enabled:=false;
  stream:=TMemoryStream.Create;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if edit1.text<>'' then
  begin
    TcpClient1.Sendln(edit2.text);
    edit2.Text:='';
  end;
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if (key=#13) then button2.Click;
end;

procedure TForm1.TcpClient1Error(Sender: TObject; SocketError: Integer);
begin
    if SocketError = 10061 then
    begin
      button1.Enabled:=true;
      TcpClient1.Active := False;
      Memo1.Lines.Add('['+TimeToStr(GetTime)+']'+' Не удалось подключиться к серверу. Сервер не найден.');
      SocketError:=0;
    end;
  if SocketError = 10060 then
    begin
      button1.Enabled:=true;
      TcpClient1.Active := False;
      Memo1.Lines.Add('['+TimeToStr(GetTime)+']'+' Время подключения к серверу истекло. Сервер не найден.');
      SocketError:=0;
    end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TcpClient1.Active:=false;
  TcpServer2.BlockMode:=bmBlocking;
end;

procedure TForm1.TcpClient1Connect(Sender: TObject);
var f:TextFile;
begin
  AssignFile(f,'Data\config.cfg');
  Rewrite(f);
  Writeln(f,Form1.TcpClient1.RemoteHost);
  CloseFile(f);
  Form1.Button1.Enabled:=True;
  Form1.Button2.Enabled:=True;
  Form1.Edit2.Enabled:=True;
  TcpClient3.RemoteHost:=TcpClient1.RemoteHost;
  Form1.Button1.Caption:='Отключиться';
  Form1.Memo1.Lines.Add('['+ TimeToStr(now)+ '] Вы подключены к серверу. Host: '+Form1.TcpClient1.RemoteHost);
end;

procedure TForm1.TcpClient1Disconnect(Sender: TObject);
begin
  Form1.Button1.Enabled:=True;
  Form1.Button2.Enabled:=false;
  Form1.Edit2.Enabled:=false;
  Form1.Memo1.Lines.Add('['+ TimeToStr(Now)+ '] Вы отключены от сервера.');
  Form1.Button1.Caption:='Подключиться';
end;

procedure TForm1.TcpServer2Accept(Sender: TObject;
  ClientSocket: TCustomIpClient);
var str,s,url,filename:string;
    a:textfile;
    m:TMemoryStream;
begin
  s:=ClientSocket.Receiveln('\n');
  if s[1]+s[2]+s[3]+s[4]='down' then
    begin
      s:=utf8decode(s);
      str:=copy(s,6,length(s)-5);
      str:=copy(str,1,poslvh(str)-1);
      filename:=copy(s,poslvh(s)+1,length(s)-poslvh(s));
      url:=GetURIEncodedString('http://'+tcpClient1.remoteHost+':3000/'+str+'/'+filename);
      memo1.Lines.Add('['+TimeToStr(now)+'] Принят и сохранен файл: '+filename);
      try
        m:=TMemoryStream.Create;
        IdHttp1.Get (url, m);
        m.SaveToFile(filename);
        m.Free;
      except
        memo1.Lines.Add('['+TimeToStr(now)+'] Файл не может быть принят: '+filename)
      end;
    end;
  if s='viewfirst' then
    begin
      get_screen.SaveToFile('Data\1.jpg');
      Sleep(100);
      SendFile(TcpClient1.RemoteHost+':3000');
    end;
  if s='view'then
    begin
        Sleep(800);
        get_screen.SaveToFile('Data\1.jpg');
        SendFile(TcpClient1.RemoteHost+':3000');
    end;
  if s='poweroff' then
    begin
      assignfile(a, ExtractFilePath(Application.ExeName) + 'Data\command.bat');
      rewrite(a);
      writeln(a,'@echo off');
      writeln(a,#34+'%WINDIR%'+#34+'\system32\shutdown.exe '+'-s -f -t 10');
      closefile(a);
      WinExec(PChar('Data\command.bat'), SW_HIDE);
    end;
  if s='reboot' then
    begin
      assignfile(a, ExtractFilePath(Application.ExeName) + 'Data\command.bat');
      rewrite(a);
      writeln(a,'@echo off');
      writeln(a,#34+'%WINDIR%'+#34+'\system32\shutdown.exe '+'-r -f -t 10');
      closefile(a);
      WinExec(PChar('Data\command.bat'), SW_HIDE);
    end;
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
get_screen.SaveToFile('Data\1.jpg');
SendFile(TcpClient1.RemoteHost+':3000');
end;

end.
