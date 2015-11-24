library AppLib;

uses
  SysUtils,
  Classes;

function AddIntegers(_a, _b: integer): integer; stdcall;
begin
  Result := _a + _b;
end;

exports
   AddIntegers;

begin
end.
