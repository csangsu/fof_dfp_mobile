class Utils {
  static String defaultString(String? str) {
    return str ?? '';
  }

  static bool isEqualsString(String? str1, String? str2) {
    return defaultString(str1) == defaultString(str2);
  }
}
