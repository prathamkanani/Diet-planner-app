import 'item.dart';

enum MealPlanningEnum {
  never("Never"),
  rarely("Rarely"),
  occasionally("Occasionally"),
  frequently("Frequently"),
  always("Always");

  final String name;

  const MealPlanningEnum(this.name);
}

class MealPlanningEntity {
  final int id;
  final MealPlanningEnum mealPlanning;

  const MealPlanningEntity({required this.id, required this.mealPlanning});
}

Item mealToItem(MealPlanningEntity meal) {
  return Item(id: meal.id, title: meal.mealPlanning.name);
}

int? selectedItemId;
final List<MealPlanningEntity> mealPlans = [
  const MealPlanningEntity(id: 1, mealPlanning: .never),
  const MealPlanningEntity(id: 2, mealPlanning: .rarely),
  const MealPlanningEntity(id: 3, mealPlanning: .occasionally),
  const MealPlanningEntity(id: 4, mealPlanning: .frequently),
  const MealPlanningEntity(id: 5, mealPlanning: .always),
];