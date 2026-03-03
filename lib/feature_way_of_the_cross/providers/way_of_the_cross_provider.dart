import 'package:flutter/foundation.dart';

class WayOfTheCrossProvider extends ChangeNotifier {
  int _currentStationIndex = 0;
  bool _isPlaying = false;

  int get currentStationIndex => _currentStationIndex;
  bool get isPlaying => _isPlaying;

  void setStationIndex(int index) {
    _currentStationIndex = index;
    notifyListeners();
  }

  void setIsPlaying(bool playing) {
    _isPlaying = playing;
    notifyListeners();
  }

  void nextStation(int maxStations) {
    if (_currentStationIndex < maxStations - 1) {
      _currentStationIndex++;
      notifyListeners();
    }
  }

  void previousStation() {
    if (_currentStationIndex > 0) {
      _currentStationIndex--;
      notifyListeners();
    }
  }

  void togglePlayPause() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void reset() {
    _currentStationIndex = 0;
    _isPlaying = false;
    notifyListeners();
  }
}
