import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import '../models/prayer_model.dart';

class PrayerCard extends StatelessWidget {
  final Prayer prayer;
  final VoidCallback onTap;
  final int index;

  const PrayerCard({
    super.key,
    required this.prayer,
    required this.onTap,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    final fTheme = FTheme.of(context);
    final colors = fTheme.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 50)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      colors.secondary.withAlpha(80),
                      colors.secondary.withAlpha(40),
                    ]
                  : [colors.background, colors.secondary.withAlpha(30)],
            ),
            border: Border.all(
              color: colors.border.withAlpha(isDark ? 60 : 100),
            ),
            boxShadow: [
              BoxShadow(
                color: prayer.accentColor.withAlpha(isDark ? 30 : 20),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  prayer.accentColor.withAlpha(isDark ? 15 : 20),
                  Colors.transparent,
                ],
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: prayer.accentColor.withAlpha(isDark ? 40 : 30),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: prayer.accentColor.withAlpha(isDark ? 60 : 80),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      prayer.icon,
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prayer.title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: colors.foreground,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (prayer.versions.length > 1) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: prayer.accentColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${prayer.versions.length} versions',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: prayer.accentColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            prayer.categories
                                .map((c) => Prayer.getCategoryDisplayName(c))
                                .toSet()
                                .join(", "),
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.primary.withAlpha(isDark ? 40 : 25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    FIcons.chevronRight,
                    color: colors.primary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryHeader extends StatelessWidget {
  final PrayerCategory category;
  final int index;
  final VoidCallback onSeeAll;

  const CategoryHeader({
    super.key,
    required this.category,
    required this.onSeeAll,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    final fTheme = FTheme.of(context);
    final colors = fTheme.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (index * 80)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(-20 * (1 - value), 0),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, top: 24),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: category.color.withAlpha(isDark ? 50 : 40),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: category.color.withAlpha(isDark ? 80 : 100),
                  width: 1.5,
                ),
              ),
              child: Icon(category.icon, color: category.color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: colors.foreground,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${category.prayers.length} prayers',
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            if (category.prayers.length > 3)
              GestureDetector(
                onTap: onSeeAll,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: category.color.withAlpha(isDark ? 30 : 25),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: category.color.withAlpha(isDark ? 60 : 80),
                    ),
                  ),
                  child: Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: category.color,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
