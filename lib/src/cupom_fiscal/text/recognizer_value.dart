import 'package:doc_scan_regexp/src/helpers/extensions.dart';

class RecognizerValue {
  static String? value(String text) {
    return makeFindValue(text);
  }

  static String? makeFindValue(String text) {
    for (var element in keyWordsValue) {
      if (text.toLowerCase().contains(element)) {
        final result = findValueNextValueStringFromSplit(text, element);

        if (result != '') {
          return result;
        }
      }
    }
    return null;
  }

  static String findValueNextValueStringFromSplit(
      String text, String splitText) {
    try {
      // print(splitText);
      String nText = text.toLowerCase().split(splitText).last;
      Iterable<Match> valores = valorRegExp.allMatches(nText);
      valores.first.group(0) ?? '';
      getDiscounts(text);
      return '${getMaxValue(valores, text)}';
    } catch (e) {
      null;
    }
    return ('');
  }

  static double? getMaxValue(Iterable<Match> text, String textFull) {
    final values = text
        .map((e) => parseCurrency('${e.group(0)}'))
        .where((e) => e != null)
        .cast<double>();
    // Retorna o maior valor ou null se a lista estiver vazia
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final newsWithCheckDiscount = checkDiscountValue(values, textFull);
    if (newsWithCheckDiscount != null) {
      return newsWithCheckDiscount;
    }
    return values.isNotEmpty ? maxValue : null;
  }

  static double? checkDiscountValue(Iterable<double> values, String textFull) {
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final discount = getDiscounts(textFull);
    if (discount != null) {
      double nTotalWithDicount = maxValue - (getDiscounts(textFull) ?? 0);
      nTotalWithDicount =
          double.tryParse(nTotalWithDicount.toStringAsFixed(2)) ?? 0;
      final contains = values.contains(nTotalWithDicount);
      if (contains) {
        return nTotalWithDicount;
      }
    }
    return null;
  }

  static double? getMaxValueDiscount(Iterable<Match> text) {
    final values = text
        .map((e) => parseCurrency('${e.group(0)?.replaceAll('-', '')}'))
        .where((e) => e != null)
        .cast<double>();

    // Retorna o maior valor ou null se a lista estiver vazia
    return values.isNotEmpty ? values.reduce((a, b) => a > b ? a : b) : null;
  }

  static double? parseCurrency(String value) {
    try {
      // Remove os separadores de milhares (pontos) e substitui a vírgula pelo ponto decimal

      String normalizedValue = '';
      if (value.contains(',') && value.contains('.')) {
        normalizedValue =
            value.replaceAll('.', '').replaceAll(',', '.').removeWhiteSpace;
      } else {
        normalizedValue = value.replaceAll(',', '.').removeWhiteSpace;
      }
      return double.tryParse(normalizedValue);
    } catch (e) {
      print('Erro ao converter valor: $value - $e');
      return null;
    }
  }

  static double? getDiscounts(String text) {
    String nText = text.toLowerCase().split('desconto').last;
    Iterable<Match> valores = discountValorRegExp.allMatches(nText);
    return getMaxValueDiscount(valores);
    // print('DESCONTO ${valores.first.group(0)}');
    // for (var element in valores) {
    //   print('DESCONTO ${element.group(0)}');
    // }
  }

  static RegExp discountValorRegExp =
      RegExp(r'(?<!\d)-\s?\d{1,3}(?:[.,]\d{3})*[.,]\d{2}(?!\d)');
  static RegExp valorRegExp =
      RegExp(r'(?<!\d)(?!0[.,]0{1,2})\d{1,3}(?:[.,]\d{3})*[.,]\s?\d{2}(?!\d)');
  static List<String> keyWordsValue = [
    'valor total',
    r'TOTAL R$'.toLowerCase(),
    'valor',
    'total',
    'cartão',
    'valor pago',
  ];
}
