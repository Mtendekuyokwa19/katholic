import 'package:intl/intl.dart';

class DateFns {
  static String formatDateInSundayDec72026(DateTime date) {
    String formattedDate = DateFormat('EEEE,MMM d,y').format(date);
    return formattedDate;
  }
}
