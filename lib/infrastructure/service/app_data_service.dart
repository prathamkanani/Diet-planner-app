// © Meditab Software 2025

import 'package:shared_preferences/shared_preferences.dart';
import '../../application/service/app_data_service.dart';
import '../app_injector.dart';

final class AppDataServiceImpl extends AppDataService {

  @override
  String? get userId {
    return locator.get<SharedPreferences>().getString("user_id");
  }

  @override
  set userId(final String? userId) {
    if (userId == null) {
      locator.get<SharedPreferences>().remove("user_id");
    } else {
      locator.get<SharedPreferences>().setString("user_id", userId);
    }
  }
}
