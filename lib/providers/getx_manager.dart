import 'package:get/get.dart';

import 'package:fof_dfp_mobile/providers/login_controller.dart';
import 'package:fof_dfp_mobile/providers/location_controller.dart';

class GetXManager {
  static LoginController getLoginController() {
    if (Get.isRegistered<LoginController>()) {
      return Get.find<LoginController>();
    }
    return Get.put(LoginController());
  }

  static LocationController getLocationController() {
    if (Get.isRegistered<LocationController>()) {
      return Get.find<LocationController>();
    }
    return Get.put(LocationController());
  }
}
