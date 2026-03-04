import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:njirayamtanda/constants/strings.dart';
import 'package:provider/provider.dart';
import '../providers/date_on_calender_provider.dart';

enum LiturgicalColor { green, purple, white, red, rose }

class LiturgicalCalendar {
  /// Calculates the date of Easter Sunday for a given year
  static DateTime getEaster(int year) {
    int a = year % 19;
    int b = year ~/ 100;
    int c = year % 100;
    int d = b ~/ 4;
    int e = b % 4;
    int f = (b + 8) ~/ 25;
    int g = (b - f + 1) ~/ 3;
    int h = (19 * a + b - d - g + 15) % 30;
    int i = c ~/ 4;
    int k = c % 4;
    int l = (32 + 2 * e + 2 * i - h - k) % 7;
    int m = (a + 11 * h + 22 * l) ~/ 451;
    int month = (h + l - 7 * m + 114) ~/ 31;
    int day = ((h + l - 7 * m + 114) % 31) + 1;
    return DateTime(year, month, day);
  }

  static LiturgicalColor getColor(DateTime date) {
    int year = date.year;
    DateTime easter = getEaster(year);

    // --- Fixed Seasons (Advent & Christmas) ---
    // Advent starts 4 Sundays before Christmas
    DateTime christmas = DateTime(year, 12, 25);
    int daysToFirstSundayAdvent = (christmas.weekday == DateTime.sunday)
        ? 28
        : christmas.weekday + 21;
    DateTime adventStart = christmas.subtract(
      Duration(days: daysToFirstSundayAdvent),
    );

    // Rose Sunday (Gaudete) is the 3rd Sunday of Advent
    DateTime gaudeteSunday = adventStart.add(Duration(days: 14));

    if (date.isAfter(adventStart.subtract(Duration(days: 1))) &&
        date.isBefore(christmas)) {
      if (date.year == gaudeteSunday.year &&
          date.month == gaudeteSunday.month &&
          date.day == gaudeteSunday.day) {
        return LiturgicalColor.rose;
      }
      return LiturgicalColor.purple;
    }

    // Christmas Season (Dec 25 to Baptism of the Lord - approx Jan 13)
    if (date.isAfter(christmas.subtract(Duration(days: 1))) ||
        date.isBefore(DateTime(year, 1, 13))) {
      return LiturgicalColor.white;
    }

    // --- Movable Seasons (Lent & Easter) ---
    DateTime ashWednesday = easter.subtract(Duration(days: 46));
    DateTime pentecost = easter.add(Duration(days: 49));
    DateTime palmSunday = easter.subtract(Duration(days: 7));
    DateTime goodFriday = easter.subtract(Duration(days: 2));
    DateTime laetareSunday = easter.subtract(
      Duration(days: 21),
    ); // 4th Sunday of Lent

    // Lent
    if (date.isAfter(ashWednesday.subtract(Duration(days: 1))) &&
        date.isBefore(easter)) {
      if (date.isAtSameMomentAs(palmSunday) ||
          date.isAtSameMomentAs(goodFriday)) {
        return LiturgicalColor.red;
      }
      if (date.isAtSameMomentAs(laetareSunday)) return LiturgicalColor.rose;
      return LiturgicalColor.purple;
    }

    // Easter Season
    if (date.isAfter(easter.subtract(Duration(days: 1))) &&
        date.isBefore(pentecost.add(Duration(days: 1)))) {
      if (date.isAtSameMomentAs(pentecost)) return LiturgicalColor.red;
      return LiturgicalColor.white;
    }

    // Default: Ordinary Time
    return LiturgicalColor.green;
  }
}

class VestmentInfoWidget extends StatelessWidget {
  final FColors colors;
  final String? liturgicalSeason;

  const VestmentInfoWidget({
    super.key,
    required this.colors,
    this.liturgicalSeason,
  });

  Color _getDisplayColor(LiturgicalColor liturgicalColor) {
    switch (liturgicalColor) {
      case LiturgicalColor.green:
        return Colors.green;
      case LiturgicalColor.purple:
        return Colors.purple;
      case LiturgicalColor.white:
        return Colors.white;
      case LiturgicalColor.red:
        return Colors.red;
      case LiturgicalColor.rose:
        return Colors.pinkAccent; // or Colors.rose if available
    }
  }

  String _getVestmentText(LiturgicalColor liturgicalColor) {
    switch (liturgicalColor) {
      case LiturgicalColor.green:
        return Strings.greenVestments;
      case LiturgicalColor.purple:
        return Strings.purpleVestments;
      case LiturgicalColor.white:
        return Strings.whiteVestments;
      case LiturgicalColor.red:
        return Strings.redVestments;
      case LiturgicalColor.rose:
        return Strings.roseVestments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DateOnCalenderProvider>(
      builder: (context, dateProvider, child) {
        final selectedDate = dateProvider.selectedDate;
        final liturgicalColor = LiturgicalCalendar.getColor(selectedDate);
        final displayColor = _getDisplayColor(liturgicalColor);
        final vestmentText = _getVestmentText(liturgicalColor);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: colors.primary.withAlpha(25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: displayColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                liturgicalSeason ?? Strings.solemnity,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                vestmentText,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }
}
