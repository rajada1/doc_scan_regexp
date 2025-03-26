class Mod {
  ///Extract mod(Modelo do Documento Fiscal) number in the accesskey string and return [ModInfo]
  ///
  ///validate: default is true
  static ModInfo value(final String value, [final bool validate = true]) {
    return validate
        ? isValid(value)
            ? extract(value)
            : throw FormatException('Mod Number Not Found')
        : extract(value);
  }

  ///Extract mod(Modelo do Documento Fiscal) in accesskey string
  static ModInfo extract(String value) {
    String code = value.substring(20, 22);
    return available.firstWhere((mod) => mod.code == code,
        orElse: () => ModInfo(code, '', ''));
  }

  ///Check if the mod is available
  ///
  ///Documentation https://www.confaz.fazenda.gov.br/legislacao/atos/2009/AC038_09
  static bool isValid(String value) {
    return available.any((mod) => mod.code == extract(value).code);
  }

  static final available = [
    ModInfo('01', 'NF', 'Nota Fiscal'),
    ModInfo('02', 'NFVC', 'Nota Fiscal de Venda a Consumidor'),
    ModInfo('04', 'NFP', 'Nota Fiscal de Produtor'),
    ModInfo('06', 'NFCE', 'Nota Fiscal/Conta de Energia Elétrica'),
    ModInfo('07', 'NFST', 'Nota Fiscal de Serviço de Transporte'),
    ModInfo('08', 'CTRC', 'Conhecimento de Transporte Rodoviário de Cargas'),
    ModInfo('09', 'CTAC', 'Conhecimento de Transporte Aquaviário de Cargas'),
    ModInfo('10', 'CA', 'Conhecimento Aéreo'),
    ModInfo('11', 'CTFC', 'Conhecimento de Transporte Ferroviário de Cargas'),
    ModInfo('13', 'BPR', 'Bilhete de Passagem Rodoviário'),
    ModInfo('14', 'BPA', 'Bilhete de Passagem Aquaviário'),
    ModInfo('15', 'BPNB', 'Bilhete de Passagem e Nota de Bagagem'),
    ModInfo('16', 'BPF', 'Bilhete de Passagem Ferroviário'),
    ModInfo('17', 'DT', 'Despacho de Transporte'),
    ModInfo('18', 'RMD', 'Resumo de Movimento Diário'),
    ModInfo('20', 'OCC', 'Ordem de Coleta de Cargas'),
    ModInfo('21', 'NFSC', 'Nota Fiscal de Serviço de Comunicação'),
    ModInfo('22', 'NFST', 'Nota Fiscal de Serviço de Telecomunicação'),
    ModInfo('23', 'GNRE', 'GNRE'),
    ModInfo('24', 'AC', 'Autorização de Carregamento e Transporte'),
    ModInfo('25', 'MC', 'Manifesto de Carga'),
    ModInfo('26', 'CTMC', 'Conhecimento de Transporte Multimodal de Cargas'),
    ModInfo('27', 'NFTFC', 'Nota Fiscal de Transporte Ferroviário de Cargas'),
    ModInfo(
        '28', 'NFCG', 'Nota Fiscal/Conta de Fornecimento de Gás Canalizado'),
    ModInfo(
        '29', 'NFCA', 'Nota Fiscal/Conta de Fornecimento de água Canalizada'),
    ModInfo('30', 'BRP', 'Bilhete/Recibo do Passageiro'),
    ModInfo('2D', 'CFECF', 'Cupom Fiscal emitido por ECF'),
    ModInfo('2E', 'BPEC', 'Bilhete de Passagem emitido por ECF'),
    ModInfo('55', 'NFE', 'Nota Fiscal Eletrônica'),
    ModInfo('57', 'CTE', 'Conhecimento de Transporte Eletrônico - CT-e'),
    ModInfo('67', 'CTE', 'Conhecimento de Transporte Eletrônico - CT-e'),
    ModInfo('59', 'CF', 'Cupom Fiscal Eletrônico - CF-e'),
    ModInfo('60', 'CFEECF', 'Cupom Fiscal Eletrônico CF-e-ECF'),
    ModInfo(
        '65', 'NFECF', 'Nota Fiscal Eletrônica ao Consumidor Final - NFC-e'),
    ModInfo('8B', 'CTCA', 'Conhecimento de Transporte de Cargas Avulso'),
  ];
}

class ModInfo {
  final String code;
  final String abbreviation;
  final String description;

  ModInfo(this.code, this.abbreviation, this.description);

  @override
  String toString() => '$abbreviation - $description - $code';
}
