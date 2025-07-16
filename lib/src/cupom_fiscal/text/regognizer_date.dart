import 'package:doc_scan_regexp/doc_scan_regexp.dart';

class RecognizerDate {
  static String? value(String text, AccessKeyDate? accessKeyDate) {
    if (accessKeyDate != null) {
      final result = findDateWithAccessKeyDate(text, accessKeyDate);
      if (result != '') {
        return result.formatOutDate(accessKeyDate);
      }
      return makeFindDate(text).formatOutDate(accessKeyDate);
    } else {
      return makeFindDate(text).formatOutDate(accessKeyDate);
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
      print(splitText);
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
    final dateWithMonthAndYear = RegExp(r'(\d{2}[\/-]' +
        accessKeyDate.month.padLeft(2, '0') +
        r'[\/-](?:20' +
        accessKeyDate.year +
        r'|' +
        accessKeyDate.year +
        r'))');
    try {
      Iterable<Match> valores = dateWithMonthAndYear.allMatches(nText);
      // for (var element in valores) {
      //   print(element.group(0));
      // }
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
    'data de emissao',
    'data de emissão',
    'data',
    'dala'
  ];
}

extension ResultDate on String? {
  String? formatOutDate(AccessKeyDate? accessKeyDate) {
    print('DATE IN FORMAT ${accessKeyDate.toString()}');
    String? newsFormat = this?.replaceAll('-', '/');
    final splitDate = newsFormat?.split('/');
    splitDate?.last.length == 2
        ? newsFormat =
            '${splitDate?.first}/${(accessKeyDate?.month ?? splitDate?[1])}/20${(accessKeyDate?.year ?? splitDate?.last)}'
        : null;
    return newsFormat;
  }
}
