import '../../domain/entity/daily_meal_log_entity.dart';
import '../../domain/repository/report_repository.dart';
import '../source/report_source.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportSource source;

  const ReportRepositoryImpl({required this.source});

  @override
  Future<List<DailyMealLogEntity>> fetchMealLogCount(
    DateTime start,
    DateTime end,
  ) async {
    return await source.getMealLogCount(start, end);
  }
}
