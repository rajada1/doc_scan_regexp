class RecognizerDocumentType {
  static List<DocumentTypeObject> documentTypes = [
    DocumentTypeObject('cupom fiscal', [], DocType.cf),
    DocumentTypeObject('nota fiscal eletronica', ['nfe', 'nf-e'], DocType.nfe),
    DocumentTypeObject('cupom fiscal eletrônico', ['cfe', 'cf-e'], DocType.cfe),
    DocumentTypeObject('cupon fiscal eletronico', ['cfe', 'cf-e'], DocType.cfe),
    DocumentTypeObject('nota fiscal eletrônica ao consumidor final',
        ['nfce', 'nfc-e'], DocType.nfce),
    DocumentTypeObject(
        'conhecimento de transporte eletrônico', ['cte', 'ct-e'], DocType.cte),
  ];

  static String? value(String text) {
    final lowerText = text.toLowerCase();

    // Procura pelo nome completo do documento
    for (var documentType in documentTypes) {
      if (lowerText.contains(documentType.name)) {
        return documentType.name;
      }
    }

    // Procura pelas siglas, garantindo que sejam palavras isoladas
    for (var documentType in documentTypes) {
      for (var acronym in documentType.acronyms) {
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

enum DocType {
  cf,
  nfe,
  cfe,
  nfce,
  cte,
}

class DocumentTypeObject {
  final String name; // Nome completo do documento
  final List<String> acronyms; // Siglas associadas ao documento
  final DocType typeEnum; // Tipo do documento

  DocumentTypeObject(this.name, this.acronyms, this.typeEnum);
}
