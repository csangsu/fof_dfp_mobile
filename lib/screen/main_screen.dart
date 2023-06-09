import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fof_dfp_mobile/common/audio_palyer.dart';
import 'package:fof_dfp_mobile/common/common_screen.dart';
import 'package:fof_dfp_mobile/providers/location_controller.dart';
import 'package:fof_dfp_mobile/providers/login_controller.dart';
import 'package:fof_dfp_mobile/common/location_manager.dart';
import 'package:fof_dfp_mobile/providers/getx_manager.dart';
import 'package:fof_dfp_mobile/screen/camera_screen.dart';
import 'package:fof_dfp_mobile/widget/common/login_info.dart';
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
  var locationController = GetXManager.getLocationController();

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> doGetLocation() async {
    Position position = await LocationManager.getCurrentLocation();
    locationController.setLatitude(position.longitude);
    locationController.setLatitude(position.latitude);
    locationController.setDateTime(DateTime.now());
    logger.i('${position.latitude}, ${position.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    String txtButon = 'Play Sound';

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GetBuilder<LoginController>(
            init: GetXManager.getLoginController(),
            builder: (controller) {
              return controller.isLogin.value
                  ? LoginInfo(userid: controller.userInfo['custNm'])
                  : const SizedBox.shrink();
            },
          ),
          GetBuilder<LocationController>(
            init: GetXManager.getLocationController(),
            builder: (controller) {
              return controller.latitude.value > 0.0
                  ? Column(
                      children: [
                        Text(
                          'position = ${controller.latitude.value},${controller.latitude.value}',
                          style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'date = ${controller.dateString}',
                          style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : const SizedBox.shrink();
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
                  AssertsPalyer.playAssert(
                      audioFileName: 'assets/audio/beep.mp3');
                  ScreenHandler.openScreen(context, CameraScreen.screenName);
                },
                child: Text(
                  txtButon,
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
