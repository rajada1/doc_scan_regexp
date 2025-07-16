import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/accesskey.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/aamm.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/c_uf.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/issuer.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/mod.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/n_number.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/qrcode/qr_code_nfce-4.0/qr_code_nfce_4_online.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/qrcode/qr_code_sat/qr_code_sat.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/text/recognizer_cnpj.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/text/recognizer_document_type.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/text/recognizer_value.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/text/regognizer_date.dart';
import '../test/scanned_string.dart';

void main() {
  print('--------------- START EXAMPLE CUPOM WITH ANY TEXT ---------------');
  extractValueCupom();
  print('--------------- END EXAMPLE CUPOM WITH ANY TEXT ---------------');
  print('--------------- START EXAMPLE QR CODE NFC-e ---------------');
  extractValueQrCodeNfce();
  print('--------------- END EXAMPLE QR CODE NFC-e ---------------');
  print('--------------- START EXAMPLE QR CODE SAT ---------------');
  extractValueQrCodeSat();
  print('--------------- END EXAMPLE QR CODE SAT ---------------');
}

extractValueQrCodeNfce() {
  final result = QrCodeNfce40Online.value(ScannedString.qrCodExampleOnline33);
  print(result.accessKeyInfo?.accessKey);
  print(result.urlSefaz);
  print(result.enviroment);
}

extractValueQrCodeSat() {
  final result = QrCodeSat.value(ScannedString.qrCodNfceParana37);
  print(result.accessKeyInfo?.accessKey);
  print(result.assinaturaQRCODE);
  print(result.cpfCnpj);
  print(result.timeStamp);
  print(result.valorTotal);
  print(result.hasCpfCnpj);
  print(result.formattedDate);
  print(result.formattedTime);
}

extractValueCupom() {
  for (var element in [ScannedString.iphoneVisionText38]) {
    extractValues(element);
  }
}

extractValues(String text) {
  final strinToUse = text;
  final AccessKeyInfo? accessKeyInfo = Accesskey.extract(strinToUse);
  if (accessKeyInfo != null) {
    print('Chave de acesso: ${accessKeyInfo.accessKey}');
    print(
        'Emisor: ${Emitter.extract(accessKeyInfo.accessKey)}/ Valido ? ${Emitter.isValid(accessKeyInfo.accessKey)}');
    print('Estado: ${CUf.value(accessKeyInfo.accessKey).code}');
    print('Data: ${Aamm.value(accessKeyInfo.accessKey)}');
    print(
        'Tipo de documento: ${Mod.extract(accessKeyInfo.accessKey).description} --- ${Mod.extract(accessKeyInfo.accessKey).code}');
    print('Valor ${RecognizerValue.value(strinToUse)}');
    print(
        'Date with day: ${RecognizerDate.value(strinToUse, Aamm.value(accessKeyInfo.accessKey))} ');
    print('Document Number : ${NNumber.extract(accessKeyInfo.accessKey)}');
  } else {
    print('Valor ${RecognizerValue.value(strinToUse)}');
    print('Date : ${RecognizerDate.value(strinToUse, null)} ');
    print('CNPJ: ${RecognizerCnpj.value(strinToUse)} ');
    print('Document Type: ${RecognizerDocumentType.value(text)}');
  }
}
