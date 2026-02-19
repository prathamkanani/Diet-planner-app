import '../../domain/entity/meal_entity.dart';

DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// To check whether a certain day's meal is within the
/// generated plan or a new plan needs to be generated.
bool isWithinPlan({
  required DateTime startDate,
  required DateTime currentDate,
}) {
  final startDateOnly = dateOnly(startDate);
  final currentDateOnly = dateOnly(currentDate);
  final planStartDate = startDateOnly.add(const Duration(days: 28));
  return !currentDateOnly.isBefore(startDateOnly) &&
      !currentDateOnly.isAfter(planStartDate);
}

MealType fromTime(DateTime date) {
  int currentHour = date.hour;
  if (currentHour <= 9) {
    return .breakfast;
  } else if (currentHour <= 14) {
    return .lunch;
  } else {
    return .dinner;
  }
}
