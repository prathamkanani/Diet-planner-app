class DailyMealLog {
  final DateTime date;
  final int mealsLogged;

  DailyMealLog({required this.date, required this.mealsLogged});
}

final List<DailyMealLog> logs = [
  DailyMealLog(
    date: DateTime.now().subtract(const Duration(days: 6)),
    mealsLogged: 3,
  ),
  DailyMealLog(
    date: DateTime.now().subtract(const Duration(days: 5)),
    mealsLogged: 2,
  ),
  DailyMealLog(
    date: DateTime.now().subtract(const Duration(days: 4)),
    mealsLogged: 1,
  ),
  DailyMealLog(
    date: DateTime.now().subtract(const Duration(days: 3)),
    mealsLogged: 3,
  ),
  DailyMealLog(
    date: DateTime.now().subtract(const Duration(days: 2)),
    mealsLogged: 0,
  ),
  DailyMealLog(
    date: DateTime.now().subtract(const Duration(days: 1)),
    mealsLogged: 2,
  ),
  DailyMealLog(date: DateTime.now(), mealsLogged: 3),
];
