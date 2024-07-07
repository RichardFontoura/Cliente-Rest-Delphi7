unit Rest.Model;

interface

uses
   SysUtils, Classes, Rest.Interfaces, Rest.Utils;

type
   TRestModel = Class(TInterfacedObject, IRestModel)
      private
         vTipo        : TRESTRequestType;
         vUrlBase     : String;
         vRota        : String;
         vAutorizacao : String;
         vBuilder     : IRestBuilder;
      public
         constructor Create(pBuilder : IRestBuilder);

         function Tipo       (pTipo : TRESTRequestType) : IRestModel; overload;
         function UrlBase    (pUrl  : String)           : IRestModel; overload;
         function Rota       (pRota : String)           : IREstModel; overload;
         function Autorizacao(pAuto : String)           : IRestModel; overload;

         function Tipo        : TRESTRequestType; overload;
         function UrlBase     : String; overload;
         function Rota        : String; overload;
         function Autorizacao : String; overload;

         function Build : IRestBuilder;
         function Clear : IRestModel;
   end;

implementation

{ TRestModel }

constructor TRestModel.Create(pBuilder: IRestBuilder);
begin
   inherited Create;
   vBuilder := pBuilder;
   Clear;
end;

function TRestModel.Tipo(pTipo: TRESTRequestType): IRestModel;
begin
   vTipo  := pTipo;
   Result := Self;
end;

function TRestModel.UrlBase(pUrl: String): IRestModel;
begin
   vUrlBase := pUrl;
   Result   := Self;
end;

function TRestModel.Rota(pRota: String): IREstModel;
begin
   vRota  := pRota;
   Result := Self;
end;

function TRestModel.Autorizacao(pAuto: String): IRestModel;
begin
   vAutorizacao := pAuto;
   Result       := Self;
end;

function TRestModel.Tipo: TRESTRequestType;
begin
   Result := vTipo;
end;

function TRestModel.UrlBase: String;
begin
   Result := vUrlBase;
end;

function TRestModel.Rota: String;
begin
   Result := vRota;
end;

function TRestModel.Autorizacao: String;
begin
   Result := vAutorizacao;
end;

function TRestModel.Clear: IRestModel;
begin
   vTipo        := RequestNone;
   vUrlBase     := EmptyStr;
   vRota        := EmptyStr;
   vAutorizacao := EmptyStr;
   Result       := Self;
end;

function TRestModel.Build: IRestBuilder;
begin
   Result := vBuilder;
end;

end.
