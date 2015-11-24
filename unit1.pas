unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  FileUtil,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  StdCtrls,
  Windows;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnSubmit: TButton;
    btnSendKey: TButton;
    btnGetHandler: TButton;
    procedure btnGetHandlerClick(Sender: TObject);
    procedure btnSendKeyClick(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;
implementation
{$R *.lfm}

{ TfrmMain }

var
   hWnd: THandle;

Function LayDuongDanHienHanh:string;
var
nbufferLength:dword;
lpbuffer:pchar;
begin
   nbufferlength:=MAX_PATH +1;
   getMem(lpBuffer,nbufferlength);
   try
      If windows.GetCurrentDirectory(nbufferlength,lpbuffer) > 0 then
         result:=lpbuffer;
   finally
   FreeMem(lpbuffer);
   end;
end;

procedure MouseClickL(X,Y:integer);
begin
   if hWnd <> 0 then
      begin
        //SetCursorPos(X, Y);
        SendMessage(hWnd, WM_MOUSEMOVE, 0, MakeLParam(X,Y));
        Sleep(50);
        SendMessage(hWnd, WM_LBUTTONDOWN, 0,0);  // Đè chuột trái
        Sleep(50);
        SendMessage(hWnd, WM_LBUTTONUP, 0,0);    // Nhả ra :)
      end;
end;

Procedure MouseClickR(X,Y:integer);
begin
  if hWnd <> 0 then
      begin
      //SetCursorPos(X, Y);
      SendMessage(hWnd, WM_MOUSEMOVE, 0, MakeLParam(X,Y));
      Sleep(50);
      SendMessage(hWnd, WM_RBUTTONDOWN, 0,0);
      Sleep(50);
      SendMessage(hWnd, WM_RBUTTONUP, 0,0);
      end;
end;

Procedure SendKeyTomS(Key:integer);
begin
  PostMessage(hWnd, WM_KEYDOWN, Key, $1C0001);
  Sleep(50);
  PostMessage(hWnd, WM_KEYUP, Key, $1C0001);
end;

procedure TfrmMain.btnSubmitClick(Sender: TObject);
var
   url: String;
begin
   url := LayDuongDanHienHanh();
   ShowMessage(url);
end;

procedure TfrmMain.btnSendKeyClick(Sender: TObject);
//var
   //hwnd: THandle;
begin
   //hWnd := FindWindow(nil,'Untitled - Notepad');
   //H:=FindWindow('TianLongBaBu WndClass', Nil);
   hWnd := FindWindow('Notepad', Nil);
   if hWnd <> 0 then
      begin
        //ShowMessage('Open');
        //MouseClickL(269, 213);
      //SendKeyTomS(Ord('A'));
      ShowMessage(inttostr(Ord('a')));
      //PostMessage(hWnd, WM_KEYDOWN, Ord(Char('A')), $1C0001);
      //Sleep(50);
      //PostMessage(hWnd, WM_KEYUP, Ord(Char('A')), $1C0001);
      end
   else
      begin
          ShowMessage('Close');
      end;

end;
function KeyboardString(Data: String):boolean;
  const special = '`1234567890-=[];''#\,./';
  var I : integer;
  begin
    for I := 1 to length(Data) do begin
        if (Pos(Data[I],special) = 0) and (Pos(char(vkkeyscan(Data[I])),special) <> 0 ) then windows.keybd_event(VK_SHIFT,1,0,0)
        else if ((Pos(char(vkkeyscan(Data[I])),special) = 0 ) or (Pos(Data[I],special) = 0 )) and (char(vkkeyscan(Data[I])) = Data[I]) then windows.keybd_event(VK_SHIFT,1,0,0);
    windows.keybd_event(vkkeyscan(Data[I]),1,0,0);
    windows.keybd_event(vkkeyscan(Data[I]),1,KEYEVENTF_KEYUP,0);
    if (Pos(Data[I],special) = 0) and (Pos(char(vkkeyscan(Data[I])),special) <> 0 ) then windows.keybd_event(VK_SHIFT,1,KEYEVENTF_KEYUP,0)
    else if ((Pos(char(vkkeyscan(Data[I])),special) = 0 ) or (Pos(Data[I],special) = 0 )) and (char(vkkeyscan(Data[I])) = Data[I]) then windows.keybd_event(VK_SHIFT,1,KEYEVENTF_KEYUP,0);
  end;
end;

procedure TfrmMain.btnGetHandlerClick(Sender: TObject);
var
   hWnds: Windows.HWND;
   strContent: String;
   i: Integer;
begin
  hWnds := FindWindow('notepad',nil);
  if hWnds > 0 then begin
     hWnds := FindWindowEx(hWnds,0,'Edit',nil);
     SendMessage(hWnds, WM_CHAR, Ord('H'),0);
     SendMessage(hWnds, WM_CHAR, Ord('i'),0);
     SendMessage(hWnds, WM_CHAR, Ord('!'),0);
     PostMessage(hWnds, WM_KEYDOWN, VK_RETURN,0);
  end;

//  hWnds := FindWindow(nil, 'Untitled - Notepad');
////    PostMessage(hWnds, WM_COMMAND, 65, 0);
//
//  keybd_event(VkKeyScan('B'), 1, 0, 0); //key down
//  keybd_event(VkKeyScan('B'), 1, KEYEVENTF_KEYUP, 0); //key up
//  ShowMessage(booltostr(PostMessage(hWnds, WM_KEYDOWN, 65, 65)));
//  ShowMessage(booltostr(PostMessage(hWnds, WM_KEYUP, 65, 65)));
//  //Sleep(100);
//  //PostMessage(hWnds, WM_KEYUP, 65, MapVirtualKey(65, 0));
//  strContent := 'Hom nay la ngay';
  For i := 0 to Length(strContent) do
  begin

       //PostMessage(hWnds, VK_F1, Ord(strContent[i]), 0);

       //Sleep(200);
  end;
  //PostMessage(hWnds, WM_COMMAND, 65, 0);
end;



end.

