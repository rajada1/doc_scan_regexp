import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/accesskey.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/qrcode/qr_code_result.dart';

class QrCodeNfce40Offline {
  static Nfce4Offline value(String value) {
    // Extract the URL part before "?p="
    final urlParts = value.split('?p=');
    final urlSefaz = urlParts[0];

    // Extract the parameters part after "?p="
    final parameters = urlParts[1].split('|');

    if (parameters.length != 8) {
      throw FormatException('Invalid QR code offline format: $value');
    }

    final chaveDeAcesso = parameters[0];
    final qrCodeVersion = int.parse(parameters[1]);
    final enviroment = parameters[2];
    final diaDataEmissao = parameters[3];
    final valorTotalNfce = parameters[4];
    final digVal = parameters[5];
    final identifierCSC = parameters[6];
    final codeHash = parameters[7];

    return Nfce4Offline(
        Accesskey.extract(chaveDeAcesso),
        urlSefaz,
        qrCodeVersion,
        enviroment,
        diaDataEmissao,
        valorTotalNfce,
        digVal,
        identifierCSC,
        codeHash);
  }
}

class Nfce4Offline implements QrCodeResult {
  @override
  final AccessKeyInfo? accessKeyInfo;
  final String urlSefaz;
  final int qrCodeVersion;

  /// 1 = Prod
  /// 2 = Homolog
  final String enviroment;
  final String diaDataEmissao;
  final String valorTotalNfce;
  final String digVal;
  final String identifierCSC;
  final String codeHash;

  Nfce4Offline(
      this.accessKeyInfo,
      this.urlSefaz,
      this.qrCodeVersion,
      this.enviroment,
      this.diaDataEmissao,
      this.valorTotalNfce,
      this.digVal,
      this.identifierCSC,
      this.codeHash);

  @override
  QrCodeType get qrCodeType => QrCodeType.nfce40Offline;
}
