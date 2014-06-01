unit SimbaPlugin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TPluginType = record
    Name, Decl: string;
  end;
  TPluginTypes = array of TPluginType;
  TPluginMethod = record
    Decl: string;
    Ptr: Pointer;
  end;
  TPluginMethods = array of TPluginMethod;

var
  PluginTypes: TPluginTypes;
  PluginMethods: TPluginMethods;
  Mem: TMemoryManager;
  MemSet: Boolean = False;

procedure addType(Name, Decl: string);
procedure addMethod(Decl: string; Ptr: Pointer);

implementation

procedure addType(Name, Decl: string);
var
  H: LongInt;
begin
  H := Length(PluginTypes);
  SetLength(PluginTypes, H + 1);
  PluginTypes[H].Name := Name;
  PluginTypes[H].Decl := Decl;
end;

procedure addMethod(Decl: string; Ptr: Pointer);
var
  H: LongInt;
begin
  H := Length(PluginMethods);
  SetLength(PluginMethods, H + 1);
  PluginMethods[H].Decl := Decl;
  PluginMethods[H].Ptr := Ptr;
end;

end.

