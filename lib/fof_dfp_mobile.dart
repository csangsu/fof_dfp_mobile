import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fof_dfp_mobile/widget/drawer/main_drawer.dart';
import 'package:fof_dfp_mobile/screen/main_screen.dart';
import 'package:fof_dfp_mobile/common/constants.dart';
import 'package:fof_dfp_mobile/common/screen/common_screen.dart';

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

  @override
  Widget build(context) {
    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    //   logger.i('background message ${message.notification!.body}');
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      logger.i('Message clicked(onMessageOpenedApp)! $message');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      logger.i("message recieved(onMessage)");
      logger.i(event.notification!.body);
      showDialog(
          context: kContext,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Notification"),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
    return Scaffold(
      key: kScaffoldKey,
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/vheld_logo.svg'),
      ),
      endDrawer: const MainDrawer(),
      body: kScreenMap[screenName],
    );
  }
}
