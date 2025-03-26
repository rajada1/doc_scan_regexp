import 'package:doc_scan_regexp/src/helpers/extensions.dart';

class Cdv {
  ///Extract and return the cdv(código verificador) number in the accesskey string
  ///
  ///validate: default is true
  static value(String value, [final bool validate = true]) {
    return validate
        ? isValid(value)
            ? extract(value)
            : throw FormatException('Cdv invalid')
        : extract(value);
  }

  ///Extract the verification number in the access key string
  static String extract(String value) {
    return value[value.length - 1];
  }

  ///Check if the cdv(código verificador) number is valid
  static bool isValid(String valueMain) {
    String value = valueMain.substring(0, valueMain.length - 1);
    int sum = 2;

    int sumResult = value.split('').reversed.map((element) {
      int result = element.toInt * sum;
      sum = (sum == 9) ? 2 : sum + 1;
      return result;
    }).reduce((value, element) => value + element);

    int calculatedCdv = sumResult % 11;
    int result =
        (calculatedCdv == 0 || calculatedCdv == 1) ? 0 : 11 - calculatedCdv;

    int last = int.parse(extract(valueMain));
    return result == last;
  }
}
