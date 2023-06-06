import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get envFileName =>
      kReleaseMode ? ".env.production" : ".env.development";
  static String get apiUrl => dotenv.env['API_URL'] ?? 'http://10.5.37.15:9010';
}
