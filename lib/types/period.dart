enum Period {
  week,
  month,
  year,
}

String getPeriodName(Period period) {
  switch (period) {
    
    case Period.week:
      return "Week";
    case Period.month:
      return "Month";
    case Period.year:
      return "Year";
  }
}

String getPeriodDisplayName(Period period) {
  switch (period) {
    
    case Period.week:
      return "This week";
    case Period.month:
      return "This month";
    case Period.year:
      return "This year";
  }
}

List<Period> periods = [Period.week, Period.month, Period.year];
