import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:fof_dfp_mobile/common/background_service.dart';
import 'package:fof_dfp_mobile/common/constants.dart';
import 'package:fof_dfp_mobile/common/location_manager.dart';
import 'package:fof_dfp_mobile/fof_dfp_mobile.dart';
import 'package:fof_dfp_mobile/providers/getx_manager.dart';
import 'package:fof_dfp_mobile/service/system/login_service.dart';
import 'package:fof_dfp_mobile/common/environment.dart';
import 'package:fof_dfp_mobile/firebase_options.dart';

AudioPlayer? player;

void main() async {
  await dotenv.load(fileName: Environment.envFileName);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initFirebaseMessage();
  await initLocationControllerAndGetCurrentLocation();
  await BackgroundService.initializeService();
  await LoginRequestHandler.doAutoLogin();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  initBackgroundService();

  player = AudioPlayer();

  runApp(const AppMain());
}

Future<void> initLocationControllerAndGetCurrentLocation() async {
  var logger = Logger();
  Position pos = await LocationManager.getCurrentLocation();
  logger.i('Current Location is : ${pos.latitude}, ${pos.longitude}');
  final loc = GetXManager.getLocationController();
  loc.setLatitude(pos.latitude);
  loc.setLongitude(pos.longitude);
  loc.setDateTime(DateTime.now());
}

Future<void> initFirebaseMessage() async {
  var logger = Logger();
  final fcm = FirebaseMessaging.instance;

  await fcm.requestPermission();

  await fcm.subscribeToTopic('fof_dfp_mobile');
  if (kDebugMode) {
    String? token = await fcm.getToken();
    if (token != null) {
      logger.i("Push Token is [$token]");
    }
  }
  fcm.onTokenRefresh.listen((String newToken) {
    logger.i('FCM 토큰 업데이트: $newToken');
  });
}

void initBackgroundService() {
  final backgroundService = FlutterBackgroundService();
  var logger = Logger();
  backgroundService.on('update').listen((event) async {
    if (event == null) return;
    Position pos = await LocationManager.getCurrentLocation();

    final locationController = GetXManager.getLocationController();
    locationController.setLatitude(pos.latitude);
    locationController.setLongitude(pos.longitude);
    locationController.setDateTime(DateTime.now());
  }, onError: (e, s) {
    logger.i('error listening for updates: $e, $s');
  }, onDone: () {
    logger.i('background listen closed');
  });
}

class AppMain extends StatelessWidget {
  const AppMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: GetMaterialApp(
        theme: kAppTheme,
        home: const FofDfpMobile(),
      ),
    );
  }
}
