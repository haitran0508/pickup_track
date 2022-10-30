class MapApiConfig {
  static const host = 'api.mapbox.com';

  static const routeGeneratePath = '/directions/v5/mapbox/driving';

  static const urlTemplate =
      'https://api.mapbox.com/styles/v1/haitran0508/$mapStyleId/tiles/256/{z}/{x}/{y}@2x?access_token=$accessToken';

  static const accessTokenKey = 'accessToken';
  static const accessToken =
      'pk.eyJ1IjoiaGFpdHJhbjA1MDgiLCJhIjoiY2w5dXh4bG83MHBlZDNwczl3aTNwN3p3dCJ9.RorQKztxPXM5Oasv39wxuw';

  static const mapStyleIdKey = 'mapStyleId';
  static const mapStyleId = 'cl9uwvzwb00d915mgtsoixnki';
}
