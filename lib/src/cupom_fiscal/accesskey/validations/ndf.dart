class Ndf {
  static String extract(String value) {
    return value.substring(25, 34);
  }

  static bool isValid(String value) {
    RegExp validate = RegExp(r'^[0-9]');

    return validate.hasMatch(extract(value));
  }
}
