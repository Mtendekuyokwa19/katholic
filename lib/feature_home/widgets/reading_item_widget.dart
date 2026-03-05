import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../constants/app_colors.dart';
import '../../constants/strings.dart';
import '../models/catholic_readings_model.dart';

class ReadingItemWidget extends StatelessWidget {
  const ReadingItemWidget({
    super.key,
    required this.reading,
    required this.colors,
    required this.onTap,
  });

  final Reading reading;
  final FColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = _getReadingColor(reading.type);

    return GestureDetector(
      onTap: onTap,
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
}
