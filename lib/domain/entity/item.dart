import 'meal_planning_entity.dart';

class Item {
  final int id;
  final String title;
  final String subtitle;
  final bool isSubtitle;

  const Item({
    required this.id,
    required this.title,
    this.subtitle = '',
    this.isSubtitle = false,
  });

  factory Item.fromMealPlanning(MealPlanningEntity meal) {
    return Item(id: meal.id, title: meal.mealPlanning.name);
  }
}
