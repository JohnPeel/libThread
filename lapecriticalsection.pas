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

