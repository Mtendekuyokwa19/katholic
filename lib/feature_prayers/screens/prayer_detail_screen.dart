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
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.05), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
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
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            const Text('Prayer copied to clipboard'),
          ],
        ),
        backgroundColor: widget.prayer.accentColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fTheme = FTheme.of(context);
    final colors = fTheme.colors;
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
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleSection(colors, isDark),
                        const SizedBox(height: 24),
                        if (widget.prayer.versions.length > 1)
                          _buildVersionSelector(colors, isDark),
                        const SizedBox(height: 24),
                        _buildPrayerContent(colors, isDark, version),
                        const SizedBox(height: 40),
                        _buildShareButton(colors, isDark),
                        const SizedBox(height: 20),
                      ],
                    ),
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
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: colors.secondary.withAlpha(isDark ? 80 : 60),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(FIcons.arrowLeft, color: colors.foreground, size: 20),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: widget.prayer.accentColor.withAlpha(isDark ? 40 : 30),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget.prayer.accentColor.withAlpha(isDark ? 60 : 80),
              ),
            ),
            child: Text(
              widget.prayer.categories
                  .map((c) => Prayer.getCategoryDisplayName(c))
                  .toSet()
                  .join(', '),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: widget.prayer.accentColor,
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
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.prayer.accentColor,
                widget.prayer.accentColor.withAlpha(180),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.prayer.accentColor.withAlpha(60),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.prayer.icon,
              style: const TextStyle(fontSize: 34),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          widget.prayer.title,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: colors.foreground,
            letterSpacing: -1,
            height: 1.1,
          ),
        ),
        if (selectedVersion.name.isNotEmpty) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colors.secondary.withAlpha(isDark ? 80 : 60),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              selectedVersion.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colors.mutedForeground,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildVersionSelector(FColors colors, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Versions',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: colors.mutedForeground,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.prayer.versions.asMap().entries.map((entry) {
              final isSelected = entry.key == _selectedVersionIndex;
              return GestureDetector(
                onTap: () {
                  _animationController.reset();
                  setState(() {
                    _selectedVersionIndex = entry.key;
                  });
                  _animationController.forward();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? widget.prayer.accentColor
                        : colors.secondary.withAlpha(isDark ? 80 : 60),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? widget.prayer.accentColor
                          : colors.border,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: widget.prayer.accentColor.withAlpha(40),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    entry.value.name.isEmpty
                        ? 'Version ${entry.key + 1}'
                        : entry.value.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : colors.foreground,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPrayerContent(
    FColors colors,
    bool isDark,
    PrayerVersion version,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark
            ? colors.secondary.withAlpha(60)
            : colors.secondary.withAlpha(40),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border.withAlpha(isDark ? 80 : 120)),
        boxShadow: [
          BoxShadow(
            color: widget.prayer.accentColor.withAlpha(isDark ? 20 : 15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.prayer.accentColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  FIcons.sparkles,
                  color: widget.prayer.accentColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Prayer',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: widget.prayer.accentColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
        widgets.add(const SizedBox(height: 12));
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
          trimmedLine.startsWith('**Let us pray') ||
          trimmedLine.startsWith('Let us pray');

      final cleanLine = isItalic
          ? trimmedLine.substring(1, trimmedLine.length - 1)
          : (isBold
                ? trimmedLine.substring(2, trimmedLine.length - 2)
                : trimmedLine);

      TextStyle style;

      if (isSection) {
        style = TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: widget.prayer.accentColor,
          fontStyle: FontStyle.italic,
          height: 1.6,
        );
      } else if (isResponse) {
        style = TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: colors.foreground,
          fontStyle: FontStyle.italic,
          height: 1.6,
        );
      } else if (isLeader) {
        style = TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: widget.prayer.accentColor,
          height: 1.6,
        );
      } else if (isBold) {
        style = TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: colors.foreground,
          height: 1.6,
        );
      } else {
        style = TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: colors.foreground,
          height: 1.7,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        );
      }

      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.prayer.accentColor,
              widget.prayer.accentColor.withAlpha(200),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: widget.prayer.accentColor.withAlpha(50),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.copy_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            const Text(
              'Copy Prayer',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
