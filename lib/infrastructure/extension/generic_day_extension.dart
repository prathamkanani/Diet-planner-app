import '../service/gemini_functional_service.dart';

extension GenericDayMapper on GenericDay {
  static GenericDay fromLabel(String label) {
    return GenericDay.values.firstWhere(
      (e) => e.label == label,
      orElse: () => throw ArgumentError('Unknown GenericDay: $label'),
    );
  }
}
