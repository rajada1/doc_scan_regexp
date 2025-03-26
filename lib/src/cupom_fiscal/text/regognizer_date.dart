import 'package:doc_scan_regexp/doc_scan_regexp.dart';

class RecognizerDate {
  static String? value(String text, AccessKeyDate? accessKeyDate) {
    if (accessKeyDate != null) {
      final result = findDateWithAccessKeyDate(text, accessKeyDate);
      if (result != '') {
        return result.formatOutDate;
      }
      return makeFindDate(text).formatOutDate;
    } else {
      return makeFindDate(text).formatOutDate;
    }
  }

  static String? makeFindDate(String text) {
    final lowerText = text.toLowerCase();
    for (var element in keyWordsValue) {
      if (lowerText.toLowerCase().contains(element)) {
        final result = findDateNextFromSplit(lowerText, element);
        if (result != '') {
          return result;
        }
      }
    }
    final result = findDateAllText(lowerText);

    if (result != '') {
      return result;
    }
    return null;
  }

  static String findDateNextFromSplit(String text, String splitText) {
    try {
      String nText = text.toLowerCase().split(splitText).last;
      Iterable<Match> valores = fullDateRegExp.allMatches(nText);
      return valores.first.group(0) ?? '';
    } catch (e) {
      print(e);
    }
    return ('');
  }

  static String findDateAllText(
    String text,
  ) {
    try {
      Iterable<Match> valores = fullDateRegExp.allMatches(text);
      return valores.first.group(0) ?? '';
    } catch (e) {
      print(e);
    }
    return ('');
  }

  static String findDateWithAccessKeyDate(
      String text, AccessKeyDate accessKeyDate) {
    final nText = text.toLowerCase().substring(5);
    final dateWithMonthAndYear = RegExp(
        '(\\d{1,2}[\\/-]${accessKeyDate.month}[\\/-](?:20${accessKeyDate.year}|${accessKeyDate.year}))');
    try {
      Iterable<Match> valores = dateWithMonthAndYear.allMatches(nText);
      return valores.first.group(0) ?? '';
    } catch (e) {
      null;
    }
    return ('');
  }

  static RegExp fullDateRegExp = RegExp(r'\b\d{2}[/\-]\d{2}[/\-]\d{2,4}\b');
  RegExp dataComMesAnoRegExp =
      RegExp(r'\b\?\?[-/]\d{2}[-/]\d{4}\b|\b\?\?[-/]\d{2}[-/]\d{2}\b');

  static const List<String> keyWordsValue = [
    'data e hora de emissão',
    'data e hora',
    'data emissao',
    'data',
    'dala'
  ];
}

extension ResultDate on String? {
  String? get formatOutDate {
    String? newsFormat = this?.replaceAll('-', '/');
    final splitDate = newsFormat?.split('/');
    splitDate?.last.length == 2
        ? newsFormat =
            '${splitDate?.first}/${splitDate?[1]}/20${splitDate?.last}'
        : null;
    return newsFormat;
  }
}
