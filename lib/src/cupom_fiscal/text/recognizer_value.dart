import 'package:doc_scan_regexp/src/helpers/extensions.dart';

class RecognizerValue {
  static String? value(String text) {
    return makeFindValue(text);
  }

  static String? makeFindValue(String text) {
    for (var element in keyWordsValue) {
      if (text.toLowerCase().contains(element.toLowerCase())) {
        final result =
            findValueNextValueStringFromSplit(text, element.toLowerCase());

        if (result != '') {
          return result;
        }
      }
    }
    final res1 = findValueAfterCurrencySymbol(text);
    return res1;
  }

  static String findValueNextValueStringFromSplit(
      String text, String splitText) {
    try {
      // print('VALUE SPLIT: $splitText');
      String nText = text.toLowerCase().split(splitText).last;

      Iterable<Match> valores = valorRegExp.allMatches(nText);

      // valores.first.group(0) ?? '';

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
      // Remove espaços em branco
      value = value.removeWhiteSpace;

      // Verifica se o valor corresponde ao padrão específico "1.000.00"
      if (RegExp(r'^\d{1,3}(\.\d{3})*\.\d{2}$').hasMatch(value)) {
        // Remove os separadores de milhares (pontos) e mantém o separador decimal (último ponto)
        value = value.replaceAll('.', '');
        value =
            '${value.substring(0, value.length - 2)}.${value.substring(value.length - 2)}';
      }

      // Verifica se o valor contém separadores de milhares e decimais
      if (value.contains('.') && value.contains(',')) {
        // Remove os pontos (separadores de milhares) e substitui a vírgula pelo ponto decimal
        value = value.replaceAll('.', '').replaceAll(',', '.');
      } else if (value.contains('.')) {
        // Caso tenha apenas pontos, assume que o último é o separador decimal
        final lastDotIndex = value.lastIndexOf('.');
        value = value.replaceRange(lastDotIndex, lastDotIndex + 1, '#');
        value = value.replaceAll('.', '').replaceAll('#', '.');
      } else if (value.contains(',')) {
        // Substitui a vírgula pelo ponto decimal
        value = value.replaceAll(',', '.');
      }

      // Tenta converter o valor normalizado para double
      return double.tryParse(value);
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

  static String? findValueAfterCurrencySymbol(String text) {
    try {
      // Define o RegExp para capturar "R$" seguido de um número
      final regExp = RegExp(r'R\$\s?(\d{1,3}(?:[.,]\d{3})*[.,]?\d*)');

      // Procura pelo primeiro valor correspondente
      final match = regExp.firstMatch(text);

      // Retorna o número encontrado ou null se não houver correspondência
      final result = match
          ?.group(1)
          ?.replaceAll(',', '.'); // Substitui vírgula por ponto, se necessário

      return double.tryParse(result ?? '').toString();
    } catch (e) {
      print('Erro ao capturar valor após R\$: $e');
      return null;
    }
  }

  static RegExp discountValorRegExp =
      RegExp(r'(?<!\d)-\s?\d{1,3}(?:[.,]\d{3})*[.,]\d{2}(?!\d)');
  static RegExp valorRegExp =
      RegExp(r'(?<!\d)(?!0[.,]0{1,2})\d{1,3}(?:[.,]\d{3})*[.,]\s?\d{2}(?!\d)');
  static List<String> keyWordsValue = [
    'VALOR TOTAL DA NOTA',
    'valor total',
    r'TOTAL R$',
    'credito',
    'valor',
    r'R$',
    'total',
    'cartão',
    'valor pago',
  ];
}
