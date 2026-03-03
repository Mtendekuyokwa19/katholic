import 'package:njirayamtanda/constants/app_json.dart';
import 'package:njirayamtanda/feature_home/models/catholic_readings_model.dart';
import 'package:njirayamtanda/feature_home/models/liturgical_calendar_model.dart';

class ReadingsFns {
  final _dailyReadings = AppJson.catholicReadings2026
      .map((e) => DailyReadings.fromJson(e))
      .toList();
  final _calendar = LiturgicalCalendar.fromJson(AppJson.liturgicalCalender);

  DailyReadings getReadingsbyDate(DateTime date) {
    final todayReadings = _dailyReadings.where(
      (element) =>
          DateTime.parse(element.date).day == date.day &&
          DateTime.parse(element.date).month == date.month &&
          DateTime.parse(element.date).year == date.year,
    );

    final calendarEvents = _calendar.litcal.where(
      (element) =>
          element.day == date.day &&
          element.month == date.month &&
          element.year == date.year,
    );

    String? liturgicalYear;
    String? liturgicalSeason;
    String? monthLong;

    if (calendarEvents.isNotEmpty) {
      final event = calendarEvents.first;
      liturgicalYear = event.liturgicalYear;
      liturgicalSeason = event.liturgicalSeason;
      monthLong = event.monthLong;
    }

    if (todayReadings.isEmpty) {
      return DailyReadings(
        date: date.toIso8601String().split('T').first,
        liturgicalDay: '',
        readings: [],
        liturgicalYear: liturgicalYear,
        liturgicalSeason: liturgicalSeason,
        monthLong: monthLong,
      );
    }

    final readings = todayReadings.first;
    return DailyReadings(
      date: readings.date,
      liturgicalDay: readings.liturgicalDay,
      readings: readings.readings,
      liturgicalYear: liturgicalYear,
      liturgicalSeason: liturgicalSeason,
      monthLong: monthLong,
    );
  }
}
