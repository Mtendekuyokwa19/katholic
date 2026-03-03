class LiturgicalReadings {
  final String? firstReading;
  final String? responsorialPsalm;
  final String? secondReading;
  final String? gospelAcclamation;
  final String? gospel;

  LiturgicalReadings({
    this.firstReading,
    this.responsorialPsalm,
    this.secondReading,
    this.gospelAcclamation,
    this.gospel,
  });

  factory LiturgicalReadings.fromJson(Map<String, dynamic> json) {
    return LiturgicalReadings(
      firstReading: json['first_reading'] as String?,
      responsorialPsalm: json['responsorial_psalm'] as String?,
      secondReading: json['second_reading'] as String?,
      gospelAcclamation: json['gospel_acclamation'] as String?,
      gospel: json['gospel'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_reading': firstReading,
      'responsorial_psalm': responsorialPsalm,
      'second_reading': secondReading,
      'gospel_acclamation': gospelAcclamation,
      'gospel': gospel,
    };
  }
}

class LiturgicalEvent {
  final String eventKey;
  final int eventIdx;
  final String name;
  final List<String> color;
  final List<String> colorLcl;
  final int grade;
  final String gradeLcl;
  final String gradeAbbr;
  final String? gradeDisplay;
  final List<String> common;
  final String commonLcl;
  final String type;
  final String date;
  final int year;
  final int month;
  final String monthShort;
  final String monthLong;
  final int day;
  final int dayOfTheWeekIso8601;
  final String dayOfTheWeekShort;
  final String dayOfTheWeekLong;
  final LiturgicalReadings readings;
  final String? liturgicalYear;
  final bool? isVigilMass;
  final String? isVigilFor;
  final bool? hasVigilMass;
  final bool? hasVesperI;
  final bool? hasVesperIi;
  final int? psalterWeek;
  final String liturgicalSeason;
  final String liturgicalSeasonLcl;

  LiturgicalEvent({
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
    required this.monthShort,
    required this.monthLong,
    required this.day,
    required this.dayOfTheWeekIso8601,
    required this.dayOfTheWeekShort,
    required this.dayOfTheWeekLong,
    required this.readings,
    required this.liturgicalYear,
    this.isVigilMass,
    this.isVigilFor,
    this.hasVigilMass,
    this.hasVesperI,
    this.hasVesperIi,
    this.psalterWeek,
    required this.liturgicalSeason,
    required this.liturgicalSeasonLcl,
  });

  factory LiturgicalEvent.fromJson(Map<String, dynamic> json) {
    return LiturgicalEvent(
      eventKey: json['event_key'] as String,
      eventIdx: json['event_idx'] as int,
      name: json['name'] as String,
      color: (json['color'] as List<dynamic>).map((e) => e as String).toList(),
      colorLcl: (json['color_lcl'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      grade: json['grade'] as int,
      gradeLcl: json['grade_lcl'] as String,
      gradeAbbr: json['grade_abbr'] as String,
      gradeDisplay: json['grade_display'] as String?,
      common: (json['common'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      commonLcl: json['common_lcl'] as String,
      type: json['type'] as String,
      date: json['date'] as String,
      year: json['year'] as int,
      month: json['month'] as int,
      monthShort: json['month_short'] as String,
      monthLong: json['month_long'] as String,
      day: json['day'] as int,
      dayOfTheWeekIso8601: json['day_of_the_week_iso8601'] as int,
      dayOfTheWeekShort: json['day_of_the_week_short'] as String,
      dayOfTheWeekLong: json['day_of_the_week_long'] as String,
      readings: json['readings'] is Map<String, dynamic>
          ? LiturgicalReadings.fromJson(
              json['readings'] as Map<String, dynamic>,
            )
          : LiturgicalReadings(
              firstReading: null,
              responsorialPsalm: null,
              secondReading: null,
              gospelAcclamation: null,
              gospel: null,
            ),
      liturgicalYear: json['liturgical_year'] as String?,
      isVigilMass: json['is_vigil_mass'] as bool?,
      isVigilFor: json['is_vigil_for'] as String?,
      hasVigilMass: json['has_vigil_mass'] as bool?,
      hasVesperI: json['has_vesper_i'] as bool?,
      hasVesperIi: json['has_vesper_ii'] as bool?,
      psalterWeek: json['psalter_week'] as int?,
      liturgicalSeason: json['liturgical_season'] as String,
      liturgicalSeasonLcl: json['liturgical_season_lcl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'month_short': monthShort,
      'month_long': monthLong,
      'day': day,
      'day_of_the_week_iso8601': dayOfTheWeekIso8601,
      'day_of_the_week_short': dayOfTheWeekShort,
      'day_of_the_week_long': dayOfTheWeekLong,
      'readings': readings.toJson(),
      'liturgical_year': liturgicalYear,
      'is_vigil_mass': isVigilMass,
      'is_vigil_for': isVigilFor,
      'has_vigil_mass': hasVigilMass,
      'has_vesper_i': hasVesperI,
      'has_vesper_ii': hasVesperIi,
      'psalter_week': psalterWeek,
      'liturgical_season': liturgicalSeason,
      'liturgical_season_lcl': liturgicalSeasonLcl,
    };
  }
}

class LiturgicalCalendar {
  final List<LiturgicalEvent> litcal;

  LiturgicalCalendar({required this.litcal});

  factory LiturgicalCalendar.fromJson(Map<String, dynamic> json) {
    return LiturgicalCalendar(
      litcal: (json['litcal'] as List<dynamic>)
          .map((e) => LiturgicalEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'litcal': litcal.map((e) => e.toJson()).toList()};
  }
}
