import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/accesskey.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/accesskey/validations/mod.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/text/recognizer_cnpj.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/text/recognizer_document_type.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/text/recognizer_value.dart';
import 'package:doc_scan_regexp/src/cupom_fiscal/text/regognizer_date.dart';
import 'package:test/test.dart';

import 'mock_success.dart';
import 'scanned_string.dart';

void main() {
  group('AccessKey Extraction Tests', () {
    test('Extract and validate access key from iphoneVisionText1', () {
      final text = ScannedString.iphoneVisionText1;
      final AccessKeyInfo? value = Accesskey.extract(text);

      expect(value, isNotNull, reason: 'Access key should not null');
      expect(value?.accessKey, '35250157508426000763590004379042087486138245',
          reason: 'Access key should be valid');
      expect(value?.date.toString(), '01/25', reason: 'AAMM should be 0125');
      expect(value?.uf.code, 35, reason: 'CUF code should be 35');
      expect(value?.cnpj, '57508426000763',
          reason: 'Issuer should be 57508426000763');
      expect(Mod.extract(value!.accessKey).code, '59',
          reason: 'Mod code should be 59');
      expect(RecognizerValue.value(text), '41.05',
          reason: 'Value should be 59');
      expect(RecognizerDate.value(text, value.date), '28/01/2025',
          reason: 'Date should be 28/01/2025');
    });

    for (var i = 0; i < MockSuccess.listTestAll.length; i++) {
      final mock = MockSuccess.listTestAll[i];

      test('Extract and validate access key ID ${mock.mockId}', () {
        final text = mock.scannerString;
        final AccessKeyInfo? value = Accesskey.extract(text);
        expect(value, isNotNull, reason: 'Access key should not be empty');
        expect(value?.accessKey, mock.accessKey,
            reason: 'Access key should be valid');
        expect(value?.date.toString(), mock.aamm,
            reason: 'AAMM should be ${mock.aamm}');
        expect(value?.uf.code, mock.cUf,
            reason: 'CUF code should be ${mock.cUf}');
        expect(value?.cnpj, mock.emiiter,
            reason: 'Issuer should be ${mock.emiiter}');
        expect(Mod.extract(value!.accessKey).code, '${mock.mod}',
            reason: 'Mod code should be ${mock.mod}');
        expect(RecognizerValue.value(text), mock.value,
            reason: 'Value should be ${mock.value}');
        expect(RecognizerDate.value(text, value.date), mock.date,
            reason: 'Date should be ${mock.date}');
      });
    }

    for (var i = 0; i < MockSuccess.listTestSimples.length; i++) {
      final mock = MockSuccess.listTestSimples[i];

      test('Extract and validate access key ID ${mock.mockId}', () {
        final text = mock.scannerString;
        final AccessKeyInfo? accessKeyInfo = Accesskey.extract(text);
        expect(accessKeyInfo?.accessKey, mock.accessKey,
            reason: 'Access key should be valid');
        expect(RecognizerValue.value(text), mock.value,
            reason: 'Value should be ${mock.value}');
        expect(
            RecognizerDate.value(text,
                accessKeyInfo?.accessKey != '' ? accessKeyInfo?.date : null),
            mock.date,
            reason: 'Date should be ${mock.date}');
      });
    }
  });

  group('NoAccess Key Text Only Tests', () {
    for (var i = 0; i < MockSuccess.listnoAccessKey.length; i++) {
      final mock = MockSuccess.listnoAccessKey[i];

      test('Extract and validate informations key ID ${mock.mockId}', () {
        final text = mock.scannerString;

        expect(RecognizerValue.value(text), mock.value,
            reason: 'Value should be ${mock.value}');
        expect(RecognizerDate.value(text, null), mock.date,
            reason: 'Date should be ${mock.date}');

        expect(RecognizerCnpj.value(text), mock.emiiter,
            reason: 'CNPJ should be ${mock.emiiter}');
        expect(RecognizerDocumentType.value(text), mock.type,
            reason: 'Type should be ${mock.type}');
      });
    }
  });
}
