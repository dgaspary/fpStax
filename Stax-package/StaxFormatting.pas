{ This file is part of the fpStax.

  Copyright (C) 2013-2019 Daniel F. Gaspary https://github.com/dgaspary

  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the copyright.

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version with the following modification:

  As a special exception, the copyright holders of this library give you
  permission to link this library with independent modules to produce an
  executable, regardless of the license terms of these independent modules,and
  to copy and distribute the resulting executable under terms of your choice,
  provided that you also meet, for each linked independent module, the terms
  and conditions of the license of that module. An independent module is a
  module which is not derived from or based on this library. If you modify
  this library, you may extend this exception to your version of the library,
  but you are not obligated to do so. If you do not wish to do so, delete this
  exception statement from your version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
}

unit StaxFormatting;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

    { TStaxFormatting }

    TStaxFormatting = class
      class function FormatName(Prefix, Localname: String): String; virtual;

      class function AfterDocumentStart: string; virtual;

      class function AfterElementStart: string; virtual;
      class function FormatElementStart(Prefix, Localname: String; Empty, ClosingBracket: boolean): String; virtual;
      class function FormatElementStartClosing(Empty: boolean): string; virtual;

      class function AfterElementEnd: string; virtual;
      class function FormatElementEnd(Prefix, Localname: String): String; virtual;

      class function AfterAttribute: string; virtual;
      class function FormatAttribute(Prefix, Localname, Value: String): String; virtual;
    end;

    TStaxFormattingClass = class of TStaxFormatting;

implementation

class function TStaxFormatting.FormatName(Prefix, Localname: String): String;
var
   vPrefix: String;
begin
     if prefix=''
     then
         vPrefix:=''
     else
         vPrefix:=prefix + ':';

     Result:=Format('%s%s', [vPrefix, localname]);
end;

class function TStaxFormatting.AfterDocumentStart: string;
begin
     Result:='';
end;

class function TStaxFormatting.AfterElementStart: string;
begin
     Result:='';
end;

class function TStaxFormatting.FormatElementStart(Prefix, Localname: String; Empty,
  ClosingBracket: boolean): String;
begin
     Result:='<' + FormatName(Prefix, Localname);

     if ClosingBracket
     then
     begin
          Result+=FormatElementStartClosing(Empty);
     end;
end;

class function TStaxFormatting.FormatElementStartClosing(Empty: boolean): string;
begin
     if Empty
     then
         Result:='/'
     else
         Result:='';

     Result+='>';

     Result+=AfterElementStart;
end;

class function TStaxFormatting.AfterElementEnd: string;
begin
     Result:='';
end;

class function TStaxFormatting.FormatElementEnd(Prefix, Localname: String): String;
begin
     Result:='</' + FormatName(Prefix, Localname) + '>';
     Result:=Result + AfterElementEnd;
end;

class function TStaxFormatting.AfterAttribute: string;
begin
     Result:='';
end;

class function TStaxFormatting.FormatAttribute(Prefix, Localname, Value: String): String;
begin
     Result:=Format('%s="%s"', [FormatName(Prefix, Localname), Value]);

     Result:=Result + AfterAttribute;
end;


end.

