class CUf {
  ///Return [UFinfo] content the year(aa) and month(mm) in the accesskey string.
  ///
  ///validade: default is true
  static UFinfo value(String value, [bool validate = true]) {
    return validate
        ? isValid(value)
            ? extract(value)
            : throw FormatException('UF code invalid')
        : extract(value);
  }

  /// Extract the uf code in access key string and return [UFinfo] in available
  static UFinfo extract(String value) {
    return available.firstWhere(
      (element) => element.code == int.parse(value.substring(0, 2)),
      orElse: () => UFinfo(name: 'NotFound', code: 0, initials: ''),
    );
  }

  /// Check if the uf code in the access key string is valid
  static bool isValid(String value) {
    return available
            .firstWhere(
                (element) =>
                    element.code == int.parse('${extract(value).code}'),
                orElse: () => throw FormatException('UF code invalid'))
            .code !=
        0;
  }

  static final List<UFinfo> available = [
    UFinfo(name: 'Rondônia', code: 11, initials: 'RO'),
    UFinfo(name: 'Acre', code: 12, initials: 'AC'),
    UFinfo(name: 'Amazonas', code: 13, initials: 'AM'),
    UFinfo(name: 'Roraima', code: 14, initials: 'RR'),
    UFinfo(name: 'Pará', code: 15, initials: 'PA'),
    UFinfo(name: 'Amapá', code: 16, initials: 'AP'),
    UFinfo(name: 'Tocantins', code: 17, initials: 'TO'),
    UFinfo(name: 'Maranhão', code: 21, initials: 'MA'),
    UFinfo(name: 'Piauí', code: 22, initials: 'PI'),
    UFinfo(name: 'Ceará', code: 23, initials: 'CE'),
    UFinfo(name: 'Rio Grande do Norte', code: 24, initials: 'RN'),
    UFinfo(name: 'Paraíba', code: 25, initials: 'PB'),
    UFinfo(name: 'Pernambuco', code: 26, initials: 'PE'),
    UFinfo(name: 'Alagoas', code: 27, initials: 'AL'),
    UFinfo(name: 'Sergipe', code: 28, initials: 'SE'),
    UFinfo(name: 'Bahia', code: 29, initials: 'BA'),
    UFinfo(name: 'Minas Gerais', code: 31, initials: 'MG'),
    UFinfo(name: 'Espírito Santo', code: 32, initials: 'ES'),
    UFinfo(name: 'Rio de Janeiro', code: 33, initials: 'RJ'),
    UFinfo(name: 'São Paulo', code: 35, initials: 'SP'),
    UFinfo(name: 'Paraná', code: 41, initials: 'PR'),
    UFinfo(name: 'Santa Catarina', code: 42, initials: 'SC'),
    UFinfo(name: 'Rio Grande do Sul', code: 43, initials: 'RS'),
    UFinfo(name: 'Mato Grosso do Sul', code: 50, initials: 'MS'),
    UFinfo(name: 'Mato Grosso', code: 51, initials: 'MT'),
    UFinfo(name: 'Goiás', code: 52, initials: 'GO'),
    UFinfo(name: 'Distrito Federal', code: 53, initials: 'DF'),
  ];
}

class UFinfo {
  String name;
  int code;
  String initials;
  UFinfo({required this.name, required this.code, required this.initials});
}
