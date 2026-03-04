import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class HomeWidgetProvider extends ChangeNotifier {
  static const String _activityKey = 'reading_activity';
  static const int gridSize = 49; // 7x7 grid

  Future<void> incrementToday() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final activityJson = prefs.getString(_activityKey) ?? '{}';
    final Map<String, int> activityMap = _decodeActivity(activityJson);

    activityMap[today] = (activityMap[today] ?? 0) + 1;

    await prefs.setString(_activityKey, _encodeActivity(activityMap));
    await _updateWidgetData(activityMap);
    notifyListeners();
  }

  Future<List<int>> getActivityGrid() async {
    final prefs = await SharedPreferences.getInstance();
    final activityJson = prefs.getString(_activityKey) ?? '{}';
    final Map<String, int> activityMap = _decodeActivity(activityJson);

    final List<int> grid = [];
    final today = DateTime.now();

    for (int i = gridSize - 1; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      grid.add(activityMap[dateStr] ?? 0);
    }

    return grid;
  }

  Map<String, int> _decodeActivity(String activityJson) {
    try {
      final Map<String, dynamic> decoded = json.decode(activityJson);
      return decoded.map((key, value) => MapEntry(key, value as int));
    } catch (e) {
      return {};
    }
  }

  String _encodeActivity(Map<String, int> activityMap) {
    return json.encode(activityMap);
  }

  Future<void> _updateWidgetData(Map<String, int> activityMap) async {
    await HomeWidget.saveWidgetData(
      'activity_data',
      _encodeActivity(activityMap),
    );
    await HomeWidget.updateWidget(
      name: 'CatholicReadingWidget',
      androidName: 'CatholicReadingWidget',
    );
  }
}
