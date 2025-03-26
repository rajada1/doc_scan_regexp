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
    MockSuccessSimples(
        mockId: 9,
        scannerString: ScannedString.iphoneVisionText22,
        accessKey: '35250358324062000133590014932150022099741571',
        value: '127.89',
        date: '18/03/2025'),
    MockSuccessSimples(
        mockId: 10,
        scannerString: ScannedString.iphoneVisionText23,
        accessKey: '35250309062469000120590009584010162303834099',
        value: '283.0',
        date: '13/03/2025'),
    MockSuccessSimples(
        mockId: 11,
        scannerString: ScannedString.iphoneVisionText25,
        accessKey: '41250378577822000127650010000565581379632780',
        value: '122.39',
        date: '25/03/2025'),
    MockSuccessSimples(
        mockId: 12,
        scannerString: ScannedString.iphoneVisionText24,
        accessKey: '41250382196213000103651100004999361995000634',
        value: '352.63',
        date: '25/03/2025'),
    MockSuccessSimples(
        mockId: 13,
        scannerString: ScannedString.iphoneVisionText26,
        accessKey: '29250110948651004906550040001110211241964644',
        value: '8259.98',
        date: '31/01/2025'),
    MockSuccessSimples(
        mockId: 14,
        scannerString: ScannedString.iphoneVisionText27,
        accessKey: '53250301438784003201550060002820191377736291',
        value: '1838.04',
        date: '25/03/2025'),
    MockSuccessSimples(
        mockId: 15,
        scannerString: ScannedString.iphoneVisionText28,
        accessKey: '29250344235185000199650050001534809325134886',
        value: '49.0',
        date: '23/03/2025'),
    MockSuccessSimples(
        mockId: 16,
        scannerString: ScannedString.iphoneVisionText29,
        accessKey: '29250344235185000199650050001534809325134886',
        value: '35.50',
        date: '17/03/2025'),
     MockSuccessSimples(
        mockId: 17,
        scannerString: ScannedString.iphoneVisionText30,
        accessKey: '29250344235185000199650050001534809325134886',
        value: '1000.0',
        date: '15/12/2024'),

  ];

  static List<MockSuccessSimples> listnoAccessKey = [
    MockSuccessSimples(
        mockId: 21,
        scannerString: ScannedString.iphoneVisionText19,
        accessKey: '',
        value: '208.45',
        date: '08/09/2024',
        emiiter: '04614908000146',
        type: 'cupom fiscal'),
    MockSuccessSimples(
        mockId: 20,
        scannerString: ScannedString.iphoneVisionText17,
        accessKey: '',
        value: '15.31',
        date: '12/02/2025',
        emiiter: '56344938000183',
        type: 'nfce'),
    MockSuccessSimples(
        mockId: 18,
        scannerString: ScannedString.iphoneVisionText31,
        accessKey: '',
        value: '16.0',
        date: '27/02/2025',
        emiiter: '46408575000149',
        type: 'cupom fiscal'),
     MockSuccessSimples(
        mockId: 19,
        scannerString: ScannedString.iphoneVisionText32,
        accessKey: '',
        value: '30.0',
        date: '27/02/2025',
        emiiter: '09586514000226',
        type: 'cupom fiscal'),
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
