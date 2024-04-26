import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:get/get.dart';

class MapViewController extends GetxController {
  MapBoxNavigationViewController? controller;
  String? instruction;
  bool isMultipleStop = false;
  double? distanceRemaining, durationRemaining;
  bool routeBuilt = false;
  bool isNavigating = false;
  bool arrived = false;
  late MapBoxOptions navigationOption;

  Future<void> initialize() async {
    navigationOption = MapBoxNavigation.instance.getDefaultOptions();
    navigationOption.initialLatitude = 37.7749;
    navigationOption.initialLongitude = -122.4194;
    navigationOption.mode = MapBoxNavigationMode.driving;
    navigationOption.language = "en";
    MapBoxNavigation.instance.registerRouteEventListener(onRouteEvent);
    navigationOption.bannerInstructionsEnabled = true;
    navigationOption.voiceInstructionsEnabled = true;
    navigationOption.allowsUTurnAtWayPoints = true;
    navigationOption.simulateRoute = false;
    navigationOption.mapStyleUrlNight =
        "mapbox://styles/mapbox/navigation-guidance-night-v4";
    navigationOption.mapStyleUrlDay =
        "mapbox://styles/mapbox/navigation-guidance-day-v4";
  }

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  Future<void> onRouteEvent(e) async {
    distanceRemaining = await MapBoxNavigation.instance.getDistanceRemaining();
    durationRemaining = await MapBoxNavigation.instance.getDurationRemaining();

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        arrived = progressEvent.arrived!;
        if (progressEvent.currentStepInstruction != null) {
          instruction = progressEvent.currentStepInstruction;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        arrived = true;
        if (!isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await controller?.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        routeBuilt = false;
        isNavigating = false;
        break;
      default:
        break;
    }
    update();
  }
}
