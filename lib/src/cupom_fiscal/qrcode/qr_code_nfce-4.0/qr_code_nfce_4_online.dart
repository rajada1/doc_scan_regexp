import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/accesskey.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/qrcode/qr_code_result.dart';

class QrCodeNfce40Online {
  static Nfce4Online value(String value) {
    // Extract the URL part before "?p="
    final urlParts = value.split('?p=');
    final urlSefaz = urlParts[0];

    // Extract the parameters part after "?p="
    final parameters = urlParts[1].split('|');

    if (parameters.length != 5) {
      throw FormatException('Invalid QR code format: $value');
    }

    final chaveDeAcesso = parameters[0];
    final qrCodeVersion = int.parse(parameters[1]);
    final enviroment = parameters[2];
    final identifierCSC = parameters[3];
    final codeHash = parameters[4];

    return Nfce4Online(Accesskey.extract(chaveDeAcesso), urlSefaz,
        qrCodeVersion, enviroment, identifierCSC, codeHash);
  }
}

class Nfce4Online implements QrCodeResult {
  @override
  final AccessKeyInfo? accessKeyInfo;
  final String urlSefaz;
  final int qrCodeVersion;

  /// 1 = Prod
  /// 2 = Homolog
  final String enviroment;
  final String identifierCSC;
  final String codeHash;

  Nfce4Online(this.accessKeyInfo, this.urlSefaz, this.qrCodeVersion,
      this.enviroment, this.identifierCSC, this.codeHash);

  @override
  QrCodeType get qrCodeType => QrCodeType.nfce40Online;
}
