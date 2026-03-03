import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:njirayamtanda/constants/app_constants.dart';
import 'package:njirayamtanda/utilities/date_fns.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_sizes.dart';
import '../../constants/strings.dart';
import '../functions/readings_fns.dart';
import '../models/catholic_readings_model.dart';
import '../providers/date_on_calender_provider.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/reading_detail_sheet.dart';
import '../widgets/vestment_info_widget.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Spacer(),
          Column(
            children: [
              Text(
                '${AppConstants.year} • ${_currentReadings.liturgicalSeason ?? ""}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colors.foreground,
                ),
              ),
              Text(
                _currentReadings.monthLong ?? '',
                style: TextStyle(fontSize: 12, color: colors.mutedForeground),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildLiturgicalDayCard(FColors colors, DateTime date) {
    return Container(
      width: double.infinity,
      height: AppSizes.s150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
        image: const DecorationImage(
          image: AssetImage(AppImages.churchOfEaster),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.overlay),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(AppSizes.s16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.s16),
          gradient: LinearGradient(
            colors: [Colors.transparent, colors.background.withAlpha(200)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              _currentReadings.liturgicalDay ?? Strings.noLiturgicalDay,
              style: TextStyle(
                fontSize: AppSizes.heading3,
                fontWeight: FontWeight.bold,
                color: colors.foreground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFns.formatDateInSundayDec72026(date),
              style: TextStyle(fontSize: 14, color: colors.mutedForeground),
            ),
            const SizedBox(height: 12),
            VestmentInfoWidget(
              colors: colors,
              liturgicalSeason: _currentReadings.liturgicalSeason,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarSection(
    BuildContext context,
    DateOnCalenderProvider dateProvider,
  ) {
    final colors = context.theme.colors;

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
    final iconColor = _getReadingColor(reading.type);

    return GestureDetector(
      onTap: () => _showReadingDetail(context, reading),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getReadingIcon(reading.type),
                    color: iconColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reading.type ?? Strings.reading,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: iconColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        reading.reference ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colors.foreground,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  FIcons.chevronRight,
                  color: colors.mutedForeground,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              reading.text ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: colors.mutedForeground,
              ),
            ),
          ],
        ),
      ),
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

  IconData _getReadingIcon(String? type) {
    switch (type?.toUpperCase()) {
      case 'FIRST READING':
      case 'SECOND READING':
        return FIcons.book;
      case 'RESPONSORIAL PSALM':
        return FIcons.music;
      case 'ALLELUIA':
        return FIcons.star;
      case 'GOSPEL':
        return FIcons.bookOpen;
      default:
        return FIcons.fileText;
    }
  }

  Color _getReadingColor(String? type) {
    switch (type?.toUpperCase()) {
      case 'FIRST READING':
      case 'SECOND READING':
        return AppColors.readingColor;
      case 'RESPONSORIAL PSALM':
        return AppColors.psalmColor;
      case 'ALLELUIA':
        return AppColors.alleluiaColor;
      case 'GOSPEL':
        return AppColors.gospelColor;
      default:
        return AppColors.readingColor;
    }
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
