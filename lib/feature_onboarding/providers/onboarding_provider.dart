import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider with ChangeNotifier {
  bool _hasCompletedOnboarding = false;

  bool get hasCompletedOnboarding => _hasCompletedOnboarding;

  Future<void> loadOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding') ?? false;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedOnboarding', true);
    _hasCompletedOnboarding = true;
    notifyListeners();
  }
}
