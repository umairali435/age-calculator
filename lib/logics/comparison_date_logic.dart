class ComparisonDateLogic {
  ComparisonDateLogic._();
  static DateTime calculateDateDifference(DateTime startDate, DateTime endDate) {
    if (startDate.isAfter(endDate)) {
      throw ArgumentError('Start date should be before end date');
    }
    int years = endDate.year - startDate.year;
    int months = endDate.month - startDate.month;
    int days = endDate.day - startDate.day;

    if (days < 0) {
      months--;
      final previousMonthDate = DateTime(endDate.year, endDate.month - 1, startDate.day);
      days = DateTime(endDate.year, endDate.month, 0).day - previousMonthDate.day + endDate.day;
    }

    if (months < 0) {
      years--;
      months += 12;
    }
    return DateTime(years, months, days);
  }

  static Map<String, int> calculateTimeDifference(Duration duration) {
    int totalSeconds = duration.inSeconds;

    int days = totalSeconds ~/ (24 * 3600);
    totalSeconds %= (24 * 3600);

    int hours = totalSeconds ~/ 3600;
    totalSeconds %= 3600;

    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    return {'days': days, 'hours': hours, 'minutes': minutes, 'seconds': seconds};
  }
}
