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

