import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import '../functions/prayers_data.dart';
import '../models/prayer_model.dart';
import '../widgets/prayer_card.dart';
import 'prayer_detail_screen.dart';

class PrayersScreen extends StatefulWidget {
  const PrayersScreen({super.key});

  @override
  State<PrayersScreen> createState() => _PrayersScreenState();
}

class _PrayersScreenState extends State<PrayersScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSearching = false;
  List<Prayer> _searchResults = [];
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = CurvedAnimation(
      parent: _fabController,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _isSearching = false;
        _searchResults = [];
      } else {
        _isSearching = true;
        _searchResults = PrayersData.searchPrayers(query);
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
      _searchResults = [];
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final fTheme = FTheme.of(context);
    final colors = fTheme.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, colors, isDark),
            Expanded(
              child: _isSearching
                  ? _buildSearchResults(context, colors, isDark)
                  : _buildContent(context, colors, isDark),
            ),
          ],
        ),
      ),
      floatingActionButton: !_isSearching
          ? ScaleTransition(
              scale: _fabAnimation,
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                backgroundColor: colors.primary,
                child: Icon(FIcons.arrowUp, color: colors.primaryForeground),
              ),
            )
          : null,
    );
  }

  Widget _buildHeader(BuildContext context, FColors colors, bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prayers',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: colors.foreground,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'A collection of sacred prayers',
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFF8B1538), const Color(0xFF5B1E3A)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B1538).withAlpha(60),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('🙏', style: TextStyle(fontSize: 26)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSearchBar(colors, isDark),
        ],
      ),
    );
  }

  Widget _buildSearchBar(FColors colors, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? colors.secondary.withAlpha(80)
            : colors.secondary.withAlpha(60),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearch,
        style: TextStyle(fontSize: 16, color: colors.foreground),
        decoration: InputDecoration(
          hintText: 'Search prayers...',
          hintStyle: TextStyle(color: colors.mutedForeground),
          prefixIcon: Icon(
            FIcons.search,
            color: colors.mutedForeground,
            size: 20,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? GestureDetector(
                  onTap: _clearSearch,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: colors.mutedForeground.withAlpha(50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        FIcons.x,
                        color: colors.mutedForeground,
                        size: 14,
                      ),
                    ),
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(
    BuildContext context,
    FColors colors,
    bool isDark,
  ) {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FIcons.search,
              size: 64,
              color: colors.mutedForeground.withAlpha(100),
            ),
            const SizedBox(height: 16),
            Text(
              'No prayers found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colors.mutedForeground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search term',
              style: TextStyle(
                fontSize: 14,
                color: colors.mutedForeground.withAlpha(150),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final prayer = _searchResults[index];
        return PrayerCard(
          prayer: prayer,
          index: index,
          onTap: () => _openPrayerDetail(context, prayer),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, FColors colors, bool isDark) {
    final categories = PrayersData.getPrayersByCategory();

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels > 200) {
          _fabController.forward();
        } else {
          _fabController.reverse();
        }
        return false;
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
        itemCount: categories.length,
        itemBuilder: (context, categoryIndex) {
          final category = categories[categoryIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryHeader(
                category: category,
                index: categoryIndex,
                onSeeAll: () => _openCategoryDetail(context, category),
              ),
              ...category.prayers.take(3).toList().asMap().entries.map((entry) {
                return PrayerCard(
                  prayer: entry.value,
                  index: entry.key + (categoryIndex * 10),
                  onTap: () => _openPrayerDetail(context, entry.value),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  void _openPrayerDetail(BuildContext context, Prayer prayer) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return PrayerDetailScreen(prayer: prayer);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  void _openCategoryDetail(BuildContext context, PrayerCategory category) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return CategoryPrayersScreen(category: category);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

class CategoryPrayersScreen extends StatelessWidget {
  final PrayerCategory category;

  const CategoryPrayersScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final fTheme = FTheme.of(context);
    final colors = fTheme.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
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
                      child: Icon(
                        FIcons.arrowLeft,
                        color: colors.foreground,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
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
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: colors.foreground,
                            letterSpacing: -0.5,
                          ),
                        ),
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
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                itemCount: category.prayers.length,
                itemBuilder: (context, index) {
                  final prayer = category.prayers[index];
                  return PrayerCard(
                    prayer: prayer,
                    index: index,
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                                return PrayerDetailScreen(prayer: prayer);
                              },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position:
                                        Tween<Offset>(
                                          begin: const Offset(0, 0.1),
                                          end: Offset.zero,
                                        ).animate(
                                          CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeOutCubic,
                                          ),
                                        ),
                                    child: child,
                                  ),
                                );
                              },
                          transitionDuration: const Duration(milliseconds: 350),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
