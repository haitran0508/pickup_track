import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/services.dart';
import 'package:geojson/geojson.dart';
import 'package:latlong2/latlong.dart';

import '../config/map_api.dart';
import '../models/pickup_location_list.dart';

class PickupLocationService {
  PickupLocationService();

  Future<PickupLocationList?> getPickUpLocations() async {
    final geo = GeoJson();

    try {
      final data = await rootBundle.loadString('assets/data.json');

      var pickupLocations = PickupLocationList.fromJson(json.decode(data));

      await geo
          .parse(jsonEncode(pickupLocations.list?.first.geoHubTileDistance));
      return pickupLocations;
    } catch (e) {
      safePrint(e);
      return null;
    }
  }

  Future<GeoJson?> getRoute(
      {required LatLng currentPos, required LatLng pickUpPos}) async {
    final geo = GeoJson();
    try {
      final uri = Uri(
        scheme: 'https',
        host: MapApiConfig.host,
        path:
            '${MapApiConfig.routeGeneratePath}/${currentPos.longitude},${currentPos.latitude};${pickUpPos.longitude},${pickUpPos.latitude}',
        queryParameters: {
          'alternatives': 'false',
          'geometries': 'geojson',
          'overview': 'simplified',
          'steps': 'false',
          'access_token': MapApiConfig.accessToken,
        },
      );

      var response = await http.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        var dataToParsed = result['routes'][0];

        Map<String, dynamic> dataInput = {};

        dataInput['features'] = [dataToParsed];

        await geo.parse(json.encode(dataInput));

        return geo;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
