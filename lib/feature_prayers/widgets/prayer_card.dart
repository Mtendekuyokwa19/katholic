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

    return FadeIn(
      delay: Duration(milliseconds: 50 * index),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? colors.secondary.withAlpha(30) : colors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colors.border.withAlpha(isDark ? 40 : 60),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: prayer.accentColor.withAlpha(isDark ? 25 : 18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  prayer.icon,
                  color: prayer.accentColor.withAlpha(isDark ? 180 : 150),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prayer.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: colors.foreground,
                      ),
                    ),
                    const SizedBox(height: 2),
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
              ),
              Icon(
                FIcons.chevronRight,
                color: colors.mutedForeground.withAlpha(150),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FadeIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const FadeIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
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

    return FadeIn(
      delay: Duration(milliseconds: 80 * index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, top: 20),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: category.color.withAlpha(isDark ? 30 : 20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                category.icon,
                color: category.color.withAlpha(isDark ? 180 : 140),
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colors.foreground,
                    ),
                  ),
                  Text(
                    '${category.prayers.length} prayers',
                    style: TextStyle(
                      fontSize: 12,
                      color: colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            if (category.prayers.length > 3)
              TextButton(
                onPressed: onSeeAll,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: category.color.withAlpha(isDark ? 200 : 180),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
