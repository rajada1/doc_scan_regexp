import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/accesskey.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/aamm.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/c_uf.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/issuer.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/mod.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/n_number.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/text/recognizer_cnpj.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/text/recognizer_document_type.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/text/recognizer_value.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/text/regognizer_date.dart';
import '../test/scanned_string.dart';

void main() {
  for (var element in [ScannedString.androidML2]) {
    extractValues(element);
  }
}

extractValues(String text) {
  final strinToUse = text;
  final String value = Accesskey.extract(strinToUse);
  if (value != '') {
    print('--------------- START ---------------');
    print('Chave de acesso: $value');
    print(
        'Emisor: ${Emitter.extract(value)}/ Valido ? ${Emitter.isValid(value)}');
    print('Estado: ${CUf.value(value).code}');
    print('Data: ${Aamm.value(value)}');
    print(
        'Tipo de documento: ${Mod.extract(value).description} --- ${Mod.extract(value).code}');
    print('Valor ${RecognizerValue.value(strinToUse)}');
    print(
        'Date with day: ${RecognizerDate.value(strinToUse, Aamm.value(value))} ');
    print('Document Number : ${NNumber.extract(value)}');

    print('--------------- END ---------------\n\n\n');
  } else {
    print('--------------- START NO ACCESS KEY ---------------');
    print('Valor ${RecognizerValue.value(strinToUse)}');
    print('Date : ${RecognizerDate.value(strinToUse, null)} ');
    print('CNPJ: ${RecognizerCnpj.value(strinToUse)} ');
    print('Document Type: ${RecognizerDocumentType.value(text)}');
    print('--------------- END ---------------\n\n\n');
  }
}
