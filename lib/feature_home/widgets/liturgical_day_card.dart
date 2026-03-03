import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:njirayamtanda/constants/app_images.dart';
import 'package:njirayamtanda/constants/app_sizes.dart';
import 'package:njirayamtanda/constants/strings.dart';
import 'package:njirayamtanda/feature_home/models/catholic_readings_model.dart';
import 'package:njirayamtanda/feature_home/providers/date_on_calender_provider.dart';
import 'package:njirayamtanda/utilities/date_fns.dart';
import 'package:provider/provider.dart';

class LiturgicalDayCard extends StatelessWidget {
  final DailyReadings readings;
  final FColors colors;

  const LiturgicalDayCard({
    super.key,
    required this.readings,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage(AppImages.churchOfEaster),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withAlpha(120)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabelRow(),
            const SizedBox(height: 12),
            _buildLiturgicalDayText(),
            const SizedBox(height: 8),
            _buildDateRow(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelRow() {
    return Row(
      children: [
        Icon(FIcons.sparkles, color: Colors.white, size: 20),
        const SizedBox(width: 10),
        Text(
          Strings.liturgicalDay,
          style: TextStyle(
            fontSize: AppSizes.bodyText,
            fontWeight: FontWeight.w600,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _buildLiturgicalDayText() {
    return Text(
      readings.liturgicalDay ?? Strings.noLiturgicalDay,
      style: TextStyle(
        fontSize: AppSizes.heading3,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildDateRow(BuildContext context) {
    return Row(
      children: [
        Icon(FIcons.calendar, color: Colors.white.withAlpha(200), size: 14),
        const SizedBox(width: 6),
        Text(
          DateFns.formatDateInSundayDec72026(
            Provider.of<DateOnCalenderProvider>(context).selectedDate,
          ),
          style: TextStyle(
            fontSize: AppSizes.bodyText,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }
}
