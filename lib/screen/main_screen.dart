import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fof_dfp_mobile/widget/image_input.dart';
import 'package:fof_dfp_mobile/widget/barcode_reader.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

import 'package:fof_dfp_mobile/common/audio/audio_palyer.dart';
import 'package:fof_dfp_mobile/providers/getx_manager.dart';
import 'package:fof_dfp_mobile/widget/common/login_info.dart';

class MainScreen extends StatefulWidget {
  static String screenName = "MainScreen";
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var logger = Logger();
  var cnt = 0.obs;

  @override
  void dispose() {
    super.dispose();
  }

  void onPickImage(File image) {}

  @override
  Widget build(BuildContext context) {
    String txtButon = 'Play Sound';

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageInput(
            onPickImage: onPickImage,
          ),
          GetBuilder(
            init: GetXManager.getLoginController(),
            builder: (controller) {
              return controller.isLogin.value
                  ? LoginInfo(userid: controller.userInfo['custNm'])
                  : Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Not Login',
                          style: GoogleFonts.notoSans(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    );
            },
          ),
          GetBuilder(
            init: GetXManager.getLocationController(),
            builder: (controller) {
              return Column(
                children: [
                  Text(
                    'position = ${controller.latitude.value},${controller.longitude.value}',
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
              );
            },
          ),
          const BarcodeReader(),
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 22),
            child: Obx(
              () => Container(
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
                    Get.snackbar('Play Sound!', 'Play beep sound!');
                    AssertsPalyer.playAssert(
                        audioFileName: 'assets/audio/beep.mp3');
                    cnt++;
                  },
                  child: Text(
                    '$txtButon, $cnt',
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
          ),
        ],
      ),
    );
  }
}
