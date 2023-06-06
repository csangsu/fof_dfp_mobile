import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fof_dfp_mobile/common/common_screen.dart';

import 'package:fof_dfp_mobile/widget/drawer/main_drawer.dart';
import 'package:fof_dfp_mobile/screen/main_screen.dart';
import 'package:fof_dfp_mobile/common/constants.dart';
import 'package:logger/logger.dart';

class FofDfpMobile extends StatefulWidget {
  const FofDfpMobile({super.key});

  @override
  State<FofDfpMobile> createState() {
    return _FofDfpMobileState();
  }
}

class _FofDfpMobileState extends State<FofDfpMobile> {
  String screenName = MainScreen.screenName;
  final logger = Logger();

  void onChangeScreen(String scnName, bool isNScreen) {
    if (isNScreen == true) {
      ScreenHandler.openScreen(context, scnName);
    } else {
      setState(() {
        screenName = scnName;
      });
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      key: kScaffoldKey,
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/vheld_logo.svg'),
      ),
      endDrawer: MainDrawer(
        onChangeScreen: (scnName, isNScreen) =>
            onChangeScreen(scnName, isNScreen),
      ),
      body: kScreenMap[screenName],
    );
  }
}
