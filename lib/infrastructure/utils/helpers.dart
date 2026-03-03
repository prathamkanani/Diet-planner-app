import '../../domain/entity/meal_entity.dart';
import '../../domain/entity/user_preferences.dart';
import '../extension/health_habit_extension.dart';
import '../service/gemini_functional_service.dart';

/// This function gets the date only without time.
DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// This gets the calendar week(start) of any date in the middle of the week.
DateTime startOfTheWeek(DateTime d) {
  return d.subtract(Duration(days: dateOnly(d).weekday - 1));
}

DateTime endOfTheWeek(DateTime d) {
  return startOfTheWeek(d).add(const Duration(days: 6));
}

/// Helper function to check whether selected date is today or not.
bool isToday(DateTime date) {
  final now = DateTime.now();
  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day;
}

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

bool isSameWeek({
  required DateTime startDate,
  required DateTime currentDate,
}) {
  final startDateOnly = dateOnly(startDate);
  final currentDateOnly = dateOnly(currentDate);
  final planStartDate = startDateOnly.add(const Duration(days: 7));
  return !currentDateOnly.isBefore(startDateOnly) &&
      !currentDateOnly.isAfter(planStartDate);
}

/// This parses to date from generic days like `today`, `yesterday`,
/// `day before yesterday` or a specific_date.
DateTime dateFromGenericDay(GenericDay day, String? specificDate) {
  final now = DateTime.now();

  switch (day) {
    case .today:
      return dateOnly(now);

    case .yesterday:
      final yesterday = now.subtract(const Duration(days: 1));
      return dateOnly(yesterday);

    case .dayBeforeYesterday:
      final dayBeforeYesterday = now.subtract(const Duration(days: 2));
      return dateOnly(dayBeforeYesterday);

    case .specificDate:
      return dateOnly(DateTime.parse(specificDate ?? ''));
  }
}

MealType fromTime(DateTime date) {
  int currentHour = date.hour;
  if (currentHour < 10) {
    return .breakfast;
  } else if (currentHour < 16) {
    return .lunch;
  } else {
    return .dinner;
  }
}

List<String> habitsToDb(List<HealthHabits> healthHabits) {
  return healthHabits.map((h) => h.dbValue).toList();
}

List<HealthHabits> habitsFromDb(List<dynamic> healthHabits) {
  return healthHabits
      .map((habit) => HealthHabitsDbMapper.fromDB(habit))
      .toList();
}
