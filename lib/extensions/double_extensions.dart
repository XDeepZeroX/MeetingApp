extension ConvertExtension on double {
  String get toStringTrillingZeros =>
      this.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
}
