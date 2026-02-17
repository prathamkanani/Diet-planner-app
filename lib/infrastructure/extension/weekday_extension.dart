/// Represents the days of the week.
enum Weekday {
  monday('Monday', 1),
  tuesday('Tuesday', 2),
  wednesday('Wednesday', 3),
  thursday('Thursday', 4),
  friday('Friday', 5),
  saturday('Saturday', 6),
  sunday('Sunday', 7);

  final int value;
  final String label;

  const Weekday(this.label, this.value);
}

/// TODO: Define getters or data members in the enum itself with itself
/// with using the advance enums

/// Extensions for providing utilities for [Weekday].
// extension WeekdayMapper on Weekday {
//   /// Maps a weekday to numeric value
//   int get value {
//     return switch (this) {
//       Weekday.monday => 1,
//       Weekday.tuesday => 2,
//       Weekday.wednesday => 3,
//       Weekday.thursday => 4,
//       Weekday.friday => 5,
//       Weekday.saturday => 6,
//       Weekday.sunday => 7,
//     };
//   }
//
//   /// Labels to show a weekday in the UI. (capitalized)
//   String get label {
//     return name[0].toUpperCase() + name.substring(1);
//   }
// }
