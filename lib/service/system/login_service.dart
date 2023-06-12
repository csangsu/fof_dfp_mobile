import 'package:logger/logger.dart';

import 'package:fof_dfp_mobile/common/constants.dart';
import 'package:fof_dfp_mobile/common/request/request_handler.dart';
import 'package:fof_dfp_mobile/common/shared_preferences.dart';
import 'package:fof_dfp_mobile/providers/getx_manager.dart';

class LoginRequestHandler {
  static Future<void> doAutoLogin() async {
    bool isAtoLogin = await AppStatus.getBool(kAppStatusIsAutoLogin);
    String usrid = await AppStatus.getString(kAppStatusUserId);
    String password = await AppStatus.getString(kAppStatusPassword);

    if (isAtoLogin && usrid != '' && password != '') {
      await LoginRequestHandler.login(
          userId: usrid, pwd: password, langType: 'KO');
    }
  }

  static Future<void> logOut() async {
    var loginController = GetXManager.getLoginController();
    loginController.setIsLogin(false);
    loginController.setUserId('');
    loginController.setPassword('');
    loginController.setUserInfoData({});
  }

  static Future<bool> login(
      {required String userId,
      required String pwd,
      required String langType}) async {
    var logger = Logger();
    var loginController = GetXManager.getLoginController();
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
