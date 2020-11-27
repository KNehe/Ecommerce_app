import 'package:intl/intl.dart';

class DateUtils {
  String getFormattedDate(String timestmapWithMillis) {
    var dateTime =
        new DateFormat("yyyy-MM-dd HH:mm:ss").parse(timestmapWithMillis);

    return dateTime.day.toString() +
        "-" +
        dateTime.month.toString() +
        "-" +
        dateTime.year.toString() +
        "  " +
        dateTime.hour.toString() +
        ":" +
        dateTime.minute.toString() +
        ":" +
        dateTime.second.toString();
  }
}
