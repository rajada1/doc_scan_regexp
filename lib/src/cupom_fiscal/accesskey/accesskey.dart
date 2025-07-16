// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:doc_scan_regexp/doc_scan_regexp.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/cdf.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/cdv.dart';
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

  static AccessKeyInfo? extract(String value) {
    // only numbers
    final text = value.replaceAll(RegExp(r'\D'), '');
    String validKey = '';
    for (final uf in CUf.available) {
      int index = 0;
      while ((index = text.indexOf('${uf.code}', index)) != -1) {
        if (index + 44 <= text.length) {
          final key = text.substring(index, index + 44);

          if (isValid(key)) {
            validKey = key;
            break;
          }
        }
        index += '${uf.code}'.length;
      }
    }

    if (validKey == '') {
      validKey = tryGetKeyUsingStartUfCode(text);
    }
    if (validKey == '') {
      validKey = tryGetKeyOnlyNormalizePattern(text);
    }

    return validKey != ''
        ? AccessKeyInfo(
            accessKey: validKey,
            uf: CUf.extract(validKey),
            date: Aamm.extract(validKey),
            cnpj: Emitter.extract(validKey),
            type: Mod.extract(validKey),
            number: NNumber.extract(validKey))
        : null;
  }

  static String tryGetKeyOnlyNormalizePattern(String value) {
    String text = value.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
    final List<String> probableKeys = [];

    // Create a sliding window of 44 characters
    for (int i = 0; i <= text.length - 44; i++) {
      final String key = text.substring(i, i + 44);
      final String normalizedKey = _normalizeProbableKeyInitialPrefix(key);
      if (normalizedKey != '') {
        probableKeys.add(normalizedKey);
      }
    }
    return validateProbableKeys(probableKeys);
  }

  static String tryGetKeyUsingStartUfCode(String text) {
    final List<String> probableKeys = [];
    for (final uf in CUf.available) {
      int index = 0;
      while ((index = text.indexOf('${uf.code}', index)) != -1) {
        if (index + 44 <= text.length) {
          final key = text.substring(index, index + 44);

          probableKeys.add(_normalizeProbableKey3(key));
        }
        index += '${uf.code}'.length;
      }
    }

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

  static String _normalizeProbableKeyInitialPrefix(String value) {
    // Mantém os dois primeiros caracteres intactos
    final finalValue = value.substring(2);
    String restOfValue = value.substring(0, 2);
    // .substring(2);

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
        final fullValue = '$normalizedValue$finalValue';
        // Verifica se a chave é válida
        if (CUf.available.any(
              (element) {
                return '${element.code}' == normalizedValue;
              },
            ) &&
            isValid(fullValue)) {
          return fullValue;
        }
      }
    }

    // Retorna o valor original se nenhuma substituição resultar em uma chave válida
    return '';
  }

  static const List<(String, String)> normalizerPatterns = [
    (r'31', r'34'),
    (r'33', r'39'),
    (r'36', r'35'),
  ];

  static const List<String> blackList = [
    '15131250314738183000151650020000346451000346'
  ];
}

class AccessKeyInfo {
  String accessKey;

  /// Ex: SP
  UFinfo uf;

  /// MM/YY
  AccessKeyDate date;

  /// Ex: 12345678901234
  String cnpj;

  ModInfo type;
  String number;
  AccessKeyInfo({
    required this.accessKey,
    required this.uf,
    required this.date,
    required this.cnpj,
    required this.type,
    required this.number,
  });
}
