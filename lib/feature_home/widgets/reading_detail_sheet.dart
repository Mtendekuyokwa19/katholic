import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:njirayamtanda/constants/app_colors.dart';
import 'package:njirayamtanda/constants/app_sizes.dart';
import 'package:njirayamtanda/constants/strings.dart';
import 'package:njirayamtanda/feature_home/models/catholic_readings_model.dart';

class ReadingDetailSheet extends StatelessWidget {
  final Reading reading;
  final FColors colors;

  const ReadingDetailSheet({
    super.key,
    required this.reading,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = _getReadingColor(reading.type);

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              _buildDragHandle(),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: const AssetImage(
                              'assets/images/jesus_on_cross.jpg',
                            ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withAlpha(102),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [_buildHeader(context, iconColor)],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Divider(color: colors.border, height: 1),
                      const SizedBox(height: 24),
                      _buildContent(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: colors.mutedForeground.withAlpha(80),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Color iconColor) {
    return Row(
      children: [
        _buildIconContainer(iconColor),
        const SizedBox(width: 16),
        Expanded(child: _buildTitleSection(iconColor)),
        _buildCloseButton(context),
      ],
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

  Widget _buildTitleSection(Color iconColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTypeBadge(iconColor),
        const SizedBox(height: 8),
        Text(
          reading.reference ?? '',
          style: TextStyle(
            fontSize: AppSizes.heading3,
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildTypeBadge(Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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

  Widget _buildCloseButton(BuildContext context) {
    return IconButton(
      icon: Icon(FIcons.x, color: colors.primary),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Widget _buildContent() {
    return Text(
      reading.text ?? '',
      style: TextStyle(
        fontSize: AppSizes.bodyText + 2,
        height: 1.8,
        color: colors.primary,
      ),
    );
  }

  IconData _getReadingIcon(String? type) {
    switch (type?.toUpperCase()) {
      case 'READING':
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
      case 'READING':
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
