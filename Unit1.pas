unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, U_TJSONMaps,
  System.Sensors, System.Sensors.Components, FMX.ScrollBox, FMX.Memo,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Maps, FMX.Objects, FMX.TabControl;

 Const

  MinhaLatFic : Double = -19.918953;
  MinhaLonFic : Double = -43.938521;


type
  TForm1 = class(TForm)
    LocationSensor: TLocationSensor;
    MapView1: TMapView;
    Memo: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Rectangle1: TRectangle;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    procedure LocationSensorLocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private


    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  TApiMapas : TJSONMapsIntegracao;

implementation

{$R *.fmx}

procedure TForm1.Button10Click(Sender: TObject);
begin

   TApiMapas.AddMarcaMapView( MapView1 ,'Cliente 1', 'Av.Olegário Macial',-19.924870,-43.945642);
   TApiMapas.AddMarcaMapView( MapView1 ,'Seu Cliente 2', 'Rua Rio Grande do Sul',-19.925798,-43.947391);
   TApiMapas.AddMarcaMapView( MapView1 ,'Nome do seu Cliente', 'Rua Mato Grosso',-19.926503,-43.948926);

end;

procedure TForm1.Button11Click(Sender: TObject);
begin

  TApiMapas.MostrarOcultarMarcacao( False ); // Ocultar todas

 {
  TApiMapas.MostrarOcultarMarcacao( True ); // Mostrar todas
  TApiMapas.MostrarOcultarMarcacao( 'Cliente 1', 'Av.Olegário Macial' ); // Mostrar/Ocultar uma especifica
  }


end;

procedure TForm1.Button12Click(Sender: TObject);
begin

  TApiMapas.MostrarOcultarMarcacao( True ); // Mostrar todas

 {
  TApiMapas.MostrarOcultarMarcacao( True ); // Mostrar todas
  TApiMapas.MostrarOcultarMarcacao( 'Cliente 1', 'Av.Olegário Macial' ); // Mostrar/Ocultar uma especifica
  }


end;

procedure TForm1.Button13Click(Sender: TObject);
begin

  TApiMapas.LimparMarcacoes(MapView1);

end;

procedure TForm1.Button14Click(Sender: TObject);
begin

  TApiMapas.ExcluirMarcaMapView('Nome do seu Cliente', 'Rua Mato Grosso');  // excluir pelo titulo e texto

end;

procedure TForm1.Button1Click(Sender: TObject);
begin

   LocationSensor.Active := True;

   //MapView1.Location   := TMapCoordinate.Create(MinhaLatFic, MinhaLonFic);


   {TApiMapas.LimparMarcacoes( MapView1 ); // Limpando todas marcações
   TApiMapas.AddMarcaMapView( MapView1 ,'Delphi Sem Enrolação', 'Aqui está a minha localização',MinhaLatFic,MinhaLonFic);
    }
end;

procedure TForm1.Button2Click(Sender: TObject);
begin


   TApiMapas.Logradouro_Dest := 'Avenida Paulista';
   TApiMapas.Numero_Dest     := '20';
   TApiMapas.Bairro_Dest     := 'Bela Vista';
   TApiMapas.Cidade_Dest     := 'São Paulo';
   TApiMapas.UF_Dest         := 'SP';

   TApiMapas.GetDistancia( tsDirigindo {, tsPasseio, tsCiclismo, tsTransito} );

   Memo.Text := TApiMapas.RetDistancia + ' Duração ' + TApiMapas.RetDistanciaDuracao;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin

   TApiMapas.GetDistanciaLatLon(-22.865815, -46.035565); // Monte Verde - MG

   Memo.Text := FloatToStr( TApiMapas.RetDistanciaLatLon ) + ' Km ';

end;

procedure TForm1.Button4Click(Sender: TObject);
begin

   // Retornar o Endereço de Lat e Lon
   TApiMapas.Latitude  := '-19.884597';
   TApiMapas.Longitude := '-43.914976';
   TApiMapas.GetEndereco();
   Memo.Text := TApiMapas.RetEnderecoCompleto;


   TApiMapas.Logradouro := 'Rua da Bahia';
   TApiMapas.Numero     := '1900';
   TApiMapas.Bairro     := 'Lourdes';
   TApiMapas.Cidade     := 'Belo Horizonte';
   TApiMapas.UF         := 'MG';

   TApiMapas.GetLatLog( tsString );
   Memo.Lines.Add( TApiMapas.Latitude + ' - ' + TApiMapas.Longitude );

end;

procedure TForm1.Button5Click(Sender: TObject);
begin

  TApiMapas.SetTipoMapa( MapView1,tsNormal {, tsTerra, tsSatelite, tsHybrid });

end;

procedure TForm1.Button6Click(Sender: TObject);
begin

  TApiMapas.SetTipoMapa( MapView1, {tsNormal , tsTerra,} tsSatelite{, tsHybrid } );

end;

procedure TForm1.Button7Click(Sender: TObject);
begin

  {** Google }
  TApiMapas.SetInfoTransito( MapView1, True { Mostrar ou Não });
 ShowMessage('Mostrar trânsito ( Google )' );


end;

procedure TForm1.Button8Click(Sender: TObject);
begin

 TApiMapas.SetInfoPrediosMaps( MapView1, True { Mostrar ou Não });
 ShowMessage('Mostrar Prédios ' );

end;

procedure TForm1.Button9Click(Sender: TObject);
begin

 {** Apple }
 TApiMapas.SetInfoPontosInteresse( MapView1, True { Mostrar ou Não });

 ShowMessage('Mostrar Pontos de Interesse ( Apple )' );

end;

procedure TForm1.FormShow(Sender: TObject);
begin

  TApiMapas := TJSONMapsIntegracao.Create;
  TApiMapas.APIKey := 'SUAPI';

  TApiMapas.MinhaLocLatitude  := MinhaLatFic;
  TApiMapas.MinhaLocLongitude := MinhaLonFic;

   if TApiMapas.Logradouro = '' then
   Begin

      TApiMapas.Logradouro := 'Avenida Amazonas';
      TApiMapas.Numero     := '50';
      TApiMapas.Bairro     := 'Centro';
      TApiMapas.Cidade     := 'Belo Horizonte';
      TApiMapas.UF         := 'MG';

   End;


end;

procedure TForm1.LocationSensorLocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
Var
 NLocalizacao : TLocationCoord2D;
begin

    if NewLocation.Latitude <> 0 then
    Begin

      MapView1.Location   := TMapCoordinate.Create( NewLocation.Latitude ,  NewLocation.Longitude );

      NLocalizacao                := NewLocation;
      TApiMapas.MinhaLocLatitude  := NewLocation.Latitude;
      TApiMapas.MinhaLocLongitude := NewLocation.Longitude;

      TApiMapas.SetGeoLocalizacao( LocationSensor, NLocalizacao );


      LocationSensor.Active := False;


    End;

end;

end.
