import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:katholic/constants/app_constants.dart';
import 'package:katholic/feature_home/models/catholic_readings_model.dart';

class HeaderHomeWid extends StatelessWidget {
  const HeaderHomeWid({super.key, required DailyReadings currentReadings})
    : _currentReadings = currentReadings;

  final DailyReadings _currentReadings;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
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
}
