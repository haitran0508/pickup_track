class PickupLocationList {
  List<PickupLocation>? list;
  PickupLocationList({
    this.list,
  });

  factory PickupLocationList.fromJson(List<dynamic> parsedJson) {
    List<PickupLocation> list =
        parsedJson.map((e) => PickupLocation.fromJson(e)).toList();
    return PickupLocationList(list: list);
  }
}

class PickupLocation {
  int? rangeKm;
  double? latitude;
  double? longitude;
  Map<String, dynamic>? geoHubTileDistance;
  int? countOrders;
  int? countNotAssignedOrders;
  int? countCouriers;
  int? countCourierShoppers;
  int? countShoppers;
  PriorityScore? priorityScore;

  PickupLocation(
      {this.rangeKm,
      this.latitude,
      this.longitude,
      this.geoHubTileDistance,
      this.countOrders,
      this.countNotAssignedOrders,
      this.countCouriers,
      this.countCourierShoppers,
      this.countShoppers,
      this.priorityScore});

  PickupLocation.fromJson(Map<String, dynamic> json) {
    rangeKm = json['RangeKm'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    geoHubTileDistance = json['GeoHubTileDistance'];
    countOrders = json['CountOrders'];
    countNotAssignedOrders = json['CountNotAssignedOrders'];
    countCouriers = json['CountCouriers'];
    countCourierShoppers = json['CountCourierShoppers'];
    countShoppers = json['CountShoppers'];
    priorityScore = json['PriortyScore'] != null
        ? PriorityScore.fromJson(json['PriortyScore'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RangeKm'] = rangeKm;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    if (geoHubTileDistance != null) {
      data['GeoHubTileDistance'] = geoHubTileDistance;
    }
    data['CountOrders'] = countOrders;
    data['CountNotAssignedOrders'] = countNotAssignedOrders;
    data['CountCouriers'] = countCouriers;
    data['CountCourierShoppers'] = countCourierShoppers;
    data['CountShoppers'] = countShoppers;
    if (priorityScore != null) {
      data['PriortyScore'] = priorityScore!.toJson();
    }
    return data;
  }
}

class PriorityScore {
  int? avgCourierScore;
  int? avgShopperScore;

  PriorityScore({this.avgCourierScore, this.avgShopperScore});

  PriorityScore.fromJson(Map<String, dynamic> json) {
    avgCourierScore = json['AvgCourierScore'];
    avgShopperScore = json['AvgShopperScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AvgCourierScore'] = avgCourierScore;
    data['AvgShopperScore'] = avgShopperScore;
    return data;
  }
}
