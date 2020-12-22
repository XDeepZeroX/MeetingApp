import 'package:intl/intl.dart';

extension ConvertExtension on DateTime {
  int get unix {
    var res = (this.millisecondsSinceEpoch / 1000).floor(); // as int;
    return res + this.timeZoneOffset.inSeconds; //To UTC
  }

  DateTime get getOnlyDate => DateTime(this.year, this.month, this.day);
  String get getStrOnlyTime => DateFormat('HH:mm').format(this);
  int get getUtcUnix => this.toUtc().unix;
  String get getStrOnlyDate => DateFormat("dd.MM.yyyy").format(this);

  String toFormat(String format) => DateFormat(format).format(this);
}
