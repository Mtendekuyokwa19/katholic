import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:njirayamtanda/constants/app_sizes.dart';
import 'package:njirayamtanda/constants/strings.dart';
import 'package:njirayamtanda/feature_home/functions/readings_fns.dart';
import 'package:njirayamtanda/feature_home/models/catholic_readings_model.dart';
import 'package:njirayamtanda/feature_home/providers/date_on_calender_provider.dart';
import 'package:njirayamtanda/feature_home/widgets/header_section.dart';
import 'package:njirayamtanda/feature_home/widgets/liturgical_day_card.dart';
import 'package:njirayamtanda/feature_home/widgets/reading_card.dart';
import 'package:njirayamtanda/feature_home/widgets/empty_state_widget.dart';
import 'package:njirayamtanda/feature_home/widgets/reading_detail_sheet.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DailyReadings _currentReadings;

  @override
  void initState() {
    super.initState();
    _loadReadings();
  }

  void _loadReadings() {
    var dateProvider = Provider.of<DateOnCalenderProvider>(
      context,
      listen: false,
    );
    setState(() {
      _currentReadings = ReadingsFns().getReadingsbyDate(
        dateProvider.selectedDate,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var dateProvider = Provider.of<DateOnCalenderProvider>(context);
    final colors = context.theme.colors;

    _currentReadings = ReadingsFns().getReadingsbyDate(
      dateProvider.selectedDate,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderSection(colors: colors),
          const SizedBox(height: 24),
          _buildCalendarSection(context, dateProvider),
          const SizedBox(height: 24),
          LiturgicalDayCard(readings: _currentReadings, colors: colors),
          const SizedBox(height: 24),
          _buildReadingsSection(colors),
        ],
      ),
    );
  }

  Widget _buildCalendarSection(
    BuildContext context,
    DateOnCalenderProvider dateProvider,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
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

  Widget _buildReadingsSection(FColors colors) {
    if (_currentReadings.readings.isEmpty) {
      return EmptyStateWidget(colors: colors);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildReadingsHeader(colors),
        const SizedBox(height: 12),
        ..._currentReadings.readings.map(
          (reading) => ReadingCard(
            reading: reading,
            colors: colors,
            onTap: () => _showReadingDetail(context, reading),
          ),
        ),
      ],
    );
  }

  Widget _buildReadingsHeader(FColors colors) {
    return Row(
      children: [
        Text(
          Strings.readings,
          style: TextStyle(
            fontSize: AppSizes.heading4,
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: colors.primary.withAlpha(25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${_currentReadings.readings.length}',
            style: TextStyle(
              fontSize: AppSizes.bodyText,
              fontWeight: FontWeight.w600,
              color: colors.primary,
            ),
          ),
        ),
      ],
    );
  }

  void _showReadingDetail(BuildContext context, Reading reading) {
    final colors = context.theme.colors;

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (context) =>
          ReadingDetailSheet(reading: reading, colors: colors),
    );
  }
}
