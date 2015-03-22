{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit Stax;

interface

uses
  StaxWriter, StaxCommon, StaxFormatting, StaxWriter_Dom, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('Stax', @Register);
end.
