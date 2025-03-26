class Emitter {
  ///Extract the value on accesskey and check if is valid and return the [Issuer]
  static Issuer value(final String value) {
    final result = extract(value);
    if (isValidCNPJ(result)) {
      return Issuer(document: result, docType: DocType.legalPerson);
    } else if (isValidateCPF(result)) {
      return Issuer(document: result, docType: DocType.legalPerson);
    } else {
      throw FormatException('Invalid Issuer');
    }
  }

  ///Extract the cnpj or cpf in the acess key string
  static String extract(String value) {
    return value.substring(6, 20);
  }

  ///Check if extracted value is valid
  static isValid(String value) {
    final extractedValue = extract(value);
    return isValidateCPF(extractedValue) || isValidCNPJ(extractedValue);
  }

  ///CPF validade
  static bool isValidateCPF(String cpf) {
    // Remove caracteres não numéricos
    cpf = cpf.replaceAll(RegExp(r'\D'), '');

    // Verifica se o CPF tem 11 dígitos
    if (cpf.length != 11) return false;

    // Verifica se todos os dígitos são iguais (ex: 111.111.111-11), que é inválido
    if (RegExp(r'^(\d)\1+\$').hasMatch(cpf)) return false;

    // Calcula o primeiro dígito verificador
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    int firstDigit = (sum * 10) % 11;
    if (firstDigit == 10) firstDigit = 0;
    if (firstDigit != int.parse(cpf[9])) return false;

    // Calcula o segundo dígito verificador
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    int secondDigit = (sum * 10) % 11;
    if (secondDigit == 10) secondDigit = 0;
    if (secondDigit != int.parse(cpf[10])) return false;

    return true;
  }

  ///CNPJ validate
  static bool isValidCNPJ(String cnpj) {
    cnpj = cnpj.replaceAll(RegExp(r'\D'), '');

    if (cnpj.length != 14) return false;
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
}

class Issuer {
  String document;
  DocType docType;
  Issuer({
    required this.document,
    required this.docType,
  });
}

enum DocType { legalPerson, naturalPerson }
