class Reading {
  final String? type;
  final String? reference;
  final String? text;

  Reading({this.type, this.reference, this.text});

  factory Reading.fromJson(Map<String, dynamic> json) {
    return Reading(
      type: json['type'] as String?,
      reference: json['reference'] as String?,
      text: json['text'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'reference': reference, 'text': text};
  }
}

class DailyReadings {
  final String date;
  final String? liturgicalDay;
  final List<Reading> readings;
  final String? liturgicalYear;
  final String? liturgicalSeason;
  final String? monthLong;

  DailyReadings({
    required this.date,
    this.liturgicalDay,
    required this.readings,
    this.liturgicalYear,
    this.liturgicalSeason,
    this.monthLong,
  });

  factory DailyReadings.fromJson(Map<String, dynamic> json) {
    return DailyReadings(
      date: json['date'] as String? ?? '',
      liturgicalDay: json['liturgical_day'] as String?,
      readings:
          (json['readings'] as List<dynamic>?)
              ?.map((e) => Reading.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      liturgicalYear: json['liturgical_year'] as String?,
      liturgicalSeason: json['liturgical_season'] as String?,
      monthLong: json['month_long'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'liturgical_day': liturgicalDay,
      'readings': readings.map((e) => e.toJson()).toList(),
      'liturgical_year': liturgicalYear,
      'liturgical_season': liturgicalSeason,
      'month_long': monthLong,
    };
  }
}
