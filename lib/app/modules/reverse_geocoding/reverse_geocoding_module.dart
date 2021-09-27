import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocation_system/app/modules/reverse_geocoding/reverse_geocoding_page.dart';
import 'package:geolocation_system/app/modules/reverse_geocoding/reverse_geocoding_store.dart';

class ReverseGeocodingModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ReverseGeocodingStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ReverseGeocodingPage()),
  ];

  @override
  // TODO: implement view
  Widget get view => const ReverseGeocodingPage();
}
