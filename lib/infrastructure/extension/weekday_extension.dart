import '../../domain/eum/weekday.dart';

extension WeekdayMapper on Weekday {
  int get value {
    return switch (this) {
      Weekday.monday => 1,
      Weekday.tuesday => 2,
      Weekday.wednesday => 3,
      Weekday.thursday => 4,
      Weekday.friday => 5,
      Weekday.saturday => 6,
      Weekday.sunday => 7,
    };
  }

  String get label {
    return name[0].toUpperCase() + name.substring(1);
  }
}
