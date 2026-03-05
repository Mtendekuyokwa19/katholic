import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:katholic/constants/strings.dart';

class CatholicReadingWidget extends StatelessWidget {
  const CatholicReadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: HomeWidget.getWidgetData('activity_data'),
      builder: (context, snapshot) {
        final activityData = snapshot.data;
        Map<String, int> activityMap = {};
        if (activityData != null) {
          try {
            final decoded = json.decode(activityData) as Map<String, dynamic>;
            activityMap = decoded.map(
              (key, value) => MapEntry(key, value as int),
            );
          } catch (e) {
            activityMap = {};
          }
        }

        return Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                Strings.reading,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildContributionGrid(activityMap),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContributionGrid(Map<String, int> activityMap) {
    final List<int> grid = [];
    final today = DateTime.now();

    for (int i = 48; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final dateStr =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      grid.add(activityMap[dateStr] ?? 0);
    }

    return SizedBox(
      height: 70,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: 49,
        itemBuilder: (context, index) {
          final level = _getLevel(grid[index]);
          return Container(
            decoration: BoxDecoration(
              color: _getColor(level),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        },
      ),
    );
  }

  int _getLevel(int count) {
    if (count == 0) return 0;
    if (count <= 2) return 1;
    if (count <= 5) return 2;
    return 3;
  }

  Color _getColor(int level) {
    switch (level) {
      case 0:
        return Colors.grey[200]!;
      case 1:
        return Colors.green[200]!;
      case 2:
        return Colors.green[400]!;
      case 3:
        return Colors.green[700]!;
      default:
        return Colors.grey[200]!;
    }
  }
}
