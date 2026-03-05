import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';

class CalenderSection extends StatelessWidget {
  const CalenderSection({super.key, required this.colors});

  final FColors colors;

  @override
  Widget build(BuildContext context) {
    var dateProvider = Provider.of(context, listen: false);
    return Container(
      key: ValueKey(dateProvider.selectedDate.toIso8601String()),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.foreground.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FCard(
        child: FLineCalendar(
          control: .lifted(
            date: dateProvider.selectedDate,
            selectable: (date) => true,
            onChange: (date) {
              if (date != null) {
                dateProvider.setSelectedDate(date);
              }
            },
          ),
          initialScroll: dateProvider.selectedDate,
          initialScrollAlignment: .center,
          cacheExtent: null,
          keyboardDismissBehavior: .manual,
          physics: null,
          start: .utc(2025),
          end: .utc(2027),
          today: .now(),
          builder: (context, data, child) => child!,
        ),
      ),
    );
  }
}
