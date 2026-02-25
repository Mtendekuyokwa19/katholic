import 'package:njirayamtanda/common/database_helper.dart';
import 'package:njirayamtanda/common/models/mass.dart';
import 'package:njirayamtanda/constants/app_json.dart';
import 'package:njirayamtanda/feature_home/models/catholic_readings_model.dart';
import 'package:njirayamtanda/feature_home/models/liturgical_calendar_model.dart';

class ReadingsFns {
  final _dailyReadings = AppJson.catholicReadings2026
      .map((e) => DailyReadings.fromJson(e))
      .toList();
  // final _calendar = LiturgicalCalendar.fromJson(AppJson.liturgicalCalender);

  DailyReadings getReadingsbyDate(DateTime date) {
    final todayReadings = _dailyReadings.where(
      (element) =>
          DateTime.parse(element.date).day == date.day &&
          DateTime.parse(element.date).month == date.month &&
          DateTime.parse(element.date).year == date.year,
    );
    if (todayReadings.isEmpty) {
      return DailyReadings(
        date: date.toIso8601String().split('T').first,
        liturgicalDay: '',
        readings: [],
      );
    }
    return todayReadings.first;
  }
}
