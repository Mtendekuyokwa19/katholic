import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:njirayamtanda/constants/app_colors.dart';
import 'package:njirayamtanda/constants/app_sizes.dart';
import 'package:njirayamtanda/constants/strings.dart';
import 'package:njirayamtanda/feature_home/models/catholic_readings_model.dart';

class ReadingCard extends StatelessWidget {
  final Reading reading;
  final FColors colors;
  final VoidCallback onTap;

  const ReadingCard({
    super.key,
    required this.reading,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = _getReadingColor(reading.type);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: FCard(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIconContainer(iconColor),
                    const SizedBox(width: 16),
                    Expanded(child: _buildContent(iconColor)),
                    _buildChevron(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer(Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: iconColor.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(_getReadingIcon(reading.type), color: iconColor, size: 24),
    );
  }

  Widget _buildContent(Color iconColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTypeBadge(iconColor),
        const SizedBox(height: 12),
        Text(
          reading.reference ?? '',
          style: TextStyle(
            fontSize: AppSizes.heading5,
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          reading.text ?? '',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: AppSizes.bodyText,
            height: 1.6,
            color: colors.mutedForeground,
          ),
        ),
      ],
    );
  }

  Widget _buildTypeBadge(Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: iconColor.withAlpha(20),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        reading.type ?? Strings.reading,
        style: TextStyle(
          fontSize: AppSizes.bodyText,
          fontWeight: FontWeight.w600,
          color: iconColor,
        ),
      ),
    );
  }

  Widget _buildChevron() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Icon(FIcons.chevronRight, color: colors.mutedForeground, size: 18),
    );
  }

  IconData _getReadingIcon(String? type) {
    switch (type?.toUpperCase()) {
      case 'FIRST READING':
      case 'SECOND READING':
        return FIcons.bookOpen;
      case 'PSALM':
        return FIcons.music;
      case 'ALLELUIA':
        return FIcons.star;
      case 'GOSPEL':
        return FIcons.book;
      default:
        return FIcons.fileText;
    }
  }

  Color _getReadingColor(String? type) {
    switch (type?.toUpperCase()) {
      case 'FIRST READING':
      case 'SECOND READING':
        return AppColors.readingColor;
      case 'PSALM':
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
