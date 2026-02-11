import '../../domain/eum/weekday.dart';
import '../extension/weekday_extension.dart';

bool isWithinPlan({
  required DateTime startDate,
  required DateTime currentDate,
}) {
  final planStartDate = startDate.add(const Duration(days: 28));
  return !currentDate.isBefore(startDate) &&
      !currentDate.isAfter(planStartDate);
}

int weekdayLabelToInt(String label) {
  final weekDay = Weekday.values.firstWhere(
    (e) => e.label.toLowerCase() == label.toLowerCase(),
  );

  return weekDay.value;
}
