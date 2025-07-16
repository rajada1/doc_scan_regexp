import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/accesskey.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/qrcode/qr_code_result.dart';

class QrCodeSat {
  static SatQrCode value(String value) {
    // Split the QR code string by the pipe character
    final parameters = value.split('|');

    // Verify if it's the format with or without CPF/CNPJ
    final hasCpfCnpj = parameters.length == 5;
    final noCpfCnpj =
        parameters.length == 4 && parameters[2] != '' && parameters[3] == '';

    if (!hasCpfCnpj && !noCpfCnpj) {
      throw FormatException('Invalid SAT QR code format: $value');
    }

    final chaveConsulta = parameters[0];
    final timeStamp = parameters[1];
    final valorTotal = parameters[2];

    String cpfCnpj = '';
    String assinaturaQRCODE = '';

    if (hasCpfCnpj) {
      // Format with CPF/CNPJ: chaveConsulta|timeStamp|valorTotal|CPFCNPJValue|assinaturaQRCODE
      cpfCnpj = parameters[3];
      assinaturaQRCODE = parameters[4];
    } else {
      // Format without CPF/CNPJ: chaveConsulta|timeStamp|valorTotal||assinaturaQRCODE
      assinaturaQRCODE = parameters[3];
    }

    return SatQrCode(Accesskey.extract(chaveConsulta), timeStamp, valorTotal,
        cpfCnpj, assinaturaQRCODE);
  }
}

class SatQrCode implements QrCodeResult {
  @override
  final AccessKeyInfo? accessKeyInfo; // chaveConsulta
  final String timeStamp;
  final String valorTotal;
  final String cpfCnpj;
  final String assinaturaQRCODE;

  /// Creates a SatQrCode instance.
  ///
  /// [accessKey] - chaveConsulta with or without "CFe" prefix
  /// [timeStamp] - timestamp in format YYYYMMDDHHMMSS
  /// [valorTotal] - total value with dot as decimal separator (e.g. "10.00")
  /// [cpfCnpj] - optional CPF or CNPJ value, empty if not provided
  /// [assinaturaQRCODE] - signature hash value
  SatQrCode(this.accessKeyInfo, this.timeStamp, this.valorTotal, this.cpfCnpj,
      this.assinaturaQRCODE);

  /// Checks if the QR code contains CPF or CNPJ information
  bool get hasCpfCnpj => cpfCnpj.isNotEmpty;

  /// Formatted date from the timestamp (DD/MM/YYYY)
  String get formattedDate {
    if (timeStamp.length < 8) return '';
    return '${timeStamp.substring(6, 8)}/${timeStamp.substring(4, 6)}/${timeStamp.substring(0, 4)}';
  }

  /// Formatted time from the timestamp (HH:MM:SS)
  String get formattedTime {
    if (timeStamp.length < 14) return '';
    return '${timeStamp.substring(8, 10)}:${timeStamp.substring(10, 12)}:${timeStamp.substring(12, 14)}';
  }

  @override
  QrCodeType get qrCodeType => QrCodeType.sat;
}
