{
    libThread - A threading plugin for Simba
    Copyright (C) 2014 by John Peel

    libThread is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    libThread is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    See the file LICENSE, included in this distribution,
    for details about the copyright.
}
unit LapeThread;

{$mode objfpc}{$H+}

interface

{$DEFINE extern:=cdecl}

uses
  Classes, SysUtils, SimbaPlugin;

type
  TLapeThread = class;

  TLapeThreadProc = procedure(Thread: TLapeThread; Data: Pointer); cdecl;
  TLapeThread = class(TThread)
  private
    FMethod: TLapeThreadProc;
    FData: Pointer;
  protected
    procedure Execute(); override;
  public
    constructor Create(Method: TLapeThreadProc; Data: Pointer);
  end;

implementation

procedure TLapeThread.Execute();
begin
  if (Assigned(FMethod)) then
    FMethod(Self, FData);
  if (not Terminated) then
    Terminate;
end;

constructor TLapeThread.Create(Method: TLapeThreadProc; Data: Pointer);
begin
  inherited Create(True);
  FMethod := Method;
  FData := Data;
end;

procedure TThread_Init(var Thread: TLapeThread; Method: TLapeThreadProc; Data: Pointer); extern;
begin
  Thread := TLapeThread.Create(Method, Data);
end;

procedure TThread_Free(var Thread: TLapeThread); extern;
begin
  Thread.Free;
  Thread := nil;
end;

procedure TThread_Start(var Thread: TLapeThread); extern;
begin
  Thread.Start;
end;

procedure TThread_Terminate(var Thread: TLapeThread); extern;
begin
  Thread.Terminate;
end;

function TThread_WaitFor(var Thread: TLapeThread): Integer; extern;
begin
  Result := Thread.WaitFor;
end;

function TThread_FreeOnTerminate_Read(var Thread: TLapeThread): Boolean; extern;
begin
  Result := Thread.FreeOnTerminate;
end;

procedure TThread_FreeOnTerminate_Write(var Thread: TLapeThread; FreeOnTerminate: Boolean); extern;
begin
  Thread.FreeOnTerminate := FreeOnTerminate;
end;

function TThread_Handle_Read(var Thread: TLapeThread): TThreadID; extern;
begin
  Result := Thread.Handle;
end;

function TThread_Priority_Read(var Thread: TLapeThread): TThreadPriority; extern;
begin
  Result := Thread.Priority;
end;

procedure TThread_Priority_Write(var Thread: TLapeThread; Priority: TThreadPriority); extern;
begin
  Thread.Priority := Priority;
end;

function TThread_Suspended_Read(var Thread: TLapeThread): Boolean; extern;
begin
  Result := Thread.Suspended;
end;

procedure TThread_Suspended_Write(var Thread: TLapeThread; Suspended: Boolean); extern;
begin
  Thread.Suspended := Suspended;
end;

function TThread_ThreadID_Read(var Thread: TLapeThread): TThreadID; extern;
begin
  Result := Thread.ThreadID;
end;

function TThread_OnTerminate_Read(var Thread: TLapeThread): TNotifyEvent; extern;
begin
  Result := Thread.OnTerminate;
end;

procedure TThread_OnTerminate_Write(var Thread: TLapeThread; OnTerminate: TNotifyEvent); extern;
begin
  Thread.OnTerminate := OnTerminate;
end;

function TThread_FatalException_Read(var Thread: TLapeThread): TObject; extern;
begin
  Result := Thread.FatalException;
end;

initialization
  addType('TThreadID', 'PtrUInt');
  addType('TThreadPriority', '(tpIdle, tpLowest, tpLower, tpNormal, tpHigher, tpHighest, tpTimeCritical)');
  addType('TThread', 'type TObject');
  addType('TThreadProc', 'procedure(Thread: TThread; Data: Pointer)');

  addMethod('procedure TThread.Init(Method: TThreadProc; Data: Pointer);', @TThread_Init);
  addMethod('procedure TThread.Free();', @TThread_Free);
  addMethod('procedure TThread.Start();', @TThread_Start);
  addMethod('procedure TThread.Terminate();', @TThread_Terminate);
  addMethod('function TThread.WaitFor(): Integer;', @TThread_WaitFor);
  addMethod('function TThread.getFreeOnTerminate(): Boolean;', @TThread_FreeOnTerminate_Read);
  addMethod('procedure TThread.setFreeOnTerminate(FreeOnTerminate: Boolean);', @TThread_FreeOnTerminate_Write);
  addMethod('function TThread.getHandle(): TThreadID;', @TThread_Handle_Read);
  addMethod('function TThread.getPriority(): TThreadPriority;', @TThread_Priority_Read);
  addMethod('procedure TThread.setPriority(Priority: TThreadPriority);', @TThread_Priority_Write);
  addMethod('function TThread.getSuspended(): Boolean;', @TThread_Suspended_Read);
  addMethod('procedure TThread.setSuspended(Suspended: Boolean);', @TThread_Suspended_Write);
  addMethod('function TThread.getThreadID(): TThreadID;', @TThread_ThreadID_Read);
  addMethod('function TThread.getOnTerminate(): TNotifyEvent;', @TThread_OnTerminate_Read);
  addMethod('procedure TThread.setOnTerminate(OnTerminate: TNotifyEvent);', @TThread_OnTerminate_Write);
  addMethod('function TThread.getFatalException(): TObject;', @TThread_FatalException_Read);
end.

