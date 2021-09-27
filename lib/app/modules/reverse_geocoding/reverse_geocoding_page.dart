import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:geolocation_system/app/modules/reverse_geocoding/reverse_geocoding_store.dart';
import 'package:geolocation_system/app/shared/utils/style/style.dart';
import 'package:latlong2/latlong.dart';

class ReverseGeocodingPage extends StatefulWidget {
  final String title;
  const ReverseGeocodingPage({Key? key, this.title = 'ReverseGeocodingPage'}) : super(key: key);
  @override
  ReverseGeocodingPageState createState() => ReverseGeocodingPageState();
}
class ReverseGeocodingPageState extends State<ReverseGeocodingPage> {
  final ReverseGeocodingStore store = Modular.get();
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
    return Scaffold(
      backgroundColor: constStyle.primaryColor,
      appBar: AppBar(
        backgroundColor: constStyle.secondaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        title: const Text("REVERSE GEOCODING"),
      ),
      body: Observer(
        builder: (context) => FlutterMap(
          mapController: store.mapController!,
          options: MapOptions(
            center: store.latLng,
            onTap: (tapPosition, point) {
              store.changeLatLng(LatLng(point.latitude,point.longitude));
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
            MarkerLayerOptions(
              markers: [
                Marker(
                  point: store.latLng,
                  builder: (context) => Icon(
                    Icons.location_on,
                    color: constStyle.secondaryColor,
                    semanticLabel:
                    'Sua localização atual',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}