extension StringExtension on String? {
  int get toInt => int.tryParse(this ?? '0') ?? 0;

  String get removeWhiteSpace => this?.replaceAll(RegExp(r'\s'), '') ?? '';
}
