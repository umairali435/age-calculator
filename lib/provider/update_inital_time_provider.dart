import 'package:flutter/material.dart';

class UpdateInitialDateTimeProvider extends ChangeNotifier {
  DateTime _initialDate = DateTime(1990, 7, 12);
  DateTime get initialDate => _initialDate;
  set initialDate(DateTime date) {
    _initialDate = date;
    notifyListeners();
  }
}
