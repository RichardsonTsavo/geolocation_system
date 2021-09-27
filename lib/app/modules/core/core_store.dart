import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:geolocation_system/app/shared/utils/style/style.dart';
import 'package:mobx/mobx.dart';

part 'core_store.g.dart';

class CoreStore = _CoreStoreBase with _$CoreStore;
abstract class _CoreStoreBase with Store {
  Future setColor() async {
    final ConstStyle constStyle = ConstStyle();
    await FlutterStatusbarcolor.setStatusBarColor(constStyle.transparent, animate: true);
    if (useWhiteForeground(constStyle.transparent)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    }
  }
}