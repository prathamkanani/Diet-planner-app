import '../../../domain/entity/daily_meal_log_entity.dart';

sealed class ReportState {
  const ReportState();
}

final class ReportLoadingState extends ReportState {
  const ReportLoadingState();
}

final class ReportLoadedState extends ReportState {
  final List<DailyMealLogEntity> entity;

  const ReportLoadedState({required this.entity});
}

final class ReportErrorState extends ReportState {
  final Object? error;

  const ReportErrorState(this.error);
}
