import 'dart:convert';
import 'package:flutter/services.dart';

class WayOfTheCrossData {
  final Prelude prelude;
  final List<String> divinePraises;
  final String holyGod;
  final String preparatoryPrayer;
  final Benediction benediction;
  final String prayerToJesus;
  final List<Station> stations;

  WayOfTheCrossData({
    required this.prelude,
    required this.divinePraises,
    required this.holyGod,
    required this.preparatoryPrayer,
    required this.benediction,
    required this.prayerToJesus,
    required this.stations,
  });

  factory WayOfTheCrossData.fromJson(Map<String, dynamic> json) {
    return WayOfTheCrossData(
      prelude: Prelude.fromJson(json['prelude']),
      divinePraises: List<String>.from(json['divinePraises']),
      holyGod: json['holyGod'],
      preparatoryPrayer: json['preparatoryPrayer'],
      benediction: Benediction.fromJson(json['benediction']),
      prayerToJesus: json['prayerToJesus'],
      stations: (json['stations'] as List)
          .map((e) => Station.fromJson(e))
          .toList(),
    );
  }

  static Future<WayOfTheCrossData> load() async {
    final jsonString = await rootBundle.loadString(
      'lib/common/models/way_of_the_cross.json',
    );
    final jsonData = json.decode(jsonString);
    return WayOfTheCrossData.fromJson(jsonData);
  }
}

class Prelude {
  final String translationSource;
  final String copyright;
  final String stationLocation;
  final String stationNumber;
  final String plenaryIndulgence;
  final String source;
  final List<String> indulgenceConditions;

  Prelude({
    required this.translationSource,
    required this.copyright,
    required this.stationLocation,
    required this.stationNumber,
    required this.plenaryIndulgence,
    required this.source,
    required this.indulgenceConditions,
  });

  factory Prelude.fromJson(Map<String, dynamic> json) {
    return Prelude(
      translationSource: json['translationSource'],
      copyright: json['copyright'],
      stationLocation: json['stationLocation'],
      stationNumber: json['stationNumber'],
      plenaryIndulgence: json['plenaryIndulgence'],
      source: json['source'],
      indulgenceConditions: List<String>.from(json['indulgenceConditions']),
    );
  }
}

class Benediction {
  final List<SalutarisHostia> salutarisHostia;
  final List<TantumErgo> tantumErgo;
  final BenedictionResponse response;

  Benediction({
    required this.salutarisHostia,
    required this.tantumErgo,
    required this.response,
  });

  factory Benediction.fromJson(Map<String, dynamic> json) {
    return Benediction(
      salutarisHostia: (json['salutarisHostia'] as List)
          .map((e) => SalutarisHostia.fromJson(e))
          .toList(),
      tantumErgo: (json['tantumErgo'] as List)
          .map((e) => TantumErgo.fromJson(e))
          .toList(),
      response: BenedictionResponse.fromJson(json['response']),
    );
  }
}

class SalutarisHostia {
  final String latin;
  final String english;
  final String verse;
  final String refrain;
  final String verseEnd;

  SalutarisHostia({
    required this.latin,
    required this.english,
    required this.verse,
    required this.refrain,
    required this.verseEnd,
  });

  factory SalutarisHostia.fromJson(Map<String, dynamic> json) {
    return SalutarisHostia(
      latin: json['latin'],
      english: json['english'],
      verse: json['verse'],
      refrain: json['refrain'],
      verseEnd: json['verseEnd'],
    );
  }
}

class TantumErgo {
  final String latin;
  final String english;
  final String verse;
  final String refrain;
  final String verseEnd;

  TantumErgo({
    required this.latin,
    required this.english,
    required this.verse,
    required this.refrain,
    required this.verseEnd,
  });

  factory TantumErgo.fromJson(Map<String, dynamic> json) {
    return TantumErgo(
      latin: json['latin'],
      english: json['english'],
      verse: json['verse'],
      refrain: json['refrain'],
      verseEnd: json['verseEnd'],
    );
  }
}

class BenedictionResponse {
  final String verse;
  final String response;
  final String latinVerse;
  final String latinResponse;

  BenedictionResponse({
    required this.verse,
    required this.response,
    required this.latinVerse,
    required this.latinResponse,
  });

  factory BenedictionResponse.fromJson(Map<String, dynamic> json) {
    return BenedictionResponse(
      verse: json['verse'],
      response: json['response'],
      latinVerse: json['latinVerse'],
      latinResponse: json['latinResponse'],
    );
  }
}

class Station {
  final int number;
  final String title;
  final String adoration;
  final String reflection;
  final String prayer;
  final String response;

  Station({
    required this.number,
    required this.title,
    required this.adoration,
    required this.reflection,
    required this.prayer,
    required this.response,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      number: json['number'],
      title: json['title'],
      adoration: json['adoration'],
      reflection: json['reflection'],
      prayer: json['prayer'],
      response: json['response'],
    );
  }
}
