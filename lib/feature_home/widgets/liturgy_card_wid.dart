import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:katholic/constants/app_images.dart';
import 'package:katholic/constants/app_sizes.dart';
import 'package:katholic/constants/strings.dart';
import 'package:katholic/feature_home/models/catholic_readings_model.dart';
import 'package:katholic/feature_home/widgets/vestment_info_widget.dart';
import 'package:katholic/utilities/date_fns.dart';

class LiturgycardDay extends StatelessWidget {
  const LiturgycardDay({
    super.key,
    required DailyReadings currentReadings,
    required this.date,
  }) : _currentReadings = currentReadings;

  final DailyReadings _currentReadings;

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    var colors = context.theme.colors;
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
            colors: [Colors.transparent, Colors.black54.withAlpha(200)],
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
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFns.formatDateInSundayDec72026(date),
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            VestmentInfoWidget(colors: colors),
          ],
        ),
      ),
    );
  }
}
