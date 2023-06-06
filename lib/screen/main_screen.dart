import 'package:flutter/material.dart';
import 'package:fof_dfp_mobile/common/common_screen.dart';
import 'package:fof_dfp_mobile/common/gex_controller/login_controller.dart';
import 'package:fof_dfp_mobile/screen/login/login_screen.dart';
import 'package:fof_dfp_mobile/widget/common/login_info.dart';
import 'package:fof_dfp_mobile/widget/common/not_found.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  static String screenName = "MainScreen";
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                onPressed: () {
                  ScreenHandler.openScreen(context, LoginScreen.screenName);
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
