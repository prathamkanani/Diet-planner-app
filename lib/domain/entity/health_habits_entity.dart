import 'item.dart';

/// Health Habits Enum that contains all the types of health habits.
enum HealthHabitsEnum {
  eatMindfully("Eat Mindfully"),
  eatABalancedDiet("Eat A Balanced Diet"),
  eatMoreProtein("Eat More Protein");

  final String name;

  const HealthHabitsEnum(this.name);
}

/// Health Habits Entity
class HealthHabitsEntity {
  final int id;
  final HealthHabitsEnum healthHabit;

  const HealthHabitsEntity({
    required this.id,
    required this.healthHabit,
  });
}

Item healthToItem(HealthHabitsEntity hHabit) {
  return Item(id: hHabit.id, title: hHabit.healthHabit.name);
}

Set<int> selectedIds = {};

final List<HealthHabitsEntity> healthHabits = [
  const HealthHabitsEntity(id: 1, healthHabit: .eatMindfully),
  const HealthHabitsEntity(id: 2, healthHabit: .eatABalancedDiet),
  const HealthHabitsEntity(id: 3, healthHabit: .eatMoreProtein),
];
