extension CapExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  bool get isEmptyOrNull => this?.isEmpty ?? true;
}
