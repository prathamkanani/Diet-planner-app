enum ActivityLevelTitle {
  notVeryActive("Not Very Active"),
  lightlyActive("Lightly Active"),
  active("Active"),
  veryActive("Very Active");

  final String title;

  const ActivityLevelTitle(this.title);
}

enum ActivityLevelSubtitle {
  notVeryActive("Spend most of the day sitting (e.g., desk job)."),
  lightlyActive("Spend most of the day sitting (e.g., desk job)."),
  active("Spend most of the day sitting (e.g., desk job)."),
  veryActive("Spend most of the day sitting (e.g., desk job).");

  final String subtitle;

  const ActivityLevelSubtitle(this.subtitle);
}

class ActivityLevelEntity {
  final int id;
  final ActivityLevelTitle title;
  final ActivityLevelSubtitle subtitle;

  const ActivityLevelEntity({
    required this.id,
    required this.title,
    required this.subtitle,
  });
}

