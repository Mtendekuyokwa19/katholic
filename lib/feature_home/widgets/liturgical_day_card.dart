import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:njirayamtanda/constants/app_colors.dart';
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.softGold.withAlpha(60),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gold.withAlpha(80), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabelRow(),
          const SizedBox(height: 8),
          _buildLiturgicalDayText(),
          const SizedBox(height: 6),
          _buildDateRow(context),
        ],
      ),
    );
  }

  Widget _buildLabelRow() {
    return Row(
      children: [
        Icon(FIcons.sparkles, color: AppColors.gold, size: 18),
        const SizedBox(width: 8),
        Text(
          Strings.liturgicalDay,
          style: TextStyle(
            fontSize: AppSizes.bodyText,
            fontWeight: FontWeight.w600,
            color: colors.mutedForeground,
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
        color: colors.primary,
      ),
    );
  }

  Widget _buildDateRow(BuildContext context) {
    return Row(
      children: [
        Icon(FIcons.calendar, color: colors.mutedForeground, size: 14),
        const SizedBox(width: 6),
        Text(
          DateFns.formatDateInSundayDec72026(
            Provider.of<DateOnCalenderProvider>(context).selectedDate,
          ),
          style: TextStyle(
            fontSize: AppSizes.bodyText,
            color: colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}
