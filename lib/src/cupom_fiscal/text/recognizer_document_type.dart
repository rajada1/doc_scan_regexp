class RecognizerDocumentType {
  static const Map<String, List<String>> documentTypes = {
    'cupom fiscal': [],
    'nota fiscal eletronica': ['nfe', 'nf-e'],
    'cupom fiscal eletrônico': ['cfe', 'cf-e'],
    'cupon fiscal eletronico': ['cfe', 'cf-e'],
    'nota fiscal eletrônica ao consumidor final': ['nfce', 'nfc-e'],
    'conhecimento de transporte eletrônico': ['cte', 'ct-e'],
  };

  static String? value(String text) {
    final lowerText = text.toLowerCase();

    // Procura pelo nome completo do documento
    for (var entry in documentTypes.entries) {
      if (lowerText.contains(entry.key)) {
        return entry.key;
      }
    }

    // Procura pelas siglas, garantindo que sejam palavras isoladas
    for (var entry in documentTypes.entries) {
      for (var acronym in entry.value) {
        final regex = RegExp(r'\b' + RegExp.escape(acronym) + r'\b');
        if (regex.hasMatch(lowerText)) {
          return acronym;
        }
      }
    }

    // Retorna null se nenhum tipo de documento for encontrado
    return null;
  }
}
