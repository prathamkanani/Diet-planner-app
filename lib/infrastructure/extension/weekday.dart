/// Represents the days of the week.
enum Weekday {
  monday(1),
  tuesday(2),
  wednesday(3),
  thursday(4),
  friday(5),
  saturday(6),
  sunday(7);

  final int value;

  const Weekday(this.value);
}
