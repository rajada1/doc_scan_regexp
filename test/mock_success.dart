// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'scanned_string.dart';

class MockSuccess {
  int mockId;
  String scannerString;
  String accessKey;
  String emiiter;
  int cUf;
  int mod;
  String aamm;
  String? value;
  String? date;
  MockSuccess({
    required this.mockId,
    required this.scannerString,
    required this.accessKey,
    required this.emiiter,
    required this.cUf,
    required this.mod,
    required this.aamm,
    required this.value,
    required this.date,
  });

  static List<MockSuccess> listTestAll = [
    MockSuccess(
        mockId: 0,
        scannerString: ScannedString.iphoneVisionText18,
        accessKey: '41240904750620000107650020000135941008855050',
        emiiter: '04750620000107',
        cUf: 41,
        mod: 65,
        aamm: '09/24',
        value: '50.0',
        date: '20/09/2024'),
    MockSuccess(
        mockId: 1,
        scannerString: ScannedString.iphoneVisionText16,
        accessKey: '26250317713782000109650010001349681104851850',
        emiiter: '17713782000109',
        cUf: 26,
        mod: 65,
        aamm: '03/25',
        value: '130.57',
        date: '12/03/2025')
  ];

  static List<MockSuccessSimples> listTestSimples = [
    MockSuccessSimples(
        mockId: 2,
        scannerString: ScannedString.iphoneVisionText18,
        accessKey: '41240904750620000107650020000135941008855050',
        value: '50.0',
        date: '20/09/2024'),
    MockSuccessSimples(
        mockId: 3,
        scannerString: ScannedString.iphoneVisionText16,
        accessKey: '26250317713782000109650010001349681104851850',
        value: '130.57',
        date: '12/03/2025'),
    MockSuccessSimples(
        mockId: 4,
        scannerString: ScannedString.iphoneVisionText8,
        accessKey: '35250343259548001305590007676143032845553078',
        value: '352.04',
        date: '15/03/2025'),
    MockSuccessSimples(
        mockId: 5,
        scannerString: ScannedString.iphoneVisionText9,
        accessKey: '35250306057223041366590012675880378940282382',
        value: '47.07',
        date: '18/03/2025'),
    MockSuccessSimples(
        mockId: 6,
        scannerString: ScannedString.iphoneVisionText10,
        accessKey: '35250349825916000170590013333900154054298824',
        value: '149.94',
        date: '19/03/2025'),
    MockSuccessSimples(
        mockId: 7,
        scannerString: ScannedString.iphoneVisionText11,
        accessKey: '35250327680140000104590009760661808967884172',
        value: '120.75',
        date: '16/03/2025'),
    MockSuccessSimples(
        mockId: 8,
        scannerString: ScannedString.iphoneVisionText12,
        accessKey: '43250393209765016110655100000770731048579171',
        value: '25.97',
        date: '21/03/2025'),
  ];

  static List<MockSuccessSimples> listnoAccessKey = [
    MockSuccessSimples(
        mockId: 9,
        scannerString: ScannedString.iphoneVisionText19,
        accessKey: '',
        value: '208.45',
        date: '08/09/2024',
        emiiter: '04614908000146',
        type: 'cupom fiscal'),
    MockSuccessSimples(
        mockId: 10,
        scannerString: ScannedString.iphoneVisionText17,
        accessKey: '',
        value: '15.31',
        date: '12/02/2025',
        emiiter: '56344938000183',
        type: 'nfce'),
  ];
}

class MockSuccessSimples {
  int mockId;
  String scannerString;
  String accessKey;
  String? value;
  String? date;
  String? emiiter;
  String? type;
  MockSuccessSimples({
    required this.mockId,
    required this.scannerString,
    required this.accessKey,
    this.value,
    this.date,
    this.emiiter,
    this.type,
  });
}
