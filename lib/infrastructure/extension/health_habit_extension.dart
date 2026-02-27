import '../../domain/entity/user_preferences.dart';

extension HealthHabitsDbMapper on HealthHabits {
  String get dbValue {
    switch (this) {
      case HealthHabits.eatMindfully:
        return 'eat_mindfully';
      case HealthHabits.eatABalancedDiet:
        return 'eat_a_balanced_diet';
      case HealthHabits.eatMoreProtein:
        return 'eat_more_protein';
      case HealthHabits.eatMoreFiber:
        return 'eat_more_fiber';
      case HealthHabits.eatMoreFruit:
        return 'eat_more_fruit';
      case HealthHabits.eatMoreVegetable:
        return 'eat_more_vegetable';
      case HealthHabits.iAmNotSure:
        return 'i_am_not_sure';
    }
  }

  static HealthHabits fromDB(String value) {
    switch (value) {
      case 'eat_mindfully':
        return .eatMindfully;
      case 'eat_a_balanced_diet':
        return .eatABalancedDiet;
      case 'eat_more_protein':
        return .eatMoreProtein;
      case 'eat_more_fiber':
        return .eatMoreFiber;
      case 'eat_more_fruit':
        return .eatMoreFruit;
      case 'eat_more_vegetable':
        return .eatMoreVegetable;
      case 'i_am_not_sure':
        return .iAmNotSure;
      default:
        throw ArgumentError('Unknown Health Habits DB value: $value');
    }
  }
}