import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class DateWid extends StatelessWidget {
  const DateWid({super.key});

  @override
  Widget build(BuildContext context) {
    return FLineCalendar(
      control: .lifted(
        date: .now(),
        selectable: (date) => true,
        onChange: (date) {},
      ),
      initialScroll: .now(),
      initialScrollAlignment: .center,
      cacheExtent: null,
      keyboardDismissBehavior: .manual,
      physics: null,
      start: .utc(1900),
      end: .utc(2100),
      today: .now(),
      builder: (context, data, child) => child!,
    );
  }
}
