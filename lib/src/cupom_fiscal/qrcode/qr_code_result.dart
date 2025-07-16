import 'package:doc_scan_regexp/doc_scan_regexp.dart';

abstract class QrCodeResult {
  final AccessKeyInfo? accessKeyInfo;
  final QrCodeType qrCodeType;

  QrCodeResult({required this.accessKeyInfo, required this.qrCodeType});
}

enum QrCodeType { nfce40Online, nfce40Offline, sat, unknown }
