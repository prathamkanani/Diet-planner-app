import '../../domain/entity/meal_entity.dart';

/// To check whether a certain day's meal is within the
/// generated plan or a new plan needs to be generated.
bool isWithinPlan({
  required DateTime startDate,
  required DateTime currentDate,
}) {
  final planStartDate = startDate.add(const Duration(days: 28));
  return !currentDate.isBefore(startDate) &&
      !currentDate.isAfter(planStartDate);
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
