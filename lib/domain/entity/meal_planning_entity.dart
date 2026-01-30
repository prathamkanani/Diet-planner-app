enum MealPlanning {
  never("Never"),
  rarely("Rarely"),
  occasionally("Occasionally"),
  frequently("Frequently"),
  always("Always");

  final String meal;

  const MealPlanning(this.meal);
}