import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fof_dfp_mobile/common/common_screen.dart';
import 'package:fof_dfp_mobile/common/gex_controller/login_controller.dart';
import 'package:fof_dfp_mobile/common/location_manager.dart';
import 'package:fof_dfp_mobile/screen/login/login_screen.dart';
import 'package:fof_dfp_mobile/widget/common/login_info.dart';
import 'package:fof_dfp_mobile/widget/common/not_found.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

class MainScreen extends StatefulWidget {
  static String screenName = "MainScreen";
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var logger = Logger();
  Future<void> doGetLocation() async {
    Position position = await LocationManager.getCurrentLocation();
    logger.i('${position.latitude}, ${position.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GetBuilder<LoginController>(
            builder: (controller) {
              return controller.isLogin.value
                  ? LoginInfo(userid: controller.userInfo['custNm'])
                  : const NotFound();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 22),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 26, 183, 183),
                ),
                color: const Color.fromARGB(255, 26, 183, 183),
              ),
              child: TextButton(
                onPressed: () async {
                  await doGetLocation();
                  // ScreenHandler.openScreen(context, LoginScreen.screenName);
                },
                child: Text(
                  'Start Location',
                  style: GoogleFonts.notoSans(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
