import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocation_system/app/shared/utils/money_format/double_to_formatting_to_money_string.dart';
import 'package:geolocation_system/app/shared/utils/style/style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:open_route_service/open_route_service.dart';

part 'freight_calculation_store.g.dart';

class FreightCalculationStore = _FreightCalculationStoreBase with _$FreightCalculationStore;
abstract class _FreightCalculationStoreBase with Store {
  MapController? mapController;
  BuildContext? context;
  final ConstStyle constStyle = ConstStyle();
  final OpenRouteService client = OpenRouteService(apiKey: '');



  @observable
  bool isLoading = false;

  @observable
  bool moveClient = true;

  @action
  void changeMoveClient(bool value) {
    moveClient = value;
  }

  @observable
  List<LatLng> polylines = [];

  @action
  Future<void> setPolylines() async {
    final List<Coordinate> routeCoordinates = await client.getRouteCoordinates(
      startCoordinate: Coordinate(latitude: latLngClient.latitude, longitude: latLngClient.longitude),
      endCoordinate: Coordinate(latitude: latLngCompany.latitude, longitude: latLngCompany.longitude),
    );
    final List<LatLng> routePoints = routeCoordinates
        .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
        .toList();
    polylines.clear();
    polylines.addAll(routePoints);
  }


  @observable
  LatLng latLngClient = LatLng(-5.8112814, -35.2084129);

  @observable
  LatLng latLngCompany = LatLng(-5.8112814, -35.2084129);

  @action
  void changeLatLngClient(LatLng value) {
    latLngClient = value;
    setPolylines();
  }

  @action
  void changeLatLngCompany(LatLng value) {
    latLngCompany = value;
    setPolylines();
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
    latLngClient = LatLng(_locationData.latitude!, _locationData.longitude!);
    latLngCompany = LatLng(_locationData.latitude!, _locationData.longitude!);
    mapController!.move(latLngClient, mapController!.zoom);
  }

  @action
  Future<void> calculateDelivery() async {
    isLoading = true;
    Dio dio = Dio();
    var urlClient = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=${latLngClient.latitude}&lon=${latLngClient.longitude}&zoom=18&addressdetails=1&county=Brasil");
    var responseClient = await dio.get(urlClient.toString());
    Map dataClient = await responseClient.data;

    var urlEnd = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=${latLngCompany.latitude}&lon=${latLngCompany.longitude}&zoom=18&addressdetails=1&county=Brasil");
    var responseCompany = await dio.get(urlEnd.toString());
    Map dataCompany = await responseCompany.data;


    double distance = Geolocator.distanceBetween(latLngClient.latitude,
        latLngClient.longitude, latLngCompany.latitude, latLngCompany.longitude);
    distance /= 1000; // trasnforma de metros em km

    showDialog(context: context!,
      builder: (context) => AlertDialog(
          title: const Center(child: Text("Result Delivery"),),
          scrollable: true,
          shape: const RoundedRectangleBorder(borderRadius:
          BorderRadius.all(Radius.circular(10))),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Client Position Info:"),
              Text("Road: ${dataClient["address"]["road"]}" ),
              Text("Suburb: ${(dataClient["address"]["suburb"]??"")}"),
              const SizedBox(height: 15,),
              const Text("Company Position Info:"),
              Text("Road: ${dataCompany["address"]["road"]}" ),
              Text("Suburb: ${(dataCompany["address"]["suburb"]??"")}"),
              const SizedBox(height: 15,),
              Text("Base value: ${doubleToFormattingToMoneyString(2)} KM" ),
              Text("Value per km: ${doubleToFormattingToMoneyString(0.50)} KM" ),
              Text("Price delivery: ${doubleToFormattingToMoneyString(2 + distance.roundToDouble() * 0.50)}" ),
              /*ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: constStyle.secondaryColor,
                  ),
                  onPressed: (){
                    if (await canLaunch(
                    "http://maps.google.com/maps?daddr=${latLngClient.latitude},${latLngCompany.longitude}")) {
                    launch(
                    "http://maps.google.com/maps?daddr=${order.empresa.latitude},${order.empresa.longitude}",
                    );
                    } else {
                    snackbar.showErrorSnackbar(
                    'Não foi possível abrir esse endereço',
                    );
                    }
                  },
                  child: const Text("Open in Google Maps")
              )*/
            ],
          )
      ),
    );
    isLoading = false;
  }

}