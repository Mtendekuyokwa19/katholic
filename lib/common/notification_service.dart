import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(settings);
  }

  static Future<void> scheduleDailySaintNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'saint_notification',
          'Saint of the Day',
          channelDescription: 'Daily notification for the saint of the day',
          importance: Importance.max,
          priority: Priority.high,
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final String saintName = _getSaintOfTheDay();

    await _notificationsPlugin.zonedSchedule(
      0,
      'Saint of the Day',
      'Today we celebrate $saintName',
      _nextInstanceOf8AM(),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _nextInstanceOf8AM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      8,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static String _getSaintOfTheDay() {
    // Simple implementation - in a real app, this would fetch from a database or API
    final DateTime now = DateTime.now();
    final List<String> saints = [
      'St. Francis of Assisi',
      'St. Teresa of Ávila',
      'St. Ignatius of Loyola',
      'St. John Paul II',
      'St. Mother Teresa',
      'St. Patrick',
      'St. Augustine',
      'St. Thomas Aquinas',
      'St. Dominic',
      'St. Catherine of Siena',
      // Add more saints as needed
    ];

    // Use day of year to select a saint
    final int dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
    return saints[dayOfYear % saints.length];
  }
}
