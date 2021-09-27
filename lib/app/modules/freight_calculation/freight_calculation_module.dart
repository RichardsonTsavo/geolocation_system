import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocation_system/app/modules/freight_calculation/freight_calculation_page.dart';
import 'package:geolocation_system/app/modules/freight_calculation/freight_calculation_store.dart';

class FreightCalculationModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => FreightCalculationStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const FreightCalculationPage()),
  ];

  @override
  // TODO: implement view
  Widget get view => const FreightCalculationPage();
}
