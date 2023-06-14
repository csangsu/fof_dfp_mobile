import 'package:flutter/material.dart';

import 'package:fof_dfp_mobile/common/constants.dart';

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
