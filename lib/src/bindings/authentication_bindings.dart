import 'package:get/get.dart';
import 'package:pickup_track/src/services.dart/authentication_service.dart';

import '../controller/authentication_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => const AuthenticationService());
    Get.lazyPut(() => AuthenticationController(service: Get.find()));
  }
}
