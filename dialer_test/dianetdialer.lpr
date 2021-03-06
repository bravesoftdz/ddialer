program dianetdialer;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, MainUnit, Windows, dialogs, news, ipconfig;

//{$IFDEF WINDOWS}{$R manifest.rc}{$ENDIF}

var
  Mutex:THandle;


{$R *.res}

begin
  Mutex := CreateMutex(nil, False, 'DianetDialerMutex');
  if Mutex = 0 then
      MessageBoxW(0,PWideChar(UTF8Decode('Невозможно создать мьютекс')), PWideChar(UTF8Decode('Ошибка')), MB_OK or MB_ICONSTOP)
  else if GetLastError = ERROR_ALREADY_EXISTS then
      MessageBoxW(0,PWideChar(UTF8Decode('Программа уже запущена')), PWideChar(UTF8Decode('Ошибка')), MB_OK or MB_ICONSTOP)
  else
    begin
     Application.Title:='Dianet Dialer';
     Application.Initialize;
     Application.CreateForm(TConfigForm, ConfigForm);
     Application.CreateForm(TNewsForm, NewsForm);
     Application.CreateForm(TForm1, Form1);
     Application.Run;
     CloseHandle(Mutex);
    end;
end.

