// © Meditab Software 2025

import 'package:shared_preferences/shared_preferences.dart';
import '../../application/service/app_data_service.dart';
import '../app_injector.dart';

final class AppDataServiceImpl extends AppDataService {
  final SharedPreferences prefs = locator.get<SharedPreferences>();

  /// Getter for userId
  @override
  String? get userId {
    return prefs.getString("user_id");
  }

  /// Setter for userId
  @override
  set userId(final String? userId) {
    if (userId == null) {
      prefs.remove("user_id");
    } else {
      prefs.setString("user_id", userId);
    }
  }

  /// Setter for checking active or non-active user.
  @override
  set isUserLoggedIn(bool value) {
    prefs.setBool('isUserLoggedIn', value);
  }

  /// Getter for checking active or non-active user.
  @override
  bool get isUserLoggedIn {
    return prefs.getBool('isUserLoggedIn') ?? false;
  }

  /// Getter for mealPlanId
  @override
  String? get mealPlanId {
    return prefs.getString("meal_plan_id");
  }

  /// Setter for mealPlanId
  @override
  set mealPlanId(final String? mealPlanId) {
    final currentId = prefs.getString("meal_plan_id");

    if(mealPlanId == null) {
      prefs.remove("meal_plan_id");
      return;
    }

    if(mealPlanId != currentId) {
      prefs.setString("meal_plan_id", mealPlanId);
    }
  }

  @override
  String? get breakfastLogId {
    return prefs.getString("breakfast_id");
  }

  @override
  set breakfastLogId(final String? breakfastLogId) {
    if (breakfastLogId == null) {
      prefs.remove("breakfast_id");
    } else {
      prefs.setString("breakfast_id", breakfastLogId);
    }
  }

  @override
  String? get lunchLogId {
    return prefs.getString("lunch_id");
  }

  @override
  set lunchLogId(final String? lunchLogId) {
    if (lunchLogId == null) {
      prefs.remove("lunch_id");
    } else {
      prefs.setString("lunch_id", lunchLogId);
    }
  }

  @override
  String? get dinnerLogId {
    return prefs.getString("dinner_id");
  }

  @override
  set dinnerLogId(final String? dinnerLogId) {
    if (dinnerLogId == null) {
      prefs.remove("dinner_id");
    } else {
      prefs.setString("dinner_id", dinnerLogId);
    }
  }
}
