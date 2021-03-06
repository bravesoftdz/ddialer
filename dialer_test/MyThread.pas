unit MyThread;

{$mode objfpc}

interface

uses
  Classes, SysUtils, ExtCtrls;


  Type
    TShowStatusEvent = procedure(Status: String) of Object;

    TMyThread = class(TThread)
      TimerReConnect: TTimer;
      ShowNews: TTimer;
    private
      fStatusText : string;
      FOnShowStatus: TShowStatusEvent;
      procedure ShowStatus;
      procedure RecOnt(Sender: TObject);
    protected
      procedure Execute; override;
    public
      Constructor Create(CreateSuspended : boolean);
      property OnShowStatus: TShowStatusEvent read FOnShowStatus write FOnShowStatus;

    end;



implementation


constructor TMyThread.Create(CreateSuspended : boolean);
begin
  FreeOnTerminate := True;
  inherited Create(CreateSuspended);
end;



procedure TMyThread.ShowStatus;
 // этот метод запущен главным потоком и поэтому может получить доступ ко всем элементам графического интерфейса.
 begin
   if Assigned(FOnShowStatus) then
   begin
     FOnShowStatus(fStatusText);
   end;
 end;

 procedure TMyThread.Execute;
 var
   newStatus : string;
 begin
   fStatusText := 'TMyThread Starting...';
   Synchronize(@Showstatus);
   fStatusText := 'TMyThread Running...';

   TimerReConnect:= TTimer.Create(nil);
   TimerReConnect.Interval := 10000;
   TimerReConnect.OnTimer := MyThread.RecOnt;

   while (not Terminated) do
//************ код сюда **************** //


//************ код сюда **************** //

     begin
       if NewStatus <> fStatusText then
         begin
           fStatusText := newStatus;
           Synchronize(@Showstatus);
         end;
     end;
 end;

 procedure TMyThread.RecOnt(Sender: TObject);
 begin
  if Connected = True or Connecting = True then
    Exit
  else
  begin
    ConfigForm.DoConnect();
  end;
 end;

 procedure TMyThread.RecTimer(ena:boolean);
 begin

 end;


end.

