import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:fof_dfp_mobile/common/constants.dart';
import 'package:fof_dfp_mobile/fof_dfp_mobile.dart';
import 'package:fof_dfp_mobile/service/system/login_service.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:fof_dfp_mobile/common/environment.dart';

void main() async {
  await dotenv.load(fileName: Environment.envFileName);

  WidgetsFlutterBinding.ensureInitialized();
  await LoginRequestHandler.doAutoLogin();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const AppMain());
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
