import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:geolocation_system/app/modules/core/core_store.dart';
import 'package:geolocation_system/app/modules/freight_calculation/freight_calculation_module.dart';
import 'package:geolocation_system/app/modules/reverse_geocoding/reverse_geocoding_module.dart';
import 'package:geolocation_system/app/shared/utils/style/style.dart';

class CorePage extends StatefulWidget {
  final String title;
  const CorePage({Key? key, this.title = 'CorePage'}) : super(key: key);
  @override
  CorePageState createState() => CorePageState();
}
class CorePageState extends State<CorePage> {
  final CoreStore store = Modular.get();
  final ConstStyle constStyle = ConstStyle();
  final PageController pageController = PageController();
  @override
  void initState() {
    store.setColor();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constStyle.primaryColor,
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: constStyle.transparent,
        color: constStyle.secondaryColor,
        items: const <Widget>[
          Icon(Icons.map, size: 30,color: Colors.white,),
          Icon(Icons.motorcycle, size: 30,color: Colors.white,),
        ],
        onTap: (index) {
          pageController.animateToPage(
              index,
              duration: const Duration(microseconds: 100),
              curve: Curves.bounceIn);
        },
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ReverseGeocodingModule(),
          FreightCalculationModule()
        ],
      ),
    );
  }
}