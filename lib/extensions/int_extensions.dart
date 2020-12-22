extension ConvertExtension on int {
  DateTime get dateFromUnix {
    var date = DateTime(1970, 1, 1, 0, 0, 0, 0).add(Duration(seconds: this));
    // return DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return date;
  }
}
