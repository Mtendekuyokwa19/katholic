import 'package:flutter/material.dart';
import '../models/prayer_model.dart';
import '../functions/prayers_data.dart';

class PrayersProvider extends ChangeNotifier {
  List<Prayer> _searchResults = [];
  String _searchQuery = '';
  String? _selectedCategory;
  bool _isSearching = false;

  List<Prayer> get searchResults => _searchResults;
  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;
  bool get isSearching => _isSearching;

  List<PrayerCategory> get categories => PrayersData.getPrayersByCategory();

  void search(String query) {
    _searchQuery = query;
    _isSearching = query.isNotEmpty;
    if (query.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = PrayersData.searchPrayers(query);
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    _isSearching = false;
    notifyListeners();
  }

  void selectCategory(String? categoryId) {
    _selectedCategory = categoryId;
    notifyListeners();
  }

  List<Prayer> getPrayersForCategory(String categoryId) {
    return PrayersData.allPrayers
        .where((p) => p.categories.contains(categoryId))
        .toList()
      ..sort((a, b) => a.title.compareTo(b.title));
  }

  Prayer? getPrayer(String id) {
    return PrayersData.getPrayerById(id);
  }
}
