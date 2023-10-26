import 'package:intl/intl.dart';

import 'dateformat/anthony_input_date_format.dart';

class _DateUtilImpl {
  DateFormat standardDateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateFormat standardDateFormat2 = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'");
  DateFormat standardDateFormat3 = DateFormat("yyyy-MM-dd");
  DateFormat standardDateFormat4 = DateFormat("dd MMMM yyyy");
  DateFormat standardDateFormat5 = DateFormat("MMMM yyyy");
  DateFormat standardDateFormat6 = DateFormat("dd MMMM yyyy HH:mm:ss");
  DateFormat standardDateFormat7 = DateFormat("dd MMM yyyy");
  DateFormat standardDateFormat8 = DateFormat("dd MMM yyyy HH:mm:ss");
  DateFormat standardDateFormat9 = DateFormat("dd MMM");
  DateFormat standardTimeFormat = DateFormat("HH:mm:ss");
  DateFormat standardHourMinuteTimeFormat = DateFormat("HH:mm");
  DateFormat anthonyInputDateFormat = AnthonyInputDateFormat();

  String formatDateBasedTodayOrNot(DateTime? willBeFormatting) {
    return willBeFormatting == null ? "(Empty)" : (
      willBeFormatting == DateTime.now() ? standardHourMinuteTimeFormat.format(willBeFormatting) : standardDateFormat4.format(willBeFormatting)
    );
  }
}

// ignore: non_constant_identifier_names
var DateUtil = _DateUtilImpl();