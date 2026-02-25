import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:njirayamtanda/constants/app_sizes.dart';
import 'package:njirayamtanda/constants/strings.dart';

class HeaderSection extends StatelessWidget {
  final FColors colors;

  const HeaderSection({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary.withAlpha(40), colors.primary.withAlpha(15)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.primary.withAlpha(50), width: 1),
      ),
      child: Row(
        children: [
          _buildIconContainer(colors),
          const SizedBox(width: 14),
          Expanded(child: _buildTextContent(colors)),
          _buildArrowIcon(colors),
        ],
      ),
    );
  }

  Widget _buildIconContainer(FColors colors) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.primary.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(FIcons.book, color: colors.primary, size: 24),
    );
  }

  Widget _buildTextContent(FColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.wordOfTheDay,
          style: TextStyle(
            fontSize: AppSizes.heading4,
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          Strings.tapToRead,
          style: TextStyle(
            fontSize: AppSizes.bodyText,
            color: colors.mutedForeground,
          ),
        ),
      ],
    );
  }

  Widget _buildArrowIcon(FColors colors) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.primary.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(FIcons.chevronRight, color: colors.primary, size: 20),
    );
  }
}
