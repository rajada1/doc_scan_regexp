import 'package:doc_scan_regexp/src/cupom_fiscal/qrcode/qr_code_nfce-4.0/qr_code_nfce_4_offline.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/qrcode/qr_code_nfce-4.0/qr_code_nfce_4_online.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/qrcode/qr_code_result.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/qrcode/qr_code_sat/qr_code_sat.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/qrcode/qr_code_type_check.dart';

/// The QrCodeRecognizer class validates and extracts data from different types of QR codes.
/// It supports NFC-e 4.0 online and offline formats, as well as SAT QR codes.
class QrCodeRecognizer {
  /// Extracts data from a QR code string, determining its type first.
  ///
  /// Returns a QrCodeResult or throws a FormatException if the QR code format is invalid or unsupported.
  QrCodeResult extract(String qrCode) {
    // Validate QR code format first
    if (qrCode.isEmpty) {
      throw FormatException('QR code string is empty');
    }

    // Check if it's NFC-e 4.0 online format
    if (QrCodeTypeCheck.isNfce40Online(qrCode)) {
      return QrCodeNfce40Online.value(qrCode);
    }

    // Check if it's NFC-e 4.0 offline format
    if (QrCodeTypeCheck.isNfce40Offline(qrCode)) {
      return QrCodeNfce40Offline.value(qrCode);
    }

    // Check if it's SAT format
    if (QrCodeTypeCheck.isSat(qrCode)) {
      return QrCodeSat.value(qrCode);
    }

    // If none of the known formats match
    throw FormatException('Unsupported QR code format: $qrCode');
  }

  /// Determines the type of QR code without extracting data.
  ///
  /// Returns a QrCodeType enum value.
  QrCodeType getQrCodeType(String qrCode) {
    if (QrCodeTypeCheck.isNfce40Online(qrCode)) {
      return QrCodeType.nfce40Online;
    } else if (QrCodeTypeCheck.isNfce40Offline(qrCode)) {
      return QrCodeType.nfce40Offline;
    } else if (QrCodeTypeCheck.isSat(qrCode)) {
      return QrCodeType.sat;
    } else {
      return QrCodeType.unknown;
    }
  }

  /// Validates if the QR code is in any supported format.
  bool isValidQrCode(String qrCode) {
    return QrCodeTypeCheck.isNfce40Online(qrCode) ||
        QrCodeTypeCheck.isNfce40Offline(qrCode) ||
        QrCodeTypeCheck.isSat(qrCode);
  }
}

/// Enum representing different types of QR codes.
