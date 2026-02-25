import 'package:flutter/foundation.dart';

class DateOnCalenderProvider extends ChangeNotifier {
  // variables
  DateTime _selectedDate = DateTime.now();

  // getters
  DateTime get selectedDate => _selectedDate;
  // setters
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}

