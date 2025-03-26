class Aamm {
  ///Return [AccessKeyDate] content the year(aa) and month(mm) in the accesskey string.
  ///
  ///validade default is true
  static AccessKeyDate value(String value, [bool validate = true]) {
    return validate
        ? isValid(value)
            ? extract(value)
            : throw FormatException('Date not valid')
        : extract(value);
  }

  /// Extract the year(aa) and month(mm) in the access key string and return [AccessKeyDate]
  static AccessKeyDate extract(String value) {
    return AccessKeyDate(
        year: value.substring(2, 4), month: value.substring(4, 6));
  }

  /// Check if the date in the accesskey is valid
  static bool isValid(String value) {
    final regExp = RegExp(r'\b(?:0[0-9]|[12][0-9]|3[0-1])(?:0[0-9]|1[0-2])\b');
    final aamm = extract(value);
    return regExp.hasMatch('${aamm.year}${aamm.month}');
  }
}

class AccessKeyDate {
  final String month;
  final String year;

  AccessKeyDate({required this.month, required this.year});

  @override
  String toString() => '$month/$year';
}
