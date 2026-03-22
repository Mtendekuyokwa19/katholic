import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class PrayerColors {
  static Color getAccentColor(BuildContext context, List<String> categories) {
    final colors = FTheme.of(context).colors;
    final primary = colors.primary;

    if (categories.contains('basic')) {
      return primary;
    } else if (categories.contains('rosary')) {
      return colors.secondary;
    } else if (categories.contains('litany')) {
      return Color.lerp(primary, colors.secondary, 0.3) ?? primary;
    } else if (categories.contains('saints')) {
      return Color.lerp(primary, colors.mutedForeground, 0.4) ?? primary;
    } else if (categories.contains('creeds')) {
      return colors.secondary;
    }
    return primary;
  }

  static Color getCategoryColor(BuildContext context, String categoryId) {
    final colors = FTheme.of(context).colors;
    final primary = colors.primary;

    switch (categoryId) {
      case 'basic':
        return primary;
      case 'rosary':
        return colors.secondary;
      case 'litany':
        return Color.lerp(primary, colors.secondary, 0.3) ?? primary;
      case 'saints':
        return Color.lerp(primary, colors.mutedForeground, 0.4) ?? primary;
      case 'creeds':
        return colors.secondary;
      default:
        return primary;
    }
  }

  static Color getCategoryIcon(BuildContext context, String categoryId) {
    return getCategoryColor(context, categoryId);
  }
}
