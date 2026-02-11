import '../../domain/entity/meal_entity.dart';
import '../../domain/repository/meal_logger_repository.dart';
import '../source/meal_log_source.dart';

class MealLoggerRepositoryImpl implements MealLoggerRepository {
  final MealLogSource source;

  const MealLoggerRepositoryImpl(this.source);

  @override
  Future<void> logMeal(
    Map<MealType, MealEntity> logMeals,
    DateTime date,
  ) async {
    await source.logMeal(logMeals, date);
  }
}
