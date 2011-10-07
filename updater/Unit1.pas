unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Windows;

type

  { TUpdForm }

  TUpdForm = class(TForm)
    Image1: TImage;
    StaticText1: TStaticText;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
    procedure ApplicationPath;
  public
    { public declarations }
  end; 

var
  UpdForm: TUpdForm;
  InstallDir:string;

const
  d1: string = 'dianetdialer.exe';
  d2: string = 'dianetdialer.exe_backup';
  u1: string = 'updater.exe';
  u2: string = 'updater.exe_backup';

implementation

{$R *.lfm}

{ TUpdForm }

procedure TUpdForm.FormCreate(Sender: TObject);
begin
  ApplicationPath;
  DeleteFile(PChar(d2));
  DeleteFile(PChar(u2))
end;



procedure TUpdForm.Timer1Timer(Sender: TObject);
var params:string;
begin
   // привязывем обработчик

   Timer1.Enabled:=false;

   if not FileExists('update.exe') then
      begin
        ShowMessage('Нет файла обновления');
        Close;
        Exit;
      end;

   // ренеймим файл диалера
   if not RenameFile(d1,d2)
      then ShowMessage('Ошибка переименования DianetDialer.exe ');

   // не забываем переименовывать апдейтер
   if not RenameFile(u1,u2)
      then ShowMessage('Ошибка переименования updater.exe ');

   // дальше запускаем обновлялку с путями
   params:='/S'+' '+ '/D='+InstallDir;
   ShellExecute(0,'open','update.exe',Pchar(params),nil,SW_hide);

   close;
end;



procedure TUpdForm.ApplicationPath;
begin
 InstallDir := ExtractFilePath(ParamStr(0));
end;


end.

