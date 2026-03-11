import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';
import '../providers/date_on_calender_provider.dart';

class CalenderSection extends StatelessWidget {
  const CalenderSection({super.key, required this.colors});

  final FColors colors;

  @override
  Widget build(BuildContext context) {
    var dateProvider = Provider.of<DateOnCalenderProvider>(
      context,
      listen: false,
    );
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
          control: FLineCalendarControl.lifted(
            date: dateProvider.selectedDate,
            selectable: (date) => true,
            onChange: (date) {
              if (date != null) {
                dateProvider.setSelectedDate(date);
              }
            },
          ),
          start: DateTime.utc(2025),
          end: DateTime.utc(2027),
          today: DateTime.now(),
          builder: (context, data, child) => child!,
        ),
      ),
    );
  }
}
