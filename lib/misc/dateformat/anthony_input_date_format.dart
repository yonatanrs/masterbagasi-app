import 'package:intl/intl.dart';

import '../date_util.dart';

class AnthonyInputDateFormat extends DateFormat {
  @override
  DateTime parse(String inputString, [bool utc = false]) {
    String newDateTime = inputString.substring(0, 10) + ' ' + inputString.substring(11, 19);
    return DateUtil.standardDateFormat.parse(newDateTime);
  }

  @override
  String format(DateTime date) {
    throw UnimplementedError("This format is not implemented for temporary");
  }
}