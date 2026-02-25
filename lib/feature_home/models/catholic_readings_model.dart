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

  DailyReadings({
    required this.date,
    this.liturgicalDay,
    required this.readings,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'liturgical_day': liturgicalDay,
      'readings': readings.map((e) => e.toJson()).toList(),
    };
  }
}
