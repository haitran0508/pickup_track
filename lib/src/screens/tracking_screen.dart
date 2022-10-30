import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:pickup_track/src/config/map_api.dart';
import 'package:pickup_track/src/constants/string_constants.dart';

import '../controller/authentication_controller.dart';
import '../controller/map_controller.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MapperController>();
    final authController = Get.find<AuthenticationController>();

    controller.getPickUpLocation();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
        title: Text(StringConstants.appName),
      ),
      body: Center(
        child: Obx(
          () {
            final currentPosState = controller.state.value;
            if (currentPosState == MapState.awaiting) {
              controller.getCurrentPosition();
            }
            if (currentPosState == MapState.failedByService) {
              return const Text(
                  'Please enable location services on your devices');
            }
            if (currentPosState == MapState.failedByPermission) {
              return const Text(
                  'Please allow your device to track your position');
            }
            if (currentPosState == MapState.succeeded) {
              return FlutterMap(
                key: GlobalKey(),
                options: MapOptions(
                  zoom: 12,
                  center: controller.currentPos.value,
                ),
                children: [
                  TileLayer(
                    urlTemplate: MapApiConfig.urlTemplate,
                    additionalOptions: const {
                      MapApiConfig.accessTokenKey: MapApiConfig.accessToken,
                    },
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: controller.currentPos.value,
                        builder: (context) => const Icon(
                          Icons.my_location,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  if (controller.pickUpPolygons.isNotEmpty)
                    PolygonLayer(polygons: controller.pickUpPolygons),
                  if (controller.routeLines.isNotEmpty)
                    PolylineLayer(polylines: controller.routeLines)
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
