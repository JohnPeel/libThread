library libThread;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}cthreads, cmem,{$ENDIF}
  Classes, strings, SimbaPlugin, LapeThread, LapeCriticalSection;

{$DEFINE extern:=cdecl; export}

function GetPluginABIVersion: Integer; extern;
begin
  Result := 2;
end;

procedure SetPluginMemManager(MemMgr : TMemoryManager); extern;
begin
  if (MemSet) then
    Exit;

  GetMemoryManager(Mem);
  SetMemoryManager(MemMgr);
  MemSet := True;
end;

procedure OnDetach; extern;
begin
  if (MemSet) then
    SetMemoryManager(Mem);
end;

function GetTypeCount(): Integer; extern;
begin
  Result := Length(PluginTypes);
end;

function GetTypeInfo(x: Integer; var sType, sTypeDef: PChar): integer; extern;
begin
  Result := -1;
  if (x < Length(PluginTypes)) and (x >= 0) then
  begin
    strpcopy(sType, PluginTypes[x].Name);
    strpcopy(sTypeDef, PluginTypes[x].Decl);
    Result := x;
  end;
end;

function GetFunctionCount(): Integer; extern;
begin
  Result := Length(PluginMethods);
end;

function GetFunctionInfo(x: Integer; var ProcAddr: Pointer; var ProcDef: PChar): Integer; extern;
begin
  Result := -1;
  if (x < Length(PluginMethods)) and (x >= 0) then
  begin
    strpcopy(ProcDef, PluginMethods[x].Decl);
    ProcAddr := PluginMethods[x].Ptr;
    Result := x;
  end;
end;

exports GetPluginABIVersion;
exports SetPluginMemManager;
exports GetTypeCount;
exports GetTypeInfo;
exports GetFunctionCount;
exports GetFunctionInfo;
exports OnDetach;

{$R *.res}

begin
end.

