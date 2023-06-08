import 'package:intl/intl.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  RxDouble longitude = 0.0.obs;
  RxDouble latitude = 0.0.obs;
  RxString dateString = ''.obs;
  RxBool isLocation = false.obs;

  void setIsLocation(bool value) {
    isLocation = value.obs;
    update();
  }

  void setLongitude(double value) {
    longitude = value.obs;
    update();
  }

  void setLatitude(double value) {
    latitude = value.obs;
    update();
  }

  void setDateTime(DateTime value) {
    dateString = DateFormat('yyyy-MM-dd HH:mm:ss').format(value).obs;
    update(); // 상태 변경을 알리기 위해 update() 메서드를 호출합니다.
  }
}
