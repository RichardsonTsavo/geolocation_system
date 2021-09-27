import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocation_system/app/modules/core/core_page.dart';
import 'package:geolocation_system/app/modules/core/core_store.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CoreStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const CorePage()),
  ];
}
