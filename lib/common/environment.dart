import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get envFileName =>
      kReleaseMode ? ".env.production" : ".env.development";
  static String get apiUrl => dotenv.env['API_URL'] ?? 'http://10.5.37.15:9010';

  static bool get autoStart => dotenv.env['BACKGROUND_AUTO_START'] as bool;
  static bool get isForegroundMode =>
      dotenv.env['BACKGROUND_IS_FOREGROUND_MODE'] as bool;
  static String get notificationChannelId =>
      dotenv.env['BACKGROUND_NOTIFICATION_CHANNELID'] ?? 'my_foreground';
  static String get initialNotificationTitle =>
      dotenv.env['BACKGROUND_INITIAL_NOTIFICATIO_NTITLE'] ?? 'vheld';
  static String get initialNotificationContent =>
      dotenv.env['BACKGROUND_INITIAL_NOTIFICATION_CONTENT'] ?? 'Initializing';
  static int get dServiceNotificationId =>
      dotenv.env['BACKGROUND_INITIAL_NOTIFICATION_CONTENT'] as int;
}
