class RecognizerCnpj {
  static RegExp cnpjRegExp = RegExp(r'\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}');

  static String? value(String text) {
    final correctText = _preprocessText(text);
    final match = cnpjRegExp.firstMatch(correctText);
    return match
        ?.group(0)
        .formatOutCnpj; // Retorna o CNPJ encontrado ou null se não houver
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
}

extension CnpjFormatter on String? {
  String? get formatOutCnpj {
    return this
        ?.replaceAll(RegExp(r'[^\d]'), ''); // Remove tudo que não for número
  }
}
