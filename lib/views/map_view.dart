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
          appBar: AppBar(
            title: const Text('Map View'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () =>
                  Get.back(), // Navigate back when the back button is pressed
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
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
          ),
        );
      },
    );
  }
}
