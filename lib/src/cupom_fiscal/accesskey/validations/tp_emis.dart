class TpEmis {
  static String extract(String value) {
    return value.substring(34, 35);
  }

  static bool isValid(String value) {
    RegExp seriesRegExp = RegExp(r'^[0-9]');
    return seriesRegExp.hasMatch(extract(value));
  }
}
