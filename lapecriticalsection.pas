unit LapeCriticalSection;

{$mode objfpc}{$H+}

interface

{$DEFINE extern:=cdecl}

uses
  Classes, SysUtils, SimbaPlugin, syncobjs;

implementation

procedure TCriticalSection_Init(var CriticalSection: TCriticalSection); extern;
begin
  CriticalSection := TCriticalSection.Create();
end;

procedure TCriticalSection_Free(var CriticalSection: TCriticalSection); extern;
begin
  CriticalSection.Free;
  CriticalSection := nil;
end;

procedure TCriticalSection_Acquire(var CriticalSection: TCriticalSection); extern;
begin
  CriticalSection.Acquire;
end;

procedure TCriticalSection_Release(var CriticalSection: TCriticalSection); extern;
begin
  CriticalSection.Release;
end;

initialization
  addType('TSynchroObject', 'type TObject');
  addType('TCriticalSection', 'type TSynchroObject');

  addMethod('procedure TCriticalSection.Init();', @TCriticalSection_Init);
  addMethod('procedure TCriticalSection.Free();', @TCriticalSection_Free);
  addMethod('procedure TCriticalSection.Acquire();', @TCriticalSection_Acquire);
  addMethod('procedure TCriticalSection.Release();', @TCriticalSection_Release);
end.

