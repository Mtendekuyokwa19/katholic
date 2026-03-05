import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:katholic/constants/strings.dart';
import 'package:katholic/feature_way_of_the_cross/models/way_of_the_cross_model.dart';

class SearchStationsScreen extends StatefulWidget {
  final WayOfTheCrossData data;
  final Function(int index) onStationSelected;

  const SearchStationsScreen({
    super.key,
    required this.data,
    required this.onStationSelected,
  });

  @override
  State<SearchStationsScreen> createState() => _SearchStationsScreenState();
}

class _SearchStationsScreenState extends State<SearchStationsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Station> _searchResults = [];
  List<String> _recentSearches = [];
  bool _showResults = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
        _showResults = false;
      } else {
        _searchResults = widget.data.stations.where((station) {
          final queryLower = query.toLowerCase();
          return station.title.toLowerCase().contains(queryLower) ||
              station.number.toString().contains(query) ||
              _getStationType(
                station.number,
              ).toLowerCase().contains(queryLower);
        }).toList();
        _showResults = true;
      }
    });
  }

  void _addToRecentSearches(String query) {
    if (query.isNotEmpty && !_recentSearches.contains(query)) {
      setState(() {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 5) {
          _recentSearches = _recentSearches.sublist(0, 5);
        }
      });
    }
  }

  String _getStationType(int number) {
    final stationTypes = [
      Strings.firstStation,
      Strings.secondStation,
      Strings.thirdStation,
      Strings.fourthStation,
      Strings.fifthStation,
      Strings.sixthStation,
      Strings.seventhStation,
      Strings.eighthStation,
      Strings.ninthStation,
      Strings.tenthStation,
      Strings.eleventhStation,
      Strings.twelfthStation,
      Strings.thirteenthStation,
      Strings.fourteenthStation,
    ];
    if (number >= 1 && number <= 14) {
      return stationTypes[number - 1];
    }
    return '$number ${Strings.stationType}';
  }

  void _onStationTap(Station station) {
    _addToRecentSearches(station.title);
    final index = widget.data.stations.indexOf(station);
    widget.onStationSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.secondary.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  style: TextStyle(color: colors.foreground),
                  decoration: InputDecoration(
                    hintText: Strings.search,
                    hintStyle: TextStyle(
                      color: colors.mutedForeground,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: colors.mutedForeground,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.close,
                              color: colors.mutedForeground,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              _onSearch('');
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onChanged: _onSearch,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _addToRecentSearches(value);
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: _showResults
                  ? _buildSearchResults(colors)
                  : _emptySearch(colors),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(FColors colors) {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 48, color: colors.mutedForeground),
            const SizedBox(height: 16),
            Text(
              Strings.noResults,
              style: TextStyle(color: colors.mutedForeground, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '${Strings.searchResults} ${_searchResults.length} ${Strings.found}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colors.mutedForeground,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final station = _searchResults[index];
              return _buildStationTile(station, colors);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStationTile(Station station, FColors colors) {
    return InkWell(
      onTap: () => _onStationTap(station),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  _getRomanNumeral(station.number),
                  style: TextStyle(
                    color: colors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    station.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colors.foreground,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _getStationType(station.number),
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: colors.mutedForeground),
          ],
        ),
      ),
    );
  }

  Widget _emptySearch(FColors colors) {
    return Center(
      child: FCard(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search, size: 64, color: colors.primary),
              const SizedBox(height: 16),
              Text(
                Strings.getStarted,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: colors.foreground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                Strings.searchStations,
                style: TextStyle(fontSize: 14, color: colors.mutedForeground),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRomanNumeral(int number) {
    const romanNumerals = [
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X',
      'XI',
      'XII',
      'XIII',
      'XIV',
    ];
    if (number >= 1 && number <= 14) {
      return romanNumerals[number - 1];
    }
    return number.toString();
  }
}
