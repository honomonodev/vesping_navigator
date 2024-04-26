import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:get/get.dart';

import '../controllers/map_view_controller.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapViewController>(
      init: MapViewController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                child: Container(
                  color: Colors.grey[100],
                  child: MapBoxNavigationView(
                    options: controller.navigationOption,
                    onRouteEvent: controller.onRouteEvent,
                    onCreated: (MapBoxNavigationViewController c) async {
                      controller.controller = c;
                      c.initialize();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
