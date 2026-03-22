import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:google_fonts/google_fonts.dart';
import '../functions/prayers_data.dart';
import '../models/prayer_model.dart';
import '../widgets/prayer_card.dart';
import 'prayer_detail_screen.dart';

class PrayersScreen extends StatefulWidget {
  const PrayersScreen({super.key});

  @override
  State<PrayersScreen> createState() => _PrayersScreenState();
}

class _PrayersScreenState extends State<PrayersScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<Prayer> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      _searchResults = query.isEmpty ? [] : PrayersData.searchPrayers(query);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
      _searchResults = [];
    });
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }

  Widget _buildHeader(BuildContext context, FColors colors, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
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
                      style: GoogleFonts.quicksand(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: colors.foreground,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Sacred prayers and devotions',
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        color: colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.secondary.withAlpha(isDark ? 40 : 30),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  FIcons.sparkles,
                  color: colors.primary.withAlpha(isDark ? 180 : 140),
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSearchBar(colors, isDark),
        ],
      ),
    );
  }

  Widget _buildSearchBar(FColors colors, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: colors.secondary.withAlpha(isDark ? 40 : 40),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearch,
        style: GoogleFonts.manrope(fontSize: 15, color: colors.foreground),
        decoration: InputDecoration(
          hintText: 'Search prayers...',
          hintStyle: GoogleFonts.manrope(color: colors.mutedForeground),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(FIcons.search, color: colors.mutedForeground, size: 18),
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: _clearSearch,
                  icon: Icon(FIcons.x, color: colors.mutedForeground, size: 16),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
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
              size: 48,
              color: colors.mutedForeground.withAlpha(80),
            ),
            const SizedBox(height: 12),
            Text(
              'No prayers found',
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: colors.mutedForeground,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
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
    final featuredPrayers = PrayersData.featuredPrayers;

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
      itemCount: categories.length + 1,
      itemBuilder: (context, categoryIndex) {
        if (categoryIndex == 0) {
          return _buildFeaturedSection(
            context,
            colors,
            isDark,
            featuredPrayers,
          );
        }

        final adjustedIndex = categoryIndex - 1;
        final category = categories[adjustedIndex];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryHeader(
              category: category,
              index: adjustedIndex,
              onSeeAll: () => _openCategoryDetail(context, category),
            ),
            ...category.prayers.take(3).toList().asMap().entries.map((entry) {
              return PrayerCard(
                prayer: entry.value,
                index: entry.key,
                onTap: () => _openPrayerDetail(context, entry.value),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildFeaturedSection(
    BuildContext context,
    FColors colors,
    bool isDark,
    List<Prayer> featuredPrayers,
  ) {
    if (featuredPrayers.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12, top: 8),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: colors.primary.withAlpha(isDark ? 30 : 20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  FIcons.star,
                  color: colors.primary.withAlpha(isDark ? 180 : 140),
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Featured Prayers',
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colors.foreground,
                      ),
                    ),
                    Text(
                      'Timeless prayers for daily devotion',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredPrayers.length,
            itemBuilder: (context, index) {
              final prayer = featuredPrayers[index];
              return SizedBox(
                width: 280,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index < featuredPrayers.length - 1 ? 12 : 0,
                  ),
                  child: FeaturedPrayerCard(
                    prayer: prayer,
                    index: index,
                    onTap: () => _openPrayerDetail(context, prayer),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _openPrayerDetail(BuildContext context, Prayer prayer) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return PrayerDetailScreen(prayer: prayer);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 250),
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
        transitionDuration: const Duration(milliseconds: 200),
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
    final count = category.prayers.length;
    final label = '$count ${count == 1 ? 'prayer' : 'prayers'}';

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: colors.secondary.withAlpha(isDark ? 40 : 30),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          FIcons.arrowLeft,
                          color: colors.foreground,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: category.color.withAlpha(isDark ? 30 : 20),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      category.icon,
                      color: category.color.withAlpha(isDark ? 180 : 140),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.name,
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: colors.foreground,
                          ),
                        ),
                        Text(
                          label,
                          style: GoogleFonts.manrope(
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
                                  child: child,
                                );
                              },
                          transitionDuration: const Duration(milliseconds: 250),
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
