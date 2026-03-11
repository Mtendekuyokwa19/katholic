import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class DateWid extends StatelessWidget {
  const DateWid({super.key});

  @override
  Widget build(BuildContext context) {
    return FLineCalendar(
      control: FLineCalendarControl.lifted(
        date: DateTime.now(),
        selectable: (date) => true,
        onChange: (date) {},
      ),
      start: DateTime.utc(1900),
      end: DateTime.utc(2100),
      today: DateTime.now(),
      builder: (context, data, child) => child!,
    );
  }
}
