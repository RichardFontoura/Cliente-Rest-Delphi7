unit Rest.Interfaces;

interface

uses
   WinInet, Rest.Utils;

type
   IRestBuilder = interface;

   IRestModel = interface
   ['{38803AF3-F0E8-4D91-A3A4-93141D55133E}']
      function Tipo       (pTipo : TRESTRequestType) : IRestModel; overload;
      function UrlBase    (pUrl  : String)           : IRestModel; overload;
      function Rota       (pRpta : String)           : IRestModel; overload;
      function Autorizacao(pAuto : String)           : IRestModel; overload;

      function Tipo        : TRESTRequestType; overload;
      function UrlBase     : String;  overload;
      function Rota        : String;  overload;
      function Autorizacao : String;  overload;

      function Build : IRestBuilder;
      function Clear : IRestModel;
   end;
   IRestBuilder = interface
   ['{13C9892A-13FE-46D2-96B9-DFA34ACC2EEA}']
      function HTTPGet    : String;
      function Rest       : IRestModel;
      function Executa    : String;
      function StatusCode : Integer;
   end;

implementation

end.
