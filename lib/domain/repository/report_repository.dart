import '../entity/daily_meal_log_entity.dart';

/// This allows the user to show number of meals logged for the week.
abstract interface class ReportRepository {
  /// This fetches the number of meals logged between a time range.
  Future<List<DailyMealLogEntity>> fetchMealLogCount(
    DateTime start,
    DateTime end,
  );
}
