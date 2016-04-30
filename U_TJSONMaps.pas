{** Classes desenvolvida por Jonatan Souza, com o objetivo de facilitar a integração de aplicativos mobile com Google Maps

   Autor: Jonatan Souza
   Data : 28/03/2016
   Canal Youtube : Delphi Sem enrolação : https://www.youtube.com/channel/UC6omhlEXe3ZCMDZd3WyB4_A
   Compatibilidade : Windws, Android e IOS

 }



unit U_TJSONMaps;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.StdCtrls, System.Json, IdHTTP, FMX.Graphics,
  FMX.ScrollBox, FMX.Memo, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, FMX.Maps, FMX.TabControl, System.Net.URLClient, System.Math,

  FMX.Objects, System.Sensors, System.Sensors.Components,

  {$IFDEF MSWINDOWS}
     System.Win.Sensors,
  {$ENDIF}

  {$IFDEF ANDROID}
     System.Android.Sensors,
  {$ENDIF}

  {$IFDEF IOS}
     System.IOS.Sensors,
  {$ENDIF}

  System.Net.HttpClient, System.Net.HttpClientComponent, Soap.SOAPHTTPTrans, System.Generics.Collections;

Type

   tModo = (tsDirigindo, tsPasseio, tsCiclismo, tsTransito);
   tTipoMap = (tsNormal, tsTerra, tsSatelite, tsHybrid );
   tTipoDadoLatLog = (tsString, tsFloat);
type


 TJSONMapsIntegracao = class
private


    FLogradouro: String;
    FLatitude: String;
    FBairro: String;
    FUF: String;
    FLongitude: String;
    FNumero: String;
    FCidade: String;
    FMsgErro: String;
    FRetEnderecoCompleto: String;
    FCidade_Dest: String;
    FNumero_Dest: String;
    FBairro_Dest: String;
    FUF_Dest: String;
    FLogradouro_Dest: String;
    FRetDistancia: String;
    FRetDistanciaDuracao: String;
    FAPIKey: String;
    FOcultarMarcacao : Boolean;
    FZoomMapView: Double;
    FRetDistanciaLatLon: Real;
    FMinhaLocLongitude: Double;
    FMinhaLocLatitude: Double;
    FMinhaLocArea: String;
    FMinhaLocCidade: String;
    FMinhaLocPais: String;
    FMinhaLocEndereco: String;
    FMinhaLocNumEndereco: String;
    FMinhaLocBairro: String;
    FMinhaLocCodigoPais: String;
    FMinhaLocUF: String;
    FMinhaLocCEP: String;
    FMinhaLocEstado: String;
    FImageScreenshot : TImage;
    FIconPersonalizado: TImage;

    procedure SetBairro(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetLatitude(const Value: String);
    procedure SetLongitude(const Value: String);
    procedure SetLogradouro(const Value: String);
    procedure SetNumero(const Value: String);
    procedure SetUF(const Value: String);

    Function GetURL( URL : String ) : String;
    procedure SetBairro_Dest(const Value: String);
    procedure SetCidade_Dest(const Value: String);
    procedure SetNumero_Dest(const Value: String);
    procedure SetUF_Dest(const Value: String);
    procedure SetLogradouro_Dest(const Value: String);
    procedure SetAPIKey(const Value: String);
    procedure AjustarMapView( Mapa : TMapView );
    procedure SetZoomMapView(const Value: Double);
    procedure SetMinhaLocLatitude(const Value: Double);
    procedure SetMinhaLocLongitude(const Value: Double);
    procedure SetMinhaLocArea(const Value: String);
    procedure SetMinhaLocBairro(const Value: String);
    procedure SetMinhaLocCEP(const Value: String);
    procedure SetMinhaLocCidade(const Value: String);
    procedure SetMinhaLocCodigoPais(const Value: String);
    procedure SetMinhaLocEndereco(const Value: String);
    procedure SetMinhaLocNumEndereco(const Value: String);
    procedure SetMinhaLocPais(const Value: String);
    procedure SetMinhaLocUF(const Value: String);

    Procedure OnGeocodeReverseEventJSONMap(const Address: TCivicAddress);
    procedure SetMinhaLocEstado(const Value: String);
    Procedure SalvarScreenshot(const Bitmap: TBitmap);
    procedure SetIconPersonalizado(const Value: TImage);


public
  Constructor Create;
  procedure Destroy;


  Property Logradouro : String read FLogradouro write SetLogradouro;
  Property Numero : String read FNumero write SetNumero;
  Property Bairro : String read FBairro write SetBairro;
  Property Cidade : String read FCidade write SetCidade;
  Property UF : String read FUF write SetUF;

  Property Logradouro_Dest : String read FLogradouro_Dest write SetLogradouro_Dest;
  Property Numero_Dest : String read FNumero_Dest write SetNumero_Dest;
  Property Bairro_Dest : String read FBairro_Dest  write SetBairro_Dest;
  Property Cidade_Dest : String read FCidade_Dest write SetCidade_Dest;
  Property UF_Dest : String read FUF_Dest write SetUF_Dest;

  Property Latitude : String read FLatitude write SetLatitude;
  Property Longitude : String read FLongitude write SetLongitude;

  Property MinhaLocLatitude : Double read FMinhaLocLatitude write SetMinhaLocLatitude;
  Property MinhaLocLongitude : Double read FMinhaLocLongitude write SetMinhaLocLongitude;
  Property MinhaLocArea : String read FMinhaLocArea write SetMinhaLocArea;
  Property MinhaLocEndereco : String read FMinhaLocEndereco write SetMinhaLocEndereco;
  Property MinhaLocNumEndereco : String read FMinhaLocNumEndereco write SetMinhaLocNumEndereco;
  Property MinhaLocCEP : String read FMinhaLocCEP write SetMinhaLocCEP;
  Property MinhaLocBairro : String read FMinhaLocBairro write SetMinhaLocBairro;
  Property MinhaLocCidade : String read FMinhaLocCidade write SetMinhaLocCidade;
  Property MinhaLocEstado : String read FMinhaLocEstado write SetMinhaLocEstado;
  Property MinhaLocUF : String read FMinhaLocUF write SetMinhaLocUF;
  Property MinhaLocCodigoPais : String read FMinhaLocCodigoPais write SetMinhaLocCodigoPais;
  Property MinhaLocPais : String read FMinhaLocPais write SetMinhaLocPais;
  property IconPersonalizado : TImage read FIconPersonalizado write SetIconPersonalizado;

  property MsgErro : String read FMsgErro;
  Property APIKey : String read FAPIKey write SetAPIKey;
  Property ZoomMapView : Double read FZoomMapView write SetZoomMapView;

  property RetEnderecoCompleto : String read FRetEnderecoCompleto;
  property RetDistancia : String read FRetDistancia;
  property RetDistanciaDuracao : String read FRetDistanciaDuracao;
  property RetDistanciaLatLon : Real read FRetDistanciaLatLon;


  Procedure GetLatLog( Tipo : tTipoDadoLatLog = tsString );
  Procedure GetEndereco;
  Procedure GetDistancia( ModoViagem : tModo );
  Procedure GetDistanciaLatLon( DestLat, DestLon : Extended );

  {** Mais informações http://docwiki.embarcadero.com/Libraries/XE8/en/FMX.Maps.TMapLayerOptions }
  Procedure SetInfoTransito( Mapa : TMapView; Valor : Boolean );
  Procedure SetInfoPontosInteresse( Mapa : TMapView; Valor : Boolean );
  Procedure SetInfoPrediosMaps( Mapa : TMapView; Valor : Boolean );
  Procedure SetInfoUsarLocalizacao( Mapa : TMapView; Valor : Boolean );
  {**}

  Procedure AddMarcaMapView( Mapa : TMapView; Titulo, Texto : String; Lat, Lon : Double; Icon : TBitmap = Nil; AtualizaMapa : Boolean = True );
  Procedure AddMarcaMapCicloView( Mapa : TMapView; Titulo, Texto : String; Lat, Lon : Double; Icon : TBitmap = Nil; AtualizaMapa : Boolean = True );
  Procedure AddMarcaMapPoligonoView( Mapa : TMapView; Titulo, Texto : String; Lat, Lon : Double; Icon : TBitmap = Nil; AtualizaMapa : Boolean = True );

  Function ExcluirMarcaMapView( Titulo, Texto : String ) : Boolean;
  Function MostrarOcultarMarcacao( Titulo, Texto : String ) : Boolean; overload;
  Procedure MostrarOcultarMarcacao( Visivel : Boolean = True ); overload;
  Procedure LimparMarcacoes( Mapa : TMapView );
  Procedure SetTipoMapa( Mapa : TMapView; Tipo : tTipoMap );
  Procedure SetGeoLocalizacao( CompLocalizacao : TLocationSensor; NewLocation : TLocationCoord2D );

  Procedure SetSalvarImagemMapa( Mapa : TMapView );
  Function GetSalvarImagemMapa : TImage;
end;

Var
 NetRequest : TNetHTTPRequest;
 NetClient  : TNetHTTPClient;
 mapMarcacao   : TMapMarkerDescriptor;
 mapMarcacaoCiclo : TMapCircleDescriptor;
 mapMarcacaoPolig : TMapPolygonDescriptor;
 mapScreen : TMapScreenshotRecipient;
 mapCordenada      : TMapCoordinate;
 mapListMarcacao   : TList<TMapMarker>;
 mapGeocoder        : TGeocoder;
implementation


{ TJSONMapsIntegracao }

procedure TJSONMapsIntegracao.AddMarcaMapCicloView(Mapa: TMapView; Titulo,
  Texto: String; Lat, Lon: Double; Icon: TBitmap; AtualizaMapa: Boolean);
begin

 {

  mapCordenada               := TMapCoordinate.Create(Lat, Lon);
  mapCordenada.Latitude      := Lat;
  mapCordenada.Longitude     := Lon;


  mapMarcacaoCiclo               := TMapCircle.Create(mapCordenada,'');
  mapMarcacaoCiclo.FillColor     := TAlphaColorRec.LtGray;

  mapListMarcacao.Add( Mapa.AddMarker(mapMarcacaoCiclo) );

  if FZoomMapView <=0 then
  FZoomMapView := 16;

  if AtualizaMapa then
  Begin

    AjustarMapView( Mapa );
    Mapa.Zoom := FZoomMapView;

  End;}

end;

procedure TJSONMapsIntegracao.AddMarcaMapPoligonoView(Mapa: TMapView; Titulo,
  Texto: String; Lat, Lon: Double; Icon: TBitmap; AtualizaMapa: Boolean);
begin

  {mapCordenada               := TMapCoordinate.Create(Lat, Lon);
  mapCordenada.Latitude      := Lat;
  mapCordenada.Longitude     := Lon;

  mapMarcacaoPolig               := TMapPolygon.Create(mapCordenada,'');
  mapMarcacaoPolig.FillColor     := TAlphaColorRec.LtGray;;

  if Icon <> Nil then
  mapMarcacao.Icon := Icon;

  mapListMarcacao.Add( Mapa.AddMarker(mapMarcacaoPolig) );

  if FZoomMapView <=0 then
  FZoomMapView := 16;

  if AtualizaMapa then
  Begin

    AjustarMapView( Mapa );
    Mapa.Zoom := FZoomMapView;

  End;  }

end;

procedure TJSONMapsIntegracao.AddMarcaMapView(Mapa: TMapView; Titulo, Texto: String; Lat, Lon: Double; Icon : TBitmap = Nil; AtualizaMapa : Boolean = True);
begin

  mapCordenada               := TMapCoordinate.Create(Lat, Lon);
  mapCordenada.Latitude      := Lat;
  mapCordenada.Longitude     := Lon;

  mapMarcacao               := TMapMarkerDescriptor.Create(mapCordenada,'');
  mapMarcacao.Draggable     := True;
  mapMarcacao.Visible       := True;
  mapMarcacao.Title         := Titulo;
  mapMarcacao.Snippet       := Texto;

  if Icon <> Nil then
  mapMarcacao.Icon := Icon;

  mapListMarcacao.Add( Mapa.AddMarker(mapMarcacao) );

  if FZoomMapView <=0 then
  FZoomMapView := 16;

  if AtualizaMapa then
  Begin

    AjustarMapView( Mapa );
    Mapa.Zoom := FZoomMapView;

  End;

end;

procedure TJSONMapsIntegracao.AjustarMapView( Mapa : TMapView );
begin

  If mapListMarcacao.Count > 0 Then
  Mapa.Location := mapListMarcacao.Last.Descriptor.Position;

end;

constructor TJSONMapsIntegracao.Create;
begin

    NetRequest        := TNetHTTPRequest.Create( Nil );
    NetClient         := TNetHTTPClient.Create( Nil );
    NetRequest.Client := NetClient;

    mapListMarcacao     := TList<TMapMarker>.Create;
    FOcultarMarcacao    := True;
    FZoomMapView        := 16;
    FMinhaLocLongitude  := 0;
    FMinhaLocLatitude   := 0;

    FImageScreenshot := TImage.Create( Nil );

end;

procedure TJSONMapsIntegracao.Destroy;
begin

   NetRequest.DisposeOf;
   NetClient.DisposeOf;

end;

function TJSONMapsIntegracao.ExcluirMarcaMapView( Titulo, Texto: String): Boolean;
Var
 Marker: TMapMarker;
begin

 Result := False;

 if (mapListMarcacao <> Nil) And ( mapListMarcacao.Count > 0 ) then
 Begin

  for Marker in mapListMarcacao do
  Begin

     if ( Marker.Descriptor.Title = Titulo ) And ( Marker.Descriptor.Snippet = Texto ) then
     Begin

       Marker.Remove;
       Result := True;

     End;

  End;

 End;

end;

Procedure TJSONMapsIntegracao.GetDistancia( ModoViagem : tModo );
Var
  LJsonObj  : TJSONObject;
  LRows, LElements, LItem : TJSONValue;
  URL : String;
  Origem, Destino, sModoViagem : String;
begin


  Try

     FLatitude := '';
     FLongitude := '';
     FMsgErro  := '';

     if (FLogradouro = '') Or (FNumero = '') Or (FBairro = '') Or (FCidade = '') Or (FLogradouro_Dest = '') then
     Begin

        FLatitude := '';
        FLongitude := '';
        Exit;

     End;

     if ModoViagem = tsDirigindo then
      sModoViagem := 'DRIVING'
     else
     if ModoViagem = tsPasseio then
      sModoViagem := 'WALKING'
     else
     if ModoViagem = tsCiclismo then
      sModoViagem := 'BICYCLING'
     else
     if ModoViagem = tsTransito then
      sModoViagem := 'TRANSIT'
     else
      sModoViagem := 'DRIVING';

     sModoViagem := LowerCase( sModoViagem );

     if (sModoViagem = 'transit') And (FAPIKey = '') then
     Begin

       FMsgErro := 'Para este serviço necessita passar a API Key';
       Exit;

     End;


     Origem  := FLogradouro + '%20' + FNumero + '%20' + FBairro + '%20' + FCidade + '%20' + FUF;
     Destino := FLogradouro_Dest + '%20' + FNumero_Dest + '%20' + FBairro_Dest + '%20' + FCidade_Dest + '%20' + FUF_Dest;

     if (sModoViagem = 'transit') then
      URL := GetURL('https://maps.googleapis.com/maps/api/distancematrix/json?origins=' + Origem + '&destinations=' + Destino + '&mode=' + sModoViagem + '&language=pt-BR&sensor=false&key=' + FAPIKey)
     Else
      URL := GetURL('https://maps.googleapis.com/maps/api/distancematrix/json?origins=' + Origem + '&destinations=' + Destino + '&mode=' + sModoViagem + '&language=pt-BR&sensor=false');

     LJsonObj    := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(URL),0) as TJSONObject;

     if LJsonObj = Nil then
     Exit;

     if POS('error_message', LJsonObj.Value ) > 0 then
     Begin
        FMsgErro :=  LJsonObj.Value;
        Exit;
     end;



     LRows     := LJsonObj.Get('rows').JsonValue;

     if LRows = Nil then
     Exit;

     LElements := TJSONObject(TJSONArray(LRows).Get(0)).Get('elements').JsonValue;

     if LElements = Nil then
     Exit;

     LElements := TJSONObject(TJSONArray(LElements).Get(0)).Get('distance').JsonValue;

     if LElements = Nil then
     Exit;

     FRetDistancia     := TJSONObject( LElements).Get('text').JsonValue.Value;

     LElements := TJSONObject(TJSONArray(LRows).Get(0)).Get('elements').JsonValue;

     if LElements = Nil then
     Exit;

     LElements := TJSONObject(TJSONArray(LElements).Get(0)).Get('duration').JsonValue;

     if LElements = Nil then
     Exit;

     FRetDistanciaDuracao  := TJSONObject( LElements).Get('text').JsonValue.Value;




   Except On E : Exception Do
     Begin

       FMsgErro := E.Message;
       LJsonObj := Nil;

    End;
   end;


    LJsonObj := Nil;


end;

procedure TJSONMapsIntegracao.GetDistanciaLatLon( DestLat, DestLon : Extended ) ;
Var
 arcoA, arcoB, arcoC : Extended;
 auxPI : Extended;
begin

  if (FMinhaLocLongitude = 0 ) Or (FMinhaLocLatitude = 0) then
   FRetDistanciaLatLon := 0
  Else
   Begin

      auxPi := Pi / 180;

      arcoA := (DestLon - FMinhaLocLongitude) * auxPi;
      arcoB := (90 - DestLat) * auxPi;
      arcoC := (90 - FMinhaLocLatitude) * auxPi;

      FRetDistanciaLatLon := Cos(arcoB) * Cos(arcoC) + Sin(arcoB) * Sin(arcoC) * Cos(arcoA);
      FRetDistanciaLatLon := (40030 * ((180 / Pi) * ArcCos(FRetDistanciaLatLon))) / 360 ;

   End;

end;

procedure TJSONMapsIntegracao.GetEndereco;
Var
  LJsonObj  : TJSONObject;
  LRows, LItem : TJSONValue;
  URL : String;
begin

 Try

     FRetEnderecoCompleto := '';
     FMsgErro := '';

     if (FLatitude = '') Or (FLongitude = '') then
     Begin

        FLogradouro := '';
        FNumero     := '';

     End;

     if POS(',',FLatitude) > 0 then
     FLatitude := StringReplace( FLatitude, ',','.',[rfReplaceAll]);

     if POS(',',FLongitude) > 0 then
     FLongitude := StringReplace( FLongitude, ',','.',[rfReplaceAll]);


     URL := GetURL('http://maps.googleapis.com/maps/api/geocode/json?latlng=' + FLatitude + ',' + FLongitude + '&sensor=true');

     LJsonObj    := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(URL),0) as TJSONObject;

     if LJsonObj = Nil then
     Exit;

     LRows := LJsonObj.Get('results').JsonValue;

     if LRows = Nil then
     Exit;

     LItem := TJSONObject(TJSONArray(LRows).Get(0)).Get('formatted_address').JsonValue;

     if LItem = Nil then
     Exit;


     FRetEnderecoCompleto := LItem.Value;

   Except On E : Exception Do
   Begin

     FMsgErro := E.Message;
     LJsonObj := Nil;

   End;
 End;

   LJsonObj := Nil;

end;

procedure TJSONMapsIntegracao.GetLatLog( Tipo : tTipoDadoLatLog = tsString );
Var
  LJsonObj  : TJSONObject;
  LRows, LElements, LItem : TJSONValue;
  URL : String;
  Endereco : String;
begin


  Try

     FLatitude  := '';
     FLongitude := '';
     FMsgErro   := '';

     if (FLogradouro = '') Or (FNumero = '') Or (FBairro = '') Or (FCidade = '') then
     Begin

        FLatitude := '';
        FLongitude := '';
        Exit;

     End;

     Endereco := FLogradouro + '%20' + FNumero + '%20' + FBairro + '%20' + FCidade + '%20' + FUF;
     URL := GetURL('http://maps.googleapis.com/maps/api/geocode/json?address=' + Endereco );



     LJsonObj    := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(URL),0) as TJSONObject;

     if LJsonObj = Nil then
     Exit;

     LRows     := LJsonObj.Get('results').JsonValue;

     if LRows = Nil then
     Exit;

     if  TJSONObject(TJSONArray(LRows).Get(0)).Get('geometry').JsonValue <> Nil then
      LElements := TJSONObject(TJSONArray(LRows).Get(0)).Get('geometry').JsonValue
     Else
      LElements := Nil;

     if LElements = Nil then
     Exit;

     LItem     := TJSONObject( LElements).Get('location').JsonValue;

     if LItem = Nil then
     Exit;


     If TJSONObject( LItem ).Get('lng').JsonValue.Value <> '' Then
     FLongitude := TJSONObject( LItem ).Get('lng').JsonValue.Value;

     If TJSONObject( LItem ).Get('lat').JsonValue.Value <> '' Then
     FLatitude := TJSONObject( LItem ).Get('lat').JsonValue.Value;


     if Tipo = tsFloat then
     Begin

         if FLatitude <> '' then
         FLatitude := StringReplace(FLatitude,'.',',',[rfReplaceAll]);

         if FLongitude <> '' then
         FLongitude := StringReplace(FLongitude,'.',',',[rfReplaceAll]);

     End;


   Except On E : Exception Do
     Begin

       FMsgErro := E.Message;
       LJsonObj := Nil;

    End;
   end;

    LJsonObj := Nil;

end;


Function TJSONMapsIntegracao.GetURL( URL : String ) : String;
var
  Resp : IHTTPResponse;
begin

  Resp   := NetRequest.Get( URL );
  Result := Resp.ContentAsString;

end;

procedure TJSONMapsIntegracao.LimparMarcacoes( Mapa : TMapView );
Var
 Marker: TMapMarker;
begin

  Try
   if (mapListMarcacao <> Nil) And ( mapListMarcacao.Count > 0 ) then
   Begin

    for Marker in mapListMarcacao do
    Marker.Remove;

    mapListMarcacao.Clear;

    AjustarMapView( Mapa );

   End;
  Except

  End;
end;

function TJSONMapsIntegracao.MostrarOcultarMarcacao(Titulo,
  Texto: String): Boolean;
Var
 Marker: TMapMarker;
begin

 if (mapListMarcacao <> Nil) And ( mapListMarcacao.Count > 0 ) then
 Begin

  for Marker in mapListMarcacao do
  Begin

    if ( Marker.Descriptor.Title = Titulo ) And ( Marker.Descriptor.Snippet = Texto) then
    Marker.SetVisible(Not Marker.Descriptor.Visible);

  End;

 End;
end;

procedure TJSONMapsIntegracao.MostrarOcultarMarcacao( Visivel : Boolean = True );
Var
 Marker: TMapMarker;
begin

 if (mapListMarcacao <> Nil) And ( mapListMarcacao.Count > 0 ) then
 Begin

   for Marker in mapListMarcacao do
   Marker.SetVisible(Visivel);

 End;

end;

procedure TJSONMapsIntegracao.OnGeocodeReverseEventJSONMap( const Address: TCivicAddress);
begin


  FMinhaLocArea           := Address.AdminArea;
  FMinhaLocEndereco       := UpperCase(Address.Thoroughfare);
  FMinhaLocNumEndereco    := UpperCase(Address.FeatureName);
  FMinhaLocCEP            := Address.PostalCode;
  FMinhaLocBairro         := UpperCase(Address.SubLocality);
  FMinhaLocCidade         := UpperCase(Address.Locality);
  FMinhaLocEstado         := Address.SubAdminArea;
  FMinhaLocCodigoPais     := Address.CountryCode;
  FMinhaLocPais           := UpperCase(Address.CountryName);

end;

procedure TJSONMapsIntegracao.SetSalvarImagemMapa(Mapa: TMapView);
begin

  Mapa.Snapshot(SalvarScreenshot);

end;

function TJSONMapsIntegracao.GetSalvarImagemMapa: TImage;
begin

   if Assigned( FImageScreenshot ) And (FImageScreenshot <> Nil) then
    Result := FImageScreenshot
   Else
    Result := Nil;

end;


procedure TJSONMapsIntegracao.SalvarScreenshot(const Bitmap: TBitmap);
begin

 if Not Assigned( FImageScreenshot ) then
 FImageScreenshot := TImage.Create( Nil );

 FImageScreenshot.Bitmap.Assign(Bitmap);

end;

procedure TJSONMapsIntegracao.SetAPIKey(const Value: String);
begin
  FAPIKey := Value;
end;

procedure TJSONMapsIntegracao.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TJSONMapsIntegracao.SetBairro_Dest(const Value: String);
begin
  FBairro_Dest := Value;
end;

procedure TJSONMapsIntegracao.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TJSONMapsIntegracao.SetCidade_Dest(const Value: String);
begin
  FCidade_Dest := Value;
end;

procedure TJSONMapsIntegracao.SetGeoLocalizacao(  CompLocalizacao: TLocationSensor; NewLocation : TLocationCoord2D);
begin

      If Not Assigned(mapGeocoder) then
      Begin

        if Assigned(TGeocoder.Current) then
          mapGeocoder := TGeocoder.Current.Create;

        if Assigned(mapGeocoder) then
          mapGeocoder.OnGeocodeReverse := OnGeocodeReverseEventJSONMap;

      End;

      if Assigned(mapGeocoder) and not mapGeocoder.Geocoding then
      mapGeocoder.GeocodeReverse(NewLocation);

end;

procedure TJSONMapsIntegracao.SetIconPersonalizado(const Value: TImage);
begin
  FIconPersonalizado := Value;
end;

procedure TJSONMapsIntegracao.SetInfoPontosInteresse(Mapa: TMapView;
  Valor: Boolean);
begin

  { Maps e Maps Apple }

  if Valor then
   Mapa.LayerOptions := Mapa.LayerOptions + [ TMapLayerOption.PointsOfInterest ]
  Else
   Mapa.LayerOptions := Mapa.LayerOptions - [ TMapLayerOption.PointsOfInterest ];

end;

procedure TJSONMapsIntegracao.SetInfoPrediosMaps(Mapa: TMapView;
  Valor: Boolean);
begin

  { Maps e Maps Apple }

  if Valor then
   Mapa.LayerOptions := Mapa.LayerOptions + [ TMapLayerOption.Buildings ]
  Else
   Mapa.LayerOptions := Mapa.LayerOptions - [ TMapLayerOption.Buildings ];

  FZoomMapView  := 17;
  Mapa.Zoom     := FZoomMapView;

end;

procedure TJSONMapsIntegracao.SetInfoTransito(Mapa: TMapView; Valor: Boolean);
begin
  { Somente Google Maps funciona}

  {$IFDEF ANDROID}
  if Valor then
   Mapa.LayerOptions := Mapa.LayerOptions + [ TMapLayerOption.Traffic ]
  Else
   Mapa.LayerOptions := Mapa.LayerOptions - [ TMapLayerOption.Traffic ];
  {$ENDIF}

end;

procedure TJSONMapsIntegracao.SetInfoUsarLocalizacao(Mapa: TMapView;
  Valor: Boolean);
begin

  if Valor then
   Mapa.LayerOptions := Mapa.LayerOptions + [ TMapLayerOption.UserLocation ]
  Else
   Mapa.LayerOptions := Mapa.LayerOptions - [ TMapLayerOption.UserLocation ];

end;

procedure TJSONMapsIntegracao.SetLatitude(const Value: String);
begin
  FLatitude := Value;
end;

procedure TJSONMapsIntegracao.SetLongitude(const Value: String);
begin
  FLongitude := Value;
end;

procedure TJSONMapsIntegracao.SetMinhaLocArea(const Value: String);
begin
  FMinhaLocArea := Value;
end;

procedure TJSONMapsIntegracao.SetMinhaLocBairro(const Value: String);
begin
  FMinhaLocBairro := Value;
end;

procedure TJSONMapsIntegracao.SetMinhaLocCEP(const Value: String);
begin
  FMinhaLocCEP := Value;
end;

procedure TJSONMapsIntegracao.SetMinhaLocCidade(const Value: String);
begin
  FMinhaLocCidade := Value;
end;

procedure TJSONMapsIntegracao.SetMinhaLocCodigoPais(const Value: String);
begin
  FMinhaLocCodigoPais := Value;
end;

procedure TJSONMapsIntegracao.SetMinhaLocEndereco(const Value: String);
begin
  FMinhaLocEndereco := Value;
end;

procedure TJSONMapsIntegracao.SetMinhaLocEstado(const Value: String);
begin
  FMinhaLocEstado := Value;
end;

procedure TJSONMapsIntegracao.SetMinhaLocLatitude(const Value: Double);
begin
  FMinhaLocLatitude := Value;
end;

procedure TJSONMapsIntegracao.SetMinhaLocLongitude(const Value: Double);
begin
  FMinhaLocLongitude := Value;
end;

procedure TJSONMapsIntegracao.SetMinhaLocNumEndereco(const Value: String);
begin
  FMinhaLocNumEndereco := Value;
end;

procedure TJSONMapsIntegracao.SetMinhaLocPais(const Value: String);
begin
  FMinhaLocPais := Value;
end;

procedure TJSONMapsIntegracao.SetMinhaLocUF(const Value: String);
begin
  FMinhaLocUF := Value;
end;

procedure TJSONMapsIntegracao.SetLogradouro(const Value: String);
begin
  FLogradouro := Value;
end;

procedure TJSONMapsIntegracao.SetLogradouro_Dest(const Value: String);
begin
  FLogradouro_Dest := Value;
end;

procedure TJSONMapsIntegracao.SetNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure TJSONMapsIntegracao.SetNumero_Dest(const Value: String);
begin
  FNumero_Dest := Value;
end;

procedure TJSONMapsIntegracao.SetTipoMapa(Mapa: TMapView; Tipo: tTipoMap);
begin

  case Tipo of
     tsNormal   : Mapa.MapType := TMapType.Normal;
     tsTerra    : Mapa.MapType := TMapType.Terrain;
     tsSatelite : Mapa.MapType := TMapType.Satellite;
     tsHybrid   : Mapa.MapType := TMapType.Hybrid;
  end;

end;

procedure TJSONMapsIntegracao.SetUF(const Value: String);
begin
  FUF := Value;
end;

procedure TJSONMapsIntegracao.SetUF_Dest(const Value: String);
begin
  FUF_Dest := Value;
end;

procedure TJSONMapsIntegracao.SetZoomMapView(const Value: Double);
begin
  FZoomMapView := Value;
end;

end.
