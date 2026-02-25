import 'dart:convert';

class Mass {
  final int? id;
  final String eventKey;
  final int eventIdx;
  final String name;
  final String color;
  final String colorLcl;
  final int grade;
  final String gradeLcl;
  final String gradeAbbr;
  final String? gradeDisplay;
  final String common;
  final String commonLcl;
  final String type;
  final String date;
  final int year;
  final int month;
  final int day;
  final String? firstReading;
  final String? firstReadingText;
  final String? responsorialPsalm;
  final String? responsorialPsalmText;
  final String? secondReading;
  final String? secondReadingText;
  final String? gospelAcclamation;
  final String? gospelAcclamationText;
  final String? gospel;
  final String? gospelText;
  final String? liturgicalYear;
  final bool isVigilMass;
  final String? isVigilFor;
  final int psalterWeek;
  final String liturgicalSeason;
  final String liturgicalSeasonLcl;
  final bool holyDayOfObligation;
  final bool hasVigilMass;
  final bool hasVesperI;
  final bool hasVesperIi;
  final int dayOfTheWeekIso8601;
  final String dayOfTheWeekShort;
  final String dayOfTheWeekLong;
  final String monthShort;
  final String monthLong;

  Mass({
    this.id,
    required this.eventKey,
    required this.eventIdx,
    required this.name,
    required this.color,
    required this.colorLcl,
    required this.grade,
    required this.gradeLcl,
    required this.gradeAbbr,
    this.gradeDisplay,
    required this.common,
    required this.commonLcl,
    required this.type,
    required this.date,
    required this.year,
    required this.month,
    required this.day,
    this.firstReading,
    this.firstReadingText,
    this.responsorialPsalm,
    this.responsorialPsalmText,
    this.secondReading,
    this.secondReadingText,
    this.gospelAcclamation,
    this.gospelAcclamationText,
    this.gospel,
    this.gospelText,
    this.liturgicalYear,
    required this.isVigilMass,
    this.isVigilFor,
    required this.psalterWeek,
    required this.liturgicalSeason,
    required this.liturgicalSeasonLcl,
    required this.holyDayOfObligation,
    required this.hasVigilMass,
    required this.hasVesperI,
    required this.hasVesperIi,
    required this.dayOfTheWeekIso8601,
    required this.dayOfTheWeekShort,
    required this.dayOfTheWeekLong,
    required this.monthShort,
    required this.monthLong,
  });

  factory Mass.fromJson(Map<String, dynamic> json) {
    List<String> colorList = [];
    if (json['color'] != null) {
      colorList = List<String>.from(json['color']);
    }
    List<String> colorLclList = [];
    if (json['color_lcl'] != null) {
      colorLclList = List<String>.from(json['color_lcl']);
    }
    List<String> commonList = [];
    if (json['common'] != null) {
      commonList = List<String>.from(json['common']);
    }

    String? firstReading;
    String? responsorialPsalm;
    String? secondReading;
    String? gospelAcclamation;
    String? gospel;

    if (json['readings'] != null) {
      final readings = json['readings'];
      if (readings is Map) {
        if (readings['first_reading'] != null) {
          firstReading = readings['first_reading'];
        }
        if (readings['responsorial_psalm'] != null) {
          responsorialPsalm = readings['responsorial_psalm'];
        }
        if (readings['second_reading'] != null) {
          secondReading = readings['second_reading'];
        }
        if (readings['gospel_acclamation'] != null) {
          gospelAcclamation = readings['gospel_acclamation'];
        }
        if (readings['gospel'] != null) {
          gospel = readings['gospel'];
        }
      }
    }

    return Mass(
      eventKey: json['event_key'] ?? '',
      eventIdx: json['event_idx'] ?? 0,
      name: json['name'] ?? '',
      color: jsonEncode(colorList),
      colorLcl: jsonEncode(colorLclList),
      grade: json['grade'] ?? 0,
      gradeLcl: json['grade_lcl'] ?? '',
      gradeAbbr: json['grade_abbr'] ?? '',
      gradeDisplay: json['grade_display'],
      common: jsonEncode(commonList),
      commonLcl: json['common_lcl'] ?? '',
      type: json['type'] ?? 'mobile',
      date: json['date'] ?? '',
      year: json['year'] ?? 0,
      month: json['month'] ?? 0,
      day: json['day'] ?? 0,
      firstReading: firstReading,
      firstReadingText: null,
      responsorialPsalm: responsorialPsalm,
      responsorialPsalmText: null,
      secondReading: secondReading,
      secondReadingText: null,
      gospelAcclamation: gospelAcclamation,
      gospelAcclamationText: null,
      gospel: gospel,
      gospelText: null,
      liturgicalYear: json['liturgical_year'],
      isVigilMass: json['is_vigil_mass'] ?? false,
      isVigilFor: json['is_vigil_for'],
      psalterWeek: json['psalter_week'] ?? 0,
      liturgicalSeason: json['liturgical_season'] ?? '',
      liturgicalSeasonLcl: json['liturgical_season_lcl'] ?? '',
      holyDayOfObligation: json['holy_day_of_obligation'] ?? false,
      hasVigilMass: json['has_vigil_mass'] ?? false,
      hasVesperI: json['has_vesper_i'] ?? false,
      hasVesperIi: json['has_vesper_ii'] ?? false,
      dayOfTheWeekIso8601: json['day_of_the_week_iso8601'] ?? 0,
      dayOfTheWeekShort: json['day_of_the_week_short'] ?? '',
      dayOfTheWeekLong: json['day_of_the_week_long'] ?? '',
      monthShort: json['month_short'] ?? '',
      monthLong: json['month_long'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'event_key': eventKey,
      'event_idx': eventIdx,
      'name': name,
      'color': color,
      'color_lcl': colorLcl,
      'grade': grade,
      'grade_lcl': gradeLcl,
      'grade_abbr': gradeAbbr,
      'grade_display': gradeDisplay,
      'common': common,
      'common_lcl': commonLcl,
      'type': type,
      'date': date,
      'year': year,
      'month': month,
      'day': day,
      'first_reading': firstReading,
      'responsorial_psalm': responsorialPsalm,
      'second_reading': secondReading,
      'gospel_acclamation': gospelAcclamation,
      'gospel': gospel,
      'liturgical_year': liturgicalYear,
      'is_vigil_mass': isVigilMass ? 1 : 0,
      'is_vigil_for': isVigilFor,
      'psalter_week': psalterWeek,
      'liturgical_season': liturgicalSeason,
      'liturgical_season_lcl': liturgicalSeasonLcl,
      'holy_day_of_obligation': holyDayOfObligation ? 1 : 0,
      'has_vigil_mass': hasVigilMass ? 1 : 0,
      'has_vesper_i': hasVesperI ? 1 : 0,
      'has_vesper_ii': hasVesperIi ? 1 : 0,
      'day_of_the_week_iso8601': dayOfTheWeekIso8601,
      'day_of_the_week_short': dayOfTheWeekShort,
      'day_of_the_week_long': dayOfTheWeekLong,
      'month_short': monthShort,
      'month_long': monthLong,
    };
  }

  factory Mass.fromMap(Map<String, dynamic> map) {
    return Mass(
      id: map['id'],
      eventKey: map['event_key'] ?? '',
      eventIdx: map['event_idx'] ?? 0,
      name: map['name'] ?? '',
      color: map['color'] ?? '',
      colorLcl: map['color_lcl'] ?? '',
      grade: map['grade'] ?? 0,
      gradeLcl: map['grade_lcl'] ?? '',
      gradeAbbr: map['grade_abbr'] ?? '',
      gradeDisplay: map['grade_display'],
      common: map['common'] ?? '',
      commonLcl: map['common_lcl'] ?? '',
      type: map['type'] ?? 'mobile',
      date: map['date'] ?? '',
      year: map['year'] ?? 0,
      month: map['month'] ?? 0,
      day: map['day'] ?? 0,
      firstReading: map['first_reading'],
      responsorialPsalm: map['responsorial_psalm'],
      secondReading: map['second_reading'],
      gospelAcclamation: map['gospel_acclamation'],
      gospel: map['gospel'],
      liturgicalYear: map['liturgical_year'],
      isVigilMass: map['is_vigil_mass'] == 1,
      isVigilFor: map['is_vigil_for'],
      psalterWeek: map['psalter_week'] ?? 0,
      liturgicalSeason: map['liturgical_season'] ?? '',
      liturgicalSeasonLcl: map['liturgical_season_lcl'] ?? '',
      holyDayOfObligation: map['holy_day_of_obligation'] == 1,
      hasVigilMass: map['has_vigil_mass'] == 1,
      hasVesperI: map['has_vesper_i'] == 1,
      hasVesperIi: map['has_vesper_ii'] == 1,
      dayOfTheWeekIso8601: map['day_of_the_week_iso8601'] ?? 0,
      dayOfTheWeekShort: map['day_of_the_week_short'] ?? '',
      dayOfTheWeekLong: map['day_of_the_week_long'] ?? '',
      monthShort: map['month_short'] ?? '',
      monthLong: map['month_long'] ?? '',
    );
  }
}
