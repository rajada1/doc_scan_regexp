class Cdf {
  static String extract(String value) {
    return value.substring(35, 43);
  }

  static bool isValid(String value) {
    RegExp numericRegExp = RegExp(r'^\d+$');
    return numericRegExp.hasMatch(value);
  }
}
