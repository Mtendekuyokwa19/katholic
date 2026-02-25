import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/mass.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('liturgical_calendar.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE masses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        event_key TEXT NOT NULL,
        event_idx INTEGER NOT NULL,
        name TEXT NOT NULL,
        color TEXT NOT NULL,
        color_lcl TEXT NOT NULL,
        grade INTEGER NOT NULL,
        grade_lcl TEXT NOT NULL,
        grade_abbr TEXT NOT NULL,
        grade_display TEXT,
        common TEXT NOT NULL,
        common_lcl TEXT NOT NULL,
        type TEXT NOT NULL,
        date TEXT NOT NULL,
        year INTEGER NOT NULL,
        month INTEGER NOT NULL,
        day INTEGER NOT NULL,
        first_reading TEXT,
        responsorial_psalm TEXT,
        second_reading TEXT,
        gospel_acclamation TEXT,
        gospel TEXT,
        liturgical_year TEXT,
        is_vigil_mass INTEGER NOT NULL DEFAULT 0,
        is_vigil_for TEXT,
        psalter_week INTEGER NOT NULL DEFAULT 0,
        liturgical_season TEXT NOT NULL,
        liturgical_season_lcl TEXT NOT NULL,
        holy_day_of_obligation INTEGER NOT NULL DEFAULT 0,
        has_vigil_mass INTEGER NOT NULL DEFAULT 0,
        has_vesper_i INTEGER NOT NULL DEFAULT 0,
        has_vesper_ii INTEGER NOT NULL DEFAULT 0,
        day_of_the_week_iso8601 INTEGER NOT NULL DEFAULT 0,
        day_of_the_week_short TEXT NOT NULL,
        day_of_the_week_long TEXT NOT NULL,
        month_short TEXT NOT NULL,
        month_long TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_masses_date ON masses(date)
    ''');

    await db.execute('''
      CREATE INDEX idx_masses_liturgical_season ON masses(liturgical_season)
    ''');

    await db.execute('''
      CREATE INDEX idx_masses_year_month_day ON masses(year, month, day)
    ''');
  }

  Future<int> insertMass(Mass mass) async {
    final db = await database;
    return await db.insert('masses', mass.toMap());
  }

  Future<void> insertMasses(List<Mass> masses) async {
    final db = await database;
    final batch = db.batch();
    for (var mass in masses) {
      batch.insert('masses', mass.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<Mass?> getMassById(int id) async {
    final db = await database;
    final maps = await db.query('masses', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Mass.fromMap(maps.first);
    }
    return null;
  }

  Future<Mass?> getMassByDate(int year, int month, int day) async {
    final db = await database;
    final maps = await db.query(
      'masses',
      where: 'year = ? AND month = ? AND day = ?',
      whereArgs: [year, month, day],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return Mass.fromMap(maps.first);
    }
    return null;
  }

  Future<Mass?> getMassByEventKey(String eventKey) async {
    final db = await database;
    final maps = await db.query(
      'masses',
      where: 'event_key = ?',
      whereArgs: [eventKey],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return Mass.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Mass>> getMassesBySeason(String season) async {
    final db = await database;
    final maps = await db.query(
      'masses',
      where: 'liturgical_season = ?',
      whereArgs: [season],
      orderBy: 'date ASC',
    );

    return maps.map((map) => Mass.fromMap(map)).toList();
  }

  Future<List<Mass>> getMassesByYear(int year) async {
    final db = await database;
    final maps = await db.query(
      'masses',
      where: 'year = ?',
      whereArgs: [year],
      orderBy: 'date ASC',
    );

    return maps.map((map) => Mass.fromMap(map)).toList();
  }

  Future<List<Mass>> getMassesByMonth(int year, int month) async {
    final db = await database;
    final maps = await db.query(
      'masses',
      where: 'year = ? AND month = ?',
      whereArgs: [year, month],
      orderBy: 'day ASC',
    );

    return maps.map((map) => Mass.fromMap(map)).toList();
  }

  Future<List<Mass>> getVigilMasses() async {
    final db = await database;
    final maps = await db.query(
      'masses',
      where: 'is_vigil_mass = 1',
      orderBy: 'date ASC',
    );

    return maps.map((map) => Mass.fromMap(map)).toList();
  }

  Future<List<Mass>> getHolyDaysOfObligation() async {
    final db = await database;
    final maps = await db.query(
      'masses',
      where: 'holy_day_of_obligation = 1',
      orderBy: 'date ASC',
    );

    return maps.map((map) => Mass.fromMap(map)).toList();
  }

  Future<List<Mass>> searchMasses(String query) async {
    final db = await database;
    final maps = await db.query(
      'masses',
      where: 'name LIKE ? OR liturgical_season LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'date ASC',
    );

    return maps.map((map) => Mass.fromMap(map)).toList();
  }

  Future<int> getMassCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM masses');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> updateMass(Mass mass) async {
    final db = await database;
    return await db.update(
      'masses',
      mass.toMap(),
      where: 'id = ?',
      whereArgs: [mass.id],
    );
  }

  Future<int> deleteMass(int id) async {
    final db = await database;
    return await db.delete('masses', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllMasses() async {
    final db = await database;
    await db.delete('masses');
  }

  Future<void> loadFromJson(String jsonString) async {
    final Map<String, dynamic> data = json.decode(jsonString);
    final List<dynamic> litcal = data['litcal'];
    final masses = litcal.map((item) => Mass.fromJson(item)).toList();
    await insertMasses(masses);
  }

  Future<void> loadFromReadings2026Json(String jsonString) async {
    final List<dynamic> data = json.decode(jsonString);
    final masses = data.map((item) => _parseReadings2026Item(item)).toList();
    await insertMasses(masses);
  }

  Mass _parseReadings2026Item(Map<String, dynamic> item) {
    final dateStr = item['date'] as String;
    final parts = dateStr.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);

    String? firstReading;
    String? responsorialPsalm;
    String? secondReading;
    String? gospelAcclamation;
    String? gospel;

    final readings = item['readings'] as List<dynamic>?;
    if (readings != null) {
      for (final reading in readings) {
        final type = reading['type'] as String?;
        final reference = reading['reference'] as String?;
        switch (type) {
          case 'READING':
            if (firstReading == null) {
              firstReading = reference;
            } else {
              secondReading = reference;
            }
            break;
          case 'PSALM':
            responsorialPsalm = reference;
            break;
          case 'ALLELUIA':
            gospelAcclamation = reference;
            break;
          case 'GOSPEL':
            gospel = reference;
            break;
        }
      }
    }

    return Mass(
      eventKey: 'readings_$dateStr',
      eventIdx: year * 10000 + month * 100 + day,
      name: item['liturgical_day'] ?? '',
      color: '["green"]',
      colorLcl: '["green"]',
      grade: 0,
      gradeLcl: 'Ordinary',
      gradeAbbr: 'OM',
      gradeDisplay: '',
      common: '[]',
      commonLcl: '',
      type: 'mobile',
      date: dateStr,
      year: year,
      month: month,
      day: day,
      firstReading: firstReading,
      responsorialPsalm: responsorialPsalm,
      secondReading: secondReading,
      gospelAcclamation: gospelAcclamation,
      gospel: gospel,
      liturgicalYear: null,
      isVigilMass: false,
      psalterWeek: 0,
      liturgicalSeason: 'ORDINARY',
      liturgicalSeasonLcl: 'Ordinary Time',
      holyDayOfObligation: false,
      hasVigilMass: false,
      hasVesperI: false,
      hasVesperIi: false,
      dayOfTheWeekIso8601: DateTime(year, month, day).weekday,
      dayOfTheWeekShort: _getDayShort(DateTime(year, month, day).weekday),
      dayOfTheWeekLong: _getDayLong(DateTime(year, month, day).weekday),
      monthShort: _getMonthShort(month),
      monthLong: _getMonthLong(month),
    );
  }

  String _getDayShort(int weekday) {
    const days = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday];
  }

  String _getDayLong(int weekday) {
    const days = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[weekday];
  }

  String _getMonthShort(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month];
  }

  String _getMonthLong(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month];
  }

  Future<void> close() async {
    final db = await database;
    db.close();
    _database = null;
  }
}
