import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class Utils {
  static String defaultString(String? str) {
    return str ?? '';
  }

  static bool isEqualsString(String? str1, String? str2) {
    return defaultString(str1) == defaultString(str2);
  }

  static Future<String> moveCameraImageToDocRoot(XFile file) async {
    final image = File(file.path);
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');
    return copiedImage.path;
  }
}
