class RecognizerCnpj {
  static RegExp cnpjRegExp = RegExp(r'\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}');

  static String? value(String text) {
    final correctText = _preprocessText(text);
    final match = cnpjRegExp.firstMatch(correctText);
    final probableCnpj = match?.group(0).formatOutCnpj;
    if (probableCnpj != null && isValidCNPJ(probableCnpj)) {
      return probableCnpj;
    }
    return null;
  }

  static String _preprocessText(String text) {
    // Substitui "/DD" por "/00" em diferentes cenários
    return text.replaceAllMapped(
      RegExp(r'(\d*)/DD(\d+)'),
      (match) {
        // Se houver números antes ou depois de "/DD", substitui por "/00"
        return '${match.group(1)}/00${match.group(2)}';
      },
    );
  }

  static bool isValidCNPJ(String cnpj) {
    cnpj = cnpj.replaceAll(RegExp(r'\D'), '');

    if (cnpj.length != 14) return false;
    if (blackListCnpj.contains(cnpj)) return false;
    if (RegExp(r'^(\d)\1+\$').hasMatch(cnpj)) return false;

    List<int> weightsFirst = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    List<int> weightsSecond = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

    int calculateDigit(String number, List<int> weights) {
      int sum = 0;
      for (int i = 0; i < weights.length; i++) {
        sum += int.parse(number[i]) * weights[i];
      }
      int remainder = sum % 11;
      return remainder < 2 ? 0 : 11 - remainder;
    }

    int firstDigit = calculateDigit(cnpj.substring(0, 12), weightsFirst);
    if (firstDigit != int.parse(cnpj[12])) return false;

    int secondDigit = calculateDigit(cnpj.substring(0, 13), weightsSecond);
    if (secondDigit != int.parse(cnpj[13])) return false;

    return true;
  }

  static const List<String> blackListCnpj = [
    "00000000000000",
    "11111111111111",
    "22222222222222",
    "33333333333333",
    "44444444444444",
    "55555555555555",
    "66666666666666",
    "77777777777777",
    "88888888888888",
    "99999999999999"
  ];
}

extension CnpjFormatter on String? {
  String? get formatOutCnpj {
    return this
        ?.replaceAll(RegExp(r'[^\d]'), ''); // Remove tudo que não for número
  }
}
