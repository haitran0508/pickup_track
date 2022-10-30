import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_track/src/config/amplify.dart';

import 'config/routes.dart';

class PickupTrack extends StatefulWidget {
  const PickupTrack({super.key});

  @override
  State<PickupTrack> createState() => _PickupTrackState();
}

class _PickupTrackState extends State<PickupTrack> {
  @override
  void initState() {
    AmplifyConfigures.configureAmplify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.initial,
      getPages: Routes.routes,
    );
  }
}
