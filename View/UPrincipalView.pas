unit UPrincipalView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, WinInet, JPEG;

type
  TfrmPrincipal = class(TForm)
    sbrBarra: TStatusBar;
    pnlCorpo: TPanel;
    lblLink: TLabel;
    edtLink: TEdit;
    btnExceutar: TBitBtn;
    menResponse: TMemo;
    imgImagem: TImage;
    procedure FormShow(Sender: TObject);
    procedure btnExceutarClick(Sender: TObject);
  private
    { Private declarations }
    vCaminhoImagem : String;

    function DownloadImagem(const pUrl : String) : Boolean;
    procedure CarregaImagem(const pUrl : String);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
   Rest.Builder, Rest.Interfaces, Rest.Utils;

{$R *.dfm}

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
   if edtLink.CanFocus then
      edtLink.SetFocus;

   vCaminhoImagem := ExtractFilePath(ParamStr(0)) + 'temp_image.jpg';

   edtLink.Text := 'https://api.thecatapi.com/v1';

   menResponse.Clear;
end;

procedure TfrmPrincipal.btnExceutarClick(Sender: TObject);
var
   xUrl,
   xResponse : String;
   xRequest  : IRestBuilder;
begin
   xRequest := TRestBuilder.Create;

   xResponse := xRequest.Rest
      .UrlBase(edtLink.Text)
      .Rota('/images/search')
      .Tipo(RequestGET)
      .Build
   .Executa;

   if xRequest.StatusCode = 200 then
   begin
      menResponse.Text := xResponse;
      xUrl := TJsonUtils.ParseJsonValue(xResponse, 'url');
      CarregaImagem(xUrl);
   end;
end;

function TfrmPrincipal.DownloadImagem(const pUrl: String): Boolean;
var
  hSession,
  hUrl        : HINTERNET;
  xBuffer     : Array[0..1023] of Byte;
  xLerBytes   : DWORD;
  xFileStream : TFileStream;
begin
   Result := False;
   xFileStream := nil;
   try
      hSession := InternetOpen('Delphi', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
      if Assigned(hSession) then
      try
         hUrl := InternetOpenUrl(hSession, PChar(pUrl), nil, 0, INTERNET_FLAG_RELOAD, 0);
         if Assigned(hUrl) then
         begin
            xFileStream := TFileStream.Create(vCaminhoImagem, fmCreate);
            repeat
               InternetReadFile(hUrl, @xBuffer, SizeOf(xBuffer), xLerBytes);
               if xLerBytes > 0 then
                  xFileStream.WriteBuffer(xBuffer, xLerBytes);
            until xLerBytes = 0;
            Result := True;
         end
         else
            RaiseLastOSError;
      finally
         if Assigned(xFileStream) then
            xFileStream.Free;
         InternetCloseHandle(hUrl);
         InternetCloseHandle(hSession);
      end;
   except
      on E: Exception do
      begin
         if Assigned(xFileStream) then
           xFileStream.Free;
         Raise Exception.Create('Erro ao baixar e salvar imagem: ' + E.Message);
      end;
   end;
end;

procedure TfrmPrincipal.CarregaImagem(const pUrl: String);
var
  xJpeg: TJpegImage;
begin
  if DownloadImagem(pUrl) then
     imgImagem.Picture.LoadFromFile(vCaminhoImagem);
end;

end.
