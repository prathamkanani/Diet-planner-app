/// Number of meals logged on a certain date.
class DailyMealLogEntity {
  /// On a particular day
  final DateTime date;

  /// Number of meals logged on that day
  final int mealsLogged;

  const DailyMealLogEntity({required this.date, required this.mealsLogged});
}
