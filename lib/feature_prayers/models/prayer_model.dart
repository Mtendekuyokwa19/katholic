import 'package:flutter/material.dart';

class Prayer {
  final String id;
  final String title;
  final List<String> categories;
  final List<PrayerVersion> versions;
  final String icon;
  final Color accentColor;

  const Prayer({
    required this.id,
    required this.title,
    required this.categories,
    required this.versions,
    this.icon = '✨',
    this.accentColor = const Color(0xFF8B1538),
  });

  static String getCategoryDisplayName(String category) {
    switch (category) {
      case 'basic':
        return 'Classic Prayers';
      case 'rosary':
        return 'Rosary Mysteries';
      case 'litany':
        return 'Litanies';
      case 'saints':
        return 'Saints';
      case 'creeds':
        return 'Creeds';
      case 'other':
        return 'Other Prayers';
      default:
        return category;
    }
  }

  static IconData getCategoryIcon(String category) {
    switch (category) {
      case 'basic':
        return Icons.auto_awesome;
      case 'rosary':
        return Icons.grain;
      case 'litany':
        return Icons.format_list_numbered;
      case 'saints':
        return Icons.person;
      case 'creeds':
        return Icons.menu_book;
      default:
        return Icons.favorite;
    }
  }

  static Color getCategoryColor(String category) {
    switch (category) {
      case 'basic':
        return const Color(0xFF8B1538);
      case 'rosary':
        return const Color(0xFF1E3A5F);
      case 'litany':
        return const Color(0xFF2E5B3A);
      case 'saints':
        return const Color(0xFF5B442E);
      case 'creeds':
        return const Color(0xFF4A1E5B);
      default:
        return const Color(0xFF8B1538);
    }
  }
}

class PrayerVersion {
  final String name;
  final String content;

  const PrayerVersion({required this.name, required this.content});
}

class PrayerCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final List<Prayer> prayers;

  const PrayerCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.prayers,
  });
}
