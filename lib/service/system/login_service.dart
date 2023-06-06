import 'package:fof_dfp_mobile/common/constants.dart';
import 'package:fof_dfp_mobile/common/gex_controller/login_controller.dart';
import 'package:fof_dfp_mobile/common/request/request_handler.dart';
import 'package:fof_dfp_mobile/common/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoginRequestHandler {
  static Future<void> doAutoLogin() async {
    Get.put(LoginController());
    bool isAtoLogin = await AppStatus.getBool(kAppStatusIsAutoLogin);
    String usrid = await AppStatus.getString(kAppStatusUserId);
    String password = await AppStatus.getString(kAppStatusPassword);

    if (isAtoLogin && usrid != '' && password != '') {
      await LoginRequestHandler.login(
          userId: usrid, pwd: password, langType: 'KO');
    }
  }

  static Future<bool> login(
      {required String userId,
      required String pwd,
      required String langType}) async {
    var logger = Logger();
    var loginController = Get.find<LoginController>();
    String urlAddress = '$kBaseUrl/api/v1/login/loginUser';
    Map<String, dynamic> data = {
      'langType': langType,
      'pwd': pwd,
      'usrId': userId
    };
    var res = await DioRequestHandler().post(urlAddress, data);
    if (res.code != 200) {
      return false;
    }
    logger.i(res.data);

    String urlInfo = '$kBaseUrl/api/cspcme001/user-info';
    var resUser = await DioRequestHandler().get(urlInfo, {'inptUsrId': userId});
    logger.i(resUser.data);
    if (resUser.code == 200 && resUser.data['custId'] != '') {
      loginController.setIsLogin(true);
      loginController.setUserId(userId);
      loginController.setPassword(pwd);
      loginController.setUserInfoData(resUser.data);
    } else {
      return false;
    }
    return true;
  }
}
