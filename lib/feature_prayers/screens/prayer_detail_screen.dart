import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import '../models/prayer_model.dart';

class PrayerDetailScreen extends StatefulWidget {
  final Prayer prayer;

  const PrayerDetailScreen({super.key, required this.prayer});

  @override
  State<PrayerDetailScreen> createState() => _PrayerDetailScreenState();
}

class _PrayerDetailScreenState extends State<PrayerDetailScreen>
    with SingleTickerProviderStateMixin {
  int _selectedVersionIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _sharePrayer() {
    final version = widget.prayer.versions[_selectedVersionIndex];
    final shareText =
        '''
${widget.prayer.title}
${version.name.isNotEmpty ? '(${version.name})' : ''}

${version.content}

Shared from Catholic App
''';

    Clipboard.setData(ClipboardData(text: shareText));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            const Text('Prayer copied'),
          ],
        ),
        backgroundColor: colors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  FColors get colors => FTheme.of(context).colors;

  @override
  Widget build(BuildContext context) {
    final colors = this.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final version = widget.prayer.versions[_selectedVersionIndex];

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(colors, isDark),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleSection(colors, isDark),
                      const SizedBox(height: 24),
                      if (widget.prayer.versions.length > 1) ...[
                        _buildVersionSelector(colors, isDark),
                        const SizedBox(height: 24),
                      ],
                      _buildPrayerContent(colors, isDark, version),
                      const SizedBox(height: 32),
                      _buildShareButton(colors, isDark),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(FColors colors, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colors.secondary.withAlpha(isDark ? 40 : 30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(FIcons.arrowLeft, color: colors.foreground, size: 18),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: widget.prayer.accentColor.withAlpha(isDark ? 25 : 18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.prayer.categories
                  .map((c) => Prayer.getCategoryDisplayName(c))
                  .toSet()
                  .join(', '),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: widget.prayer.accentColor.withAlpha(isDark ? 200 : 160),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection(FColors colors, bool isDark) {
    final selectedVersion = widget.prayer.versions[_selectedVersionIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: widget.prayer.accentColor.withAlpha(isDark ? 30 : 20),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                widget.prayer.icon,
                color: widget.prayer.accentColor.withAlpha(isDark ? 200 : 160),
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.prayer.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: colors.foreground,
                    ),
                  ),
                  if (selectedVersion.name.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      selectedVersion.name,
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.mutedForeground,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVersionSelector(FColors colors, bool isDark) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.prayer.versions.asMap().entries.map((entry) {
          final isSelected = entry.key == _selectedVersionIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                _animationController.reset();
                setState(() {
                  _selectedVersionIndex = entry.key;
                });
                _animationController.forward();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? widget.prayer.accentColor.withAlpha(isDark ? 35 : 25)
                      : colors.secondary.withAlpha(isDark ? 40 : 30),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? widget.prayer.accentColor.withAlpha(isDark ? 80 : 60)
                        : colors.border.withAlpha(60),
                  ),
                ),
                child: Text(
                  entry.value.name.isEmpty
                      ? 'Version ${entry.key + 1}'
                      : entry.value.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? widget.prayer.accentColor.withAlpha(
                            isDark ? 230 : 180,
                          )
                        : colors.foreground.withAlpha(180),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPrayerContent(
    FColors colors,
    bool isDark,
    PrayerVersion version,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? colors.secondary.withAlpha(25)
            : colors.secondary.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border.withAlpha(isDark ? 30 : 50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.format_quote,
                color: colors.mutedForeground.withAlpha(100),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Prayer',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colors.mutedForeground,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFormattedText(version.content, colors, isDark),
        ],
      ),
    );
  }

  Widget _buildFormattedText(String content, FColors colors, bool isDark) {
    final lines = content.split('\n');
    final List<Widget> widgets = [];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final trimmedLine = line.trim();

      if (trimmedLine.isEmpty) {
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      final isItalic = trimmedLine.startsWith('_') && trimmedLine.endsWith('_');
      final isBold = trimmedLine.startsWith('**') && trimmedLine.endsWith('**');
      final isResponse =
          trimmedLine.startsWith('℟.') || trimmedLine.startsWith('R/.');
      final isLeader =
          trimmedLine.startsWith('℣.') || trimmedLine.startsWith('V/.');
      final isSection =
          trimmedLine.startsWith('Let us pray') ||
          trimmedLine.startsWith('**Let us pray');

      final cleanLine = isItalic
          ? trimmedLine.substring(1, trimmedLine.length - 1)
          : (isBold
                ? trimmedLine.substring(2, trimmedLine.length - 2)
                : trimmedLine);

      TextStyle style;

      if (isSection) {
        style = TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: widget.prayer.accentColor.withAlpha(isDark ? 200 : 160),
          fontStyle: FontStyle.italic,
          height: 1.5,
        );
      } else if (isResponse) {
        style = TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colors.foreground,
          fontStyle: FontStyle.italic,
          height: 1.5,
        );
      } else if (isLeader) {
        style = TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: widget.prayer.accentColor.withAlpha(isDark ? 200 : 160),
          height: 1.5,
        );
      } else if (isBold) {
        style = TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: colors.foreground,
          height: 1.5,
        );
      } else {
        style = TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colors.foreground,
          height: 1.6,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        );
      }

      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: Text(cleanLine, style: style),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildShareButton(FColors colors, bool isDark) {
    return GestureDetector(
      onTap: _sharePrayer,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: colors.primary.withAlpha(isDark ? 35 : 25),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.primary.withAlpha(isDark ? 60 : 40)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.copy_outlined,
              color: colors.primary.withAlpha(isDark ? 220 : 180),
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              'Copy Prayer',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: colors.primary.withAlpha(isDark ? 220 : 180),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
