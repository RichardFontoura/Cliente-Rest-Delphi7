unit Rest.Utils;

interface

type
   TRESTRequestType = (
      RequestNone   = 0,
      RequestGET    = 1,
      RequestPOST   = 2,
      RequestPUT    = 3,
      RequestDELETE = 4
   );
   TJsonUtils = class
      public
         class function ParseJsonValue(const pJosnData : String;
            const pChave : String) : String;
   end;
implementation

uses
   SysUtils;

{ TJsonUtils }

class function TJsonUtils.ParseJsonValue(const pJosnData,
  pChave: String): String;
var
   xJsonStr,
   xChaveStr,
   xValorStr : String;
   xPosComeco,
   xPosFinal : Integer;
begin
   Result     := EmptyStr;
   xJsonStr   := pJosnData;
   xChaveStr  := '"' + pChave + '":"';
   xPosComeco := Pos(xChaveStr, xJsonStr);
   if xPosComeco > 0 then
   begin
      Delete(xJsonStr, 1, xPosComeco + Length(xChaveStr) - 1);
      xPosFinal := Pos('"', xJsonStr);
      if xPosFinal > 0 then
      begin
         xValorStr := Copy(xJsonStr, 1, xPosFinal - 1);
         Result := xValorStr;
      end;
   end;
end;

end.
