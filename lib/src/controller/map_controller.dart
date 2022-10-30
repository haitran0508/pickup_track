import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geojson/geojson.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pickup_track/src/services.dart/pickup_location_service.dart';

enum MapState {
  awaiting,
  locating,
  failedByService,
  failedByPermission,
  succeeded
}

class MapperController extends GetxController {
  final PickupLocationService pickUpLocationService;

  MapperController({required this.pickUpLocationService});

  final Rx<LatLng> currentPos = LatLng(-37.883761, 145.054682).obs;

  final RxList<LatLng> pickUpPos = <LatLng>[].obs;

  final RxList<Polygon> pickUpPolygons = <Polygon>[].obs;

  final RxList<Polyline> routeLines = <Polyline>[].obs;

  final Rx<MapState> state = MapState.awaiting.obs;

  Future<void> getCurrentPosition() async {
    state.value = MapState.locating;

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      state.value = MapState.failedByService;
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        state.value = MapState.failedByPermission;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      state.value = MapState.failedByPermission;
      return;
    }

    final result = await Geolocator.getCurrentPosition();

    currentPos.value = LatLng(result.latitude, result.longitude);

    state.value = MapState.succeeded;
  }

  Future<void> getPickUpLocation() async {
    final geo = GeoJson();

    final List<LatLng> positions = [];
    final List<Polygon> polygons = [];

    try {
      final locations = await pickUpLocationService.getPickUpLocations();
      if (locations != null) {
        for (var position in locations.list!) {
          positions.add(LatLng(position.latitude!, position.longitude!));

          getDirectionRoute(
              currentPos: currentPos.value,
              pickUpPos: LatLng(position.latitude!, position.longitude!));
        }
        await geo.parse(jsonEncode(locations.list?.first.geoHubTileDistance));
      }

      for (var polygon in geo.polygons) {
        List<LatLng> listLatLng = [];

        for (var geoSeries in polygon.geoSeries) {
          for (var geoPoint in geoSeries.geoPoints) {
            listLatLng.add(geoPoint.toLatLng() as LatLng);
          }
        }

        polygons.add(
          Polygon(
            points: listLatLng,
            borderColor: Colors.red,
            borderStrokeWidth: 4,
          ),
        );
      }
      pickUpPos.value = [...positions];
      pickUpPolygons.value = [...polygons];
    } catch (e) {
      safePrint(e);
    }
  }

  Future<void> getDirectionRoute(
      {required LatLng currentPos, required LatLng pickUpPos}) async {
    List<Polyline> polyLines = [];

    try {
      GeoJson? geo = await pickUpLocationService.getRoute(
          currentPos: currentPos, pickUpPos: pickUpPos);
      if (geo != null) {
        for (var polyLine in geo.lines) {
          List<LatLng> listLatLng = [];
          for (var point in polyLine.geoSerie!.geoPoints) {
            listLatLng.add(point.toLatLng() as LatLng);
          }

          polyLines.add(Polyline(
              points: listLatLng,
              borderStrokeWidth: 3,
              borderColor: Colors.blue));
        }
      }
      routeLines.value = [...polyLines];
    } catch (e) {
      safePrint(e);
    }
  }
}
