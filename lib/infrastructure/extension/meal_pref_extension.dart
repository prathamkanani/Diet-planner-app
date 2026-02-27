import '../../domain/entity/user_preferences.dart';

extension MealPrefDbMapper on MealPreferences {
  String get dbValue {
    switch (this) {
      case MealPreferences.vegetarian:
        return 'vegetarian';
      case MealPreferences.nonVegetarian:
        return 'non_vegetarian';
      case MealPreferences.vegan:
        return 'vegan';
      case MealPreferences.pescatarian:
        return 'pescatarian';
    }
  }

  static MealPreferences fromDb(String value) {
    switch (value) {
      case 'vegetarian':
        return .vegetarian;
      case 'non_vegetarian':
        return .nonVegetarian;
      case 'vegan':
        return .vegan;
      case 'pescatarian':
        return .pescatarian;
      default:
        throw ArgumentError('Unknow Meal Preference DB value: $value');
    }
  }
}