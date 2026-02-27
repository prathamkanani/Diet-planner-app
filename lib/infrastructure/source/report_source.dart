import 'package:supabase_flutter/supabase_flutter.dart';
import '../../application/service/app_data_service.dart';
import '../../domain/entity/daily_meal_log_entity.dart';
import '../app_injector.dart';
import '../model/daily_meal_log_entity.dart';
import '../utils/helpers.dart';

abstract interface class ReportSource {
  Future<List<DailyMealLogEntity>> getMealLogCount(
    DateTime start,
    DateTime end,
  );
}

class ReportRemoteSource implements ReportSource {
  final SupabaseClient supabase;

  ReportRemoteSource(this.supabase);

  final AppDataService appDataService = locator.get();

  @override
  Future<List<DailyMealLogEntity>> getMealLogCount(
    DateTime start,
    DateTime end,
  ) async {
    final List<Map<String, dynamic>> result = await supabase.rpc(
      'get_meal_log_report',
      params: {
        'p_user_id': appDataService.userId,
        'p_start': start.toIso8601String(),
        'p_end': end.toIso8601String(),
      },
    );

    final Map<DateTime, DailyMealLogEntity> logMap = {
      for (final json in result)
        dateOnly(DailyMealLogModel.fromJson(json).date):
            DailyMealLogModel.fromJson(json),
    };

    final int days = end.difference(start).inDays + 1;

    return List.generate(days, (i) {
      final date = dateOnly(start.add(Duration(days: i)));

      return logMap[date] ?? DailyMealLogEntity(date: date, mealsLogged: 0);
    });
  }
}
