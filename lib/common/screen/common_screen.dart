import 'package:flutter/material.dart';

import 'package:fof_dfp_mobile/common/constants.dart';
import 'package:fof_dfp_mobile/screen/login/login_screen.dart';
import 'package:fof_dfp_mobile/screen/main_screen.dart';

Map<String, dynamic> kScreenMap = {
  LoginScreen.screenName: const LoginScreen(),
  MainScreen.screenName: const MainScreen(),
};

class ScreenHandler {
  static void openScreen(String screenName) {
    var screen = kScreenMap[screenName];
    BuildContext context = kContext;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static void closeScreen() {
    Navigator.of(kContext).pop();
  }
}
