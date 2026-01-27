import 'item.dart';

enum HealthHabitsEnum {
  eatMindfully("Eat Mindfully"),
  eatABalancedDiet("Eat A Balanced Diet"),
  eatMoreProtein("Eat More Protein");

  final String name;

  const HealthHabitsEnum(this.name);
}

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
