import 'package:get/get.dart';

class LoginController extends GetxController {
  RxString userId = ''.obs;
  RxString password = ''.obs;
  RxBool isLogin = false.obs;
  late RxMap<String, dynamic> userInfo;

  void setIsLogin(bool value) {
    isLogin = value.obs;
    update();
  }

  void setUserId(String key) {
    userId = key.obs;
    update(); // 상태 변경을 알리기 위해 update() 메서드를 호출합니다.
  }

  void setPassword(String key) {
    password = key.obs;
    update(); // 상태 변경을 알리기 위해 update() 메서드를 호출합니다.
  }

  void setUserInfoData(Map<String, dynamic> map) {
    userInfo = map.obs;
    update(); // 상태 변경을 알리기 위해 update() 메서드를 호출합니다.
  }
}
