import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:katholic/feature_home/widgets/calender_section_wid.dart';
import 'package:katholic/feature_home/widgets/header_home_wid.dart';
import 'package:katholic/feature_home/widgets/liturgy_card_wid.dart';
import 'package:provider/provider.dart';

import '../../constants/app_sizes.dart';
import '../../constants/strings.dart';
import '../../common/providers/home_widget_provider.dart';
import '../functions/readings_fns.dart';
import '../models/catholic_readings_model.dart';
import '../providers/date_on_calender_provider.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/reading_detail_sheet.dart';
import '../widgets/reading_item_widget.dart';

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

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(colors),
              Padding(
                padding: EdgeInsets.all(AppSizes.s1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLiturgicalDayCard(colors, dateProvider.selectedDate),
                    SizedBox(height: AppSizes.s12),
                    _buildCalendarSection(context, dateProvider),
                    const SizedBox(height: 24),
                    _buildReadingsSection(colors),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(FColors colors) {
    return HeaderHomeWid(currentReadings: _currentReadings);
  }

  Widget _buildLiturgicalDayCard(FColors colors, DateTime date) {
    return LiturgycardDay(currentReadings: _currentReadings, date: date);
  }

  Widget _buildCalendarSection(
    BuildContext context,
    DateOnCalenderProvider dateProvider,
  ) {
    final colors = context.theme.colors;

    return CalenderSection(colors: colors);
  }

  Widget _buildReadingsSection(FColors colors) {
    if (_currentReadings.readings.isEmpty) {
      return EmptyStateWidget(colors: colors);
    }

    final orderedReadings = _orderReadings(_currentReadings.readings);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(FIcons.book, color: colors.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              Strings.liturgyOfTheWord,
              style: TextStyle(
                fontSize: AppSizes.heading4,
                fontWeight: FontWeight.bold,
                color: colors.foreground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...orderedReadings.asMap().entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildReadingItem(
              colors,
              _createDisplayReading(entry.value, entry.key),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReadingItem(FColors colors, Reading reading) {
    return ReadingItemWidget(
      reading: reading,
      colors: colors,
      onTap: () => _showReadingDetail(context, reading),
    );
  }

  List<Reading> _orderReadings(List<Reading> readings) {
    final ordered = <Reading>[];
    Reading? firstReading;
    Reading? psalm;
    Reading? secondReading;
    Reading? alleluia;
    Reading? gospel;

    for (final r in readings) {
      final type = r.type?.toUpperCase();
      if (type == 'READING' && firstReading == null) {
        firstReading = r;
      } else if (type == 'PSALM') {
        psalm = r;
      } else if (type == 'READING' && firstReading != null) {
        secondReading = r;
      } else if (type == 'ALLELUIA') {
        alleluia = r;
      } else if (type == 'GOSPEL') {
        gospel = r;
      }
    }

    if (firstReading != null) ordered.add(firstReading);
    if (psalm != null) ordered.add(psalm);
    if (secondReading != null) ordered.add(secondReading);
    if (alleluia != null) ordered.add(alleluia);
    if (gospel != null) ordered.add(gospel);

    return ordered;
  }

  Reading _createDisplayReading(Reading reading, int index) {
    String? displayType;
    final type = reading.type?.toUpperCase();

    if (type == 'READING') {
      displayType = index == 0 ? Strings.firstReading : Strings.secondReading;
    } else if (type == 'PSALM') {
      displayType = Strings.responsorialPsalm;
    } else if (type == 'ALLELUIA') {
      displayType = Strings.alleluia;
    } else if (type == 'GOSPEL') {
      displayType = Strings.gospel;
    }

    return Reading(
      type: displayType,
      reference: reading.reference,
      text: reading.text,
    );
  }

  void _showReadingDetail(BuildContext context, Reading reading) {
    final colors = context.theme.colors;

    // Track reading activity for home widget
    final homeWidgetProvider = Provider.of<HomeWidgetProvider>(
      context,
      listen: false,
    );
    homeWidgetProvider.incrementToday();

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
