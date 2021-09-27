import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';

part 'reverse_geocoding_store.g.dart';

class ReverseGeocodingStore = _ReverseGeocodingStoreBase with _$ReverseGeocodingStore;
abstract class _ReverseGeocodingStoreBase with Store {
  MapController? mapController;
  BuildContext? context;

  @observable
  LatLng latLng = LatLng(-5.8112814, -35.2084129);
  @action
  void changeLatLng(LatLng value) {
    latLng = value;
    searchAddressByCoodinator();
  }

  Future<void> getMyPosition() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    latLng = LatLng(_locationData.latitude!, _locationData.longitude!);
    mapController!.move(latLng, mapController!.zoom);
  }


  void searchAddressByCoodinator() async {
    Dio dio = Dio();
    var url = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=${latLng.latitude}&lon=${latLng.longitude}&zoom=18&addressdetails=1&county=Brasil");
    var response = await dio.get(url.toString());
    Map data = await response.data;
    showDialog(context: context!,
      builder: (context) => AlertDialog(
        title: const Center(child: Text("Reverse Info"),),
        scrollable: true,
        shape: const RoundedRectangleBorder(borderRadius:
        BorderRadius.all(Radius.circular(10))),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Road: ${data["address"]["road"]}" ),
            Text("Suburb: ${(data["address"]["suburb"]??"")}"),
            Text("Village: ${(data["address"]["village"]??"")}"),
            Text("City: ${data["address"]["city"]}"),
            Text("State: ${data["address"]["state"]}"),
            Text("Lat: ${data["lat"]}"),
            Text("Lng: ${data["lon"]}"),
          ],
        ),
      )
    );
  }

}