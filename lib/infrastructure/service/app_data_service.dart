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

  @override
  DateTime? get planStartDate {
    final String? dateIso = prefs.getString("plan_start_date");
    return DateTime.tryParse(dateIso ?? '');
  }

  @override
  set planStartDate(final DateTime? date) {
    if (date != null) {
      prefs.setString('plan_start_date', date.toIso8601String());
    }
  }

  /// Getter for checking active or non-active user.
  @override
  bool get isUserLoggedIn {
    return prefs.getBool('isUserLoggedIn') ?? false;
  }

  /// Setter for checking active or non-active user.
  @override
  set isUserLoggedIn(bool value) {
    prefs.setBool('isUserLoggedIn', value);
  }
}
