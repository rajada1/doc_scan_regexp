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
      if (validKey.isNotEmpty) {
        break;
      }
    }

    return validKey;
  }
}
