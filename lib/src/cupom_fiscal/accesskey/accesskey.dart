import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/aamm.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/c_uf.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/cdf.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/cdv.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/issuer.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/mod.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/ndf.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/series.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/tp_emis.dart';

/// Full AccessKey Documentation https://www.nfe.fazenda.gov.br/portal/exibirArquivo.aspx?conteudo=aOZYFk0MTiw=
class Accesskey {
  static void printInvalidReason(String value) {
    if (!Aamm.isValid(value)) {
      print('Invalid AAMM ${Aamm.extract(value)}');
    } else if (!Cdf.isValid(value)) {
      print('Invalid CDF');
    } else if (!Cdv.isValid(value)) {
      print('Invalid CDV');
    } else if (!CUf.isValid(value)) {
      print('Invalid CUF');
    } else if (!Emitter.isValid(value)) {
      print('Invalid Issuer');
    } else if (!Mod.isValid(value)) {
      print('Invalid Mod ${Mod.extract(value)}');
    } else if (!Ndf.isValid(value)) {
      print('Invalid NDF');
    } else if (!Series.isValid(value)) {
      print('Invalid Series');
    } else if (!TpEmis.isValid(value)) {
      print('Invalid TP Emis');
    } else {
      print('Valid');
    }
  }

  static bool isValid(String value) {
    if (blackList.contains(value)) {
      return false;
    }
    bool aammValid = Aamm.isValid(value);
    bool cdfValid = Cdf.isValid(value);
    bool cdvValid = Cdv.isValid(value);
    bool cufValid = CUf.isValid(value);
    bool issuerValid = Emitter.isValid(value);
    bool modValid = Mod.isValid(value);
    bool ndfValid = Ndf.isValid(value);
    bool seriesValid = Series.isValid(value);
    bool tpEmisValid = TpEmis.isValid(value);
    return (aammValid &&
        cdfValid &&
        cdvValid &&
        cufValid &&
        issuerValid &&
        modValid &&
        ndfValid &&
        seriesValid &&
        tpEmisValid);
  }

  static String extract(String value) {
    // only numbers
    final text = value.replaceAll(RegExp(r'\D'), '');
    String validKey = '';
    for (final uf in CUf.available) {
      int index = 0;
      while ((index = text.indexOf('${uf.code}', index)) != -1) {
        if (index + 44 <= text.length) {
          final key = text.substring(index, index + 44);
          // print(key);
          if (isValid(key)) {
            validKey = key;
            break;
          }
        }
        index += '${uf.code}'.length;
      }
    }

    if (validKey == '') {
      return tryGetKeyUsingStartUfCode(text);
    }

    return validKey;
  }

  static String tryGetKeyUsingStartUfCode(String text) {
    final List<String> probableKeys = [];
    for (final uf in CUf.available) {
      int index = 0;
      while ((index = text.indexOf('${uf.code}', index)) != -1) {
        if (index + 44 <= text.length) {
          final key = text.substring(index, index + 44);
          // print(key);
          probableKeys.add(_normalizeProbableKey3(key));

          // if (isValid(key)) {
          //   validKey = key;
          //   break;
          // }
        }
        index += '${uf.code}'.length;
      }
    }
    // print(probableKeys);
    // for (var element in CUf.available) {
    //   final ufCode = element.code;
    //   final index = text.indexOf('$ufCode');
    //   if (index != -1 && index + 44 <= text.length) {
    //     final key = text.substring(index, index + 44);

    //     probableKeys.add(_normalizeProbableKey(key));
    //   }
    // }
    return validateProbableKeys(probableKeys);
  }

  static String validateProbableKeys(List<String> keys) {
    for (var element in keys) {
      if (isValid(element)) {
        return element;
      }
    }
    return '';
  }

  static String _normalizeProbableKey(String value) {
    String allNormalizeApply = value;
    final prefix = value.substring(0, 2);
    String restOfValue = value.substring(2);

    if (value.startsWith('312503147381830')) {
      // print('Normalize All  $allNormalizeApply');
      print('Prefix $prefix');
      print('RestValue $restOfValue');
    }
    for (var element in normalizerPatterns) {
      restOfValue = restOfValue.replaceAll(
        RegExp(element.$1),
        element.$2,
      );
      print(restOfValue);
      restOfValue = '$prefix$restOfValue';
      // print(restOfValue);
      if (isValid(restOfValue)) {
        print('VALID KEY $restOfValue');
        return restOfValue;
      }
    }
    // for (var element in normalizerPatterns) {
    //   allNormalizeApply.replaceAll(
    //     RegExp(element.$1),

    //     element.$2, // Substitui "31" por "34"
    //   );
    // }
    if (value.startsWith('312503147381830')) {
      // print('Normalize All  $allNormalizeApply');
      print('Normalize Value $restOfValue');
    }
    return restOfValue;
    // // Substitui valores incorretos (exemplo: 33 -> 39)
    // return value.replaceAllMapped(
    //   RegExp(r'(\d{4})33(\d{4})'),
    //   (match) {
    //     // Substitui "33" por "39" no padrão identificado
    //     return '${match.group(1)}39${match.group(2)}';
    //   },
    // ).replaceAllMapped(
    //   RegExp(r'(\d{4})31(\d{4})'),
    //   (match) {
    //     // Substitui "33" por "39" no padrão identificado
    //     return '${match.group(1)}34${match.group(2)}';
    //   },
    // );
  }

  static String _normalizeProbableKey2(String value) {
    // Mantém os dois primeiros caracteres intactos
    final prefix = value.substring(0, 2);
    String restOfValue = value.substring(2);

    // Aplica o replace apenas na parte após os dois primeiros caracteres
    for (var element in normalizerPatterns) {
      restOfValue = restOfValue.replaceAll(
        RegExp(element.$1),
        element.$2, // Substitui "31" por "34"
      );
      if (value.startsWith('312503147381830')) {
        // print('Normalize All  $allNormalizeApply');
        print('Prefix $prefix');
        print('RestValue $restOfValue');
        print('JOIN: $prefix$restOfValue');
      }
      if (isValid('$prefix$restOfValue')) {
        return '$prefix$restOfValue';
      }
    }

    // Retorna o valor completo com o prefixo intacto
    return '$prefix$restOfValue';
  }

  static String _normalizeProbableKey3(String value) {
    // Mantém os dois primeiros caracteres intactos
    final prefix = value.substring(0, 2);
    String restOfValue = value.substring(2);

    // Itera sobre os padrões de normalização
    for (var element in normalizerPatterns) {
      final pattern = RegExp(element.$1);
      final replacement = element.$2;

      // Encontra todas as ocorrências do padrão
      final matches = pattern.allMatches(restOfValue).toList();

      // Substitui uma ocorrência por vez e verifica se é válida
      for (var match in matches) {
        final start = match.start;
        final end = match.end;

        // Substitui apenas a ocorrência atual
        final normalizedValue =
            restOfValue.replaceRange(start, end, replacement);

        // Concatena o prefixo com o valor normalizado
        final fullValue = '$prefix$normalizedValue';

        // Verifica se a chave é válida
        if (isValid(fullValue)) {
          return fullValue;
        }
      }
    }

    // Retorna o valor original se nenhuma substituição resultar em uma chave válida
    return '$prefix$restOfValue';
  }

  static const List<(String, String)> normalizerPatterns = [
    (r'31', r'34'),
    (r'33', r'39'),
  ];

  static const List<String> blackList = [
    '15131250314738183000151650020000346451000346'
  ];
}
