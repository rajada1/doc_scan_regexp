class QrCodeTypeCheck {
  /// Checks if the QR code is from NFC-e 4.0 online format
  static bool isNfce40Online(String qrCode) {
    try {
      // Check for basic format first
      if (!qrCode.contains('?p=')) return false;

      // Extract the parameters part after "?p="
      final urlParts = qrCode.split('?p=');
      if (urlParts.length != 2) return false;

      final parameters = urlParts[1].split('|');

      // Online format has 5 parameters
      return parameters.length == 5;
    } catch (e) {
      return false;
    }
  }

  /// Checks if the QR code is from NFC-e 4.0 offline format
  static bool isNfce40Offline(String qrCode) {
    try {
      // Check for basic format first
      if (!qrCode.contains('?p=')) return false;

      // Extract the parameters part after "?p="
      final urlParts = qrCode.split('?p=');
      if (urlParts.length != 2) return false;

      final parameters = urlParts[1].split('|');

      // Offline format has 8 parameters
      return parameters.length == 8;
    } catch (e) {
      return false;
    }
  }

  /// Checks if the QR code is from SAT format
  static bool isSat(String qrCode) {
    try {
      // Split the QR code string by the pipe character
      final parameters = qrCode.split('|');

      // SAT format has either 5 parameters (with CPF/CNPJ) or 4 parameters (without CPF/CNPJ)
      final hasCpfCnpj = parameters.length == 5;
      final noCpfCnpj =
          parameters.length == 4 && parameters[2] != '' && parameters[3] == '';

      return hasCpfCnpj || noCpfCnpj;
    } catch (e) {
      return false;
    }
  }
}
