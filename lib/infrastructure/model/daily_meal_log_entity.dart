import '../../domain/entity/daily_meal_log_entity.dart';

class DailyMealLogModel extends DailyMealLogEntity {
  const DailyMealLogModel({required super.date, required super.mealsLogged});

  factory DailyMealLogModel.fromEntity(DailyMealLogEntity entity) {
    return DailyMealLogModel(
      date: entity.date,
      mealsLogged: entity.mealsLogged,
    );
  }

  factory DailyMealLogModel.fromJson(Map<String, dynamic> json) {
    return DailyMealLogModel(
      date: DateTime.parse(json['day']),
      mealsLogged: json['meal_count'],
    );
  }
}
