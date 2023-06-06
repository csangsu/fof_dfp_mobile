import 'package:flutter/material.dart';

import 'package:fof_dfp_mobile/common/constants.dart';

class ScreenHandler {
  static void openScreen(BuildContext context, String screenName) {
    var screen = kScreenMap[screenName];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static void closeScreen(BuildContext context) {
    Navigator.of(context).pop();
  }
}
