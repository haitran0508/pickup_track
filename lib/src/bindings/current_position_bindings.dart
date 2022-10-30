import 'package:get/get.dart';
import 'package:pickup_track/src/controller/map_controller.dart';
import 'package:pickup_track/src/services.dart/pickup_location_service.dart';

import '../controller/authentication_controller.dart';
import '../services.dart/authentication_service.dart';

class CurrentPositionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => const AuthenticationService());
    Get.lazyPut(() => AuthenticationController(service: Get.find()));
    Get.lazyPut(() => PickupLocationService());
    Get.lazyPut(() => MapperController(pickUpLocationService: Get.find()));
  }
}
