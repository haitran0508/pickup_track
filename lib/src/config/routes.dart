import 'package:get/get.dart';

import '../bindings/authentication_bindings.dart';
import '../bindings/current_position_bindings.dart';
import '../screens/auth_screen.dart';
import '../screens/tracking_screen.dart';

class Routes {
  static const auth = '/login';
  static const tracking = '/tracking';

  static const initial = auth;

  static final routes = [
    GetPage(
      name: auth,
      page: () => const AuthenticationScreen(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: tracking,
      page: () => const TrackingScreen(),
      binding: CurrentPositionBinding(),
    ),
  ];
}
