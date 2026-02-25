import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:njirayamtanda/constants/app_sizes.dart';
import 'package:njirayamtanda/constants/strings.dart';

class EmptyStateWidget extends StatelessWidget {
  final FColors colors;

  const EmptyStateWidget({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colors.secondary.withAlpha(30),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildIcon(), const SizedBox(height: 16), _buildMessage()],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.mutedForeground.withAlpha(20),
        shape: BoxShape.circle,
      ),
      child: Icon(FIcons.bookOpen, color: colors.mutedForeground, size: 32),
    );
  }

  Widget _buildMessage() {
    return Text(
      Strings.noReadingsAvailable,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: AppSizes.bodyText,
        color: colors.mutedForeground,
      ),
    );
  }
}
