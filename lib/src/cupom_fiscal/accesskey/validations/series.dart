class Series {
  static String extract(String value) {
    return value.substring(22, 25);
  }

  static bool isValid(String value) {
    RegExp seriesRegExp = RegExp(r'^[0-9]');

    return seriesRegExp.hasMatch(extract(value));
  }
}
