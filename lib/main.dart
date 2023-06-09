import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:camera/camera.dart';

import 'package:fof_dfp_mobile/common/background_service.dart';
import 'package:fof_dfp_mobile/common/constants.dart';
import 'package:fof_dfp_mobile/common/location_manager.dart';
import 'package:fof_dfp_mobile/fof_dfp_mobile.dart';
import 'package:fof_dfp_mobile/providers/getx_manager.dart';
import 'package:fof_dfp_mobile/service/system/login_service.dart';
import 'package:fof_dfp_mobile/common/environment.dart';

AudioPlayer? player;
late List<CameraDescription> cameras;

void main() async {
  await dotenv.load(fileName: Environment.envFileName);

  WidgetsFlutterBinding.ensureInitialized();
  await LocationManager.getCurrentLocation();
  await BackgroundService.initializeService();
  await LoginRequestHandler.doAutoLogin();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  cameras = await availableCameras();
  GetXManager.getLocationController();
  GetXManager.getLoginController();
  initBackgroundService();

  player = AudioPlayer();

  runApp(const AppMain());
}

void initBackgroundService() {
  final backgroundService = FlutterBackgroundService();
  var logger = Logger();
  backgroundService.on('update').listen((event) {
    if (event == null) return;
    final locationController = GetXManager.getLocationController();
    double longitude = event['longitude'];
    double latitude = event['latitude'];
    DateTime? date = DateTime.tryParse(event['current_date']);
    locationController.setLatitude(latitude);
    locationController.setLongitude(longitude);
    locationController.setDateTime(date!);
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
