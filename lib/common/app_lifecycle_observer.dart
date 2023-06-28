import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.detached) {
      // 앱이 백그라운드로 이동할 때 수행할 작업
    } else if (state == AppLifecycleState.resumed) {
      // 앱이 포그라운드로 돌아올 때 수행할 작업
    } else if (state == AppLifecycleState.detached) {}
  }
}
