import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/daily_meal_log_entity.dart';
import '../../../domain/repository/report_repository.dart';
import 'report_state.dart';

/// This cubit is responsible for showing number of meals logged.
class ReportCubit extends Cubit<ReportState> {
  final ReportRepository repository;

  ReportCubit({required this.repository}) : super(const ReportLoadingState());

  /// This counts the total number of meals logged within a time range.
  Future<void> getMealLogCount(DateTime start, DateTime end) async {
    try {
      final List<DailyMealLogEntity> entity = await repository
          .fetchMealLogCount(start, end);
      emit(ReportLoadedState(entity: entity));
    } catch (e) {
      emit(ReportErrorState(e));
    }
  }
}
