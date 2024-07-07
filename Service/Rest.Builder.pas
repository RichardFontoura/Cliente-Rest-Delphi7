unit Rest.Builder;

interface

uses
   Windows, SysUtils, Classes, WinInet, Rest.Interfaces, Rest.Model, Rest.Utils;

type
   TRestBuilder = Class(TInterfacedObject, IRestBuilder)
      private
         vRest        : IRestModel;
          vStatusCode : Integer;

         function HTTPGet : String;
      public
         constructor Create;

         function Rest       : IRestModel;
         function Executa    : String;
         function StatusCode : Integer;
   end;

implementation

const
   cUserAgent = 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)';

{ TRestBuilder }

constructor TRestBuilder.Create;
begin
   inherited Create;
   vRest := TRestModel.Create(Self);
end;

function TRestBuilder.Rest: IRestModel;
begin
   Result := vRest;
end;

function TRestBuilder.StatusCode : Integer;
begin
   Result := vStatusCode;
end;

function TRestBuilder.Executa: String;
begin
   if vRest.Tipo = RequestNone then
      raise Exception.Create('Tipo da requisição não foi informado.');

   if vRest.UrlBase = EmptyStr then
      raise Exception.Create('URL base da requisição não foi informada.');

   if vRest.Rota = EmptyStr then
      raise Exception.Create('Rota da requisição não foi informado.');

   case vRest.Tipo of
      RequestGET : Result := HTTPGet;
   end;
end;

function TRestBuilder.HTTPGet : String;
var
  hSession,
  hConnect        : HINTERNET;
  xBuffer         : Array[0..1023] of AnsiChar;
  xBytesRead      : DWORD;
  sBuffer,
  xAutoHeader     : String;
  dwStatusCode    : Array[0..3] of Char;
  dwBufferLength,
  dwReserved      : DWORD;
begin
   Result      := EmptyStr;
   vStatusCode := 0;
   try
      hSession := InternetOpen(cUserAgent, INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
      if Assigned(hSession) then
      try
         hConnect := InternetOpenUrl(hSession, PChar(vRest.UrlBase + vRest.Rota), nil, 0, INTERNET_FLAG_RELOAD, 0);
         if Assigned(hConnect) then
         try
            if vRest.Autorizacao <> EmptyStr then
            begin
               xAutoHeader := vRest.Autorizacao;
               HttpAddRequestHeaders(hConnect, PChar(xAutoHeader), Length(xAutoHeader), HTTP_ADDREQ_FLAG_ADD or HTTP_ADDREQ_FLAG_REPLACE);
            end;

            // Obter o código de status HTTP
            dwBufferLength := SizeOf(dwStatusCode);
            dwReserved := 0;
            if HttpQueryInfo(hConnect, HTTP_QUERY_STATUS_CODE, @dwStatusCode[0], dwBufferLength, dwReserved) then
            begin
               SetString(sBuffer, dwStatusCode, dwBufferLength);
               vStatusCode := StrToIntDef(sBuffer, 0);
            end;

            repeat
               InternetReadFile(hConnect, @xBuffer, SizeOf(xBuffer), xBytesRead);
               if xBytesRead > 0 then
               begin
                  SetString(sBuffer, xBuffer, xBytesRead);
                  Result := Result + sBuffer;
               end;
            until xBytesRead = 0;
         finally
            InternetCloseHandle(hConnect);
         end;
      finally
         InternetCloseHandle(hSession);
      end;
   except
      on e:exception do
         raise exception.Create('Falha ao consultar API: ' + e.Message);
   end;
end;

end.
