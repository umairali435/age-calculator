import 'dart:async';

import 'package:agecalculate/logics/comparison_date_logic.dart';
import 'package:agecalculate/provider/update_inital_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateTimeProvider extends ChangeNotifier {
  int _days = 0;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  int get days => _days;
  int get hours => _hours;
  int get minutes => _minutes;
  int get seconds => _seconds;

  set days(int day) {
    _days = day;
    notifyListeners();
  }

  set hours(int hour) {
    _hours = hour;
    notifyListeners();
  }

  set minutes(int minute) {
    _minutes = minute;
    notifyListeners();
  }

  set seconds(int second) {
    _seconds = second;
    notifyListeners();
  }

  updateTime(context) {
    final date = Provider.of<UpdateInitialDateTimeProvider>(context, listen: false);
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        DateTime now = DateTime.now();
        Duration difference = DateTime(
          now.year,
          date.initialDate.month,
          date.initialDate.day,
        ).difference(
          DateTime.now(),
        );
        Duration difference2 = DateTime(
          now.year + 1,
          date.initialDate.month,
          date.initialDate.day,
        ).difference(
          DateTime.now(),
        );
        if (difference.isNegative) {
          Map<String, int> timeLeft = ComparisonDateLogic.calculateTimeDifference(difference2);
          days = timeLeft['days']!;
          hours = timeLeft['hours']!;
          minutes = timeLeft['minutes']!;
          seconds = timeLeft['seconds']!;
        } else {
          Map<String, int> timeLeft = ComparisonDateLogic.calculateTimeDifference(difference);
          days = timeLeft['days']!;
          hours = timeLeft['hours']!;
          minutes = timeLeft['minutes']!;
          seconds = timeLeft['seconds']!;
        }
      },
    );
  }
}
