import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:geolocation_system/app/modules/freight_calculation/freight_calculation_store.dart';
import 'package:geolocation_system/app/shared/utils/style/style.dart';
import 'package:latlong2/latlong.dart';

class FreightCalculationPage extends StatefulWidget {
  final String title;
  const FreightCalculationPage({Key? key, this.title = 'FreightCalculationPage'}) : super(key: key);
  @override
  FreightCalculationPageState createState() => FreightCalculationPageState();
}
class FreightCalculationPageState extends State<FreightCalculationPage> {
  final FreightCalculationStore store = Modular.get();
  final ConstStyle constStyle = ConstStyle();

  @override
  void initState() {
    store.mapController = MapController();
    store.context = context;
    store.getMyPosition();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        backgroundColor: constStyle.primaryColor,
        appBar: AppBar(
          backgroundColor: constStyle.secondaryColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          centerTitle: true,
          title: const Text("FREIGHT CALCULATION"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth/5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Client Position"),
                    Icon(
                      Icons.location_on,
                      color: constStyle.secondaryColor,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth/5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Company Position"),
                    Icon(
                      Icons.location_on,
                      color: Colors.orange,
                    )
                  ],
                )
              ),
              Observer(
                builder: (context) => SwitchListTile(
                  title: const Text("Move client position"),
                  activeColor: constStyle.secondaryColor,
                    value: store.moveClient,
                    onChanged: store.changeMoveClient,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: constraints.maxHeight/1.8,
                  width: constraints.maxWidth/1.1,
                  child: Observer(
                    builder: (context) => FlutterMap(
                      mapController: store.mapController!,
                      options: MapOptions(
                        plugins: [
                          TappablePolylineMapPlugin(),
                        ],
                        center: store.latLngClient,
                        onTap: (tapPosition, point) {
                          if(store.moveClient){
                            store.changeLatLngClient(LatLng(point.latitude,point.longitude));
                          }else{
                            store.changeLatLngCompany(LatLng(point.latitude,point.longitude));
                          }

                        },
                      ),
                      layers: [
                        TileLayerOptions(
                            urlTemplate:
                            "http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
                            subdomains: [
                              'mt0',
                              'mt1',
                              'mt2',
                              'mt3'
                            ]),
                        TappablePolylineLayerOptions(
                            polylineCulling: true,
                            pointerDistanceTolerance: 20,
                            polylines: [
                              TaggedPolyline(
                                tag: 'My Polyline',
                                points: store.polylines,
                                color: Colors.blueGrey,
                                strokeWidth: 5.0,
                              ),
                            ],
                        ),
                        MarkerLayerOptions(
                          markers: [
                            Marker(
                              point: store.latLngClient,
                              builder: (context) => Icon(
                                Icons.location_on,
                                color: constStyle.secondaryColor,
                                semanticLabel:
                                'Sua localização atual',
                              ),
                            ),
                            Marker(
                              point: store.latLngCompany,
                              builder: (context) => const Icon(
                                Icons.location_on,
                                color: Colors.orange,
                                semanticLabel:
                                'Sua localização atual',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: constStyle.secondaryColor,
                  minimumSize: Size(
                    constraints.maxWidth/2.5,
                    35
                  ),
                  maximumSize: Size(
                      constraints.maxWidth/2.5,
                      35
                  ),
                ),
                  onPressed: store.calculateDelivery,
                  child: Observer(builder: (BuildContext context) =>
                  store.isLoading? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),),
                  ):const Text("Calculate Delivery"))
              )
            ],
          ),
        ),
      ),
    );
  }
}