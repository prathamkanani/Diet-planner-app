/*num ActivityLevelTitle {
  notVeryActive("Not Very Active"),
  lightlyActive("Lightly Active"),
  active("Active"),
  veryActive("Very Active");

  final String title;

  const ActivityLevelTitle(this.title);
}

enum ActivityLevelSubtitle {
  notVeryActive("Spend most of the day sitting (e.g., desk job)."),
  lightlyActive(
    "Spend a good part of the day on your feet (e.g., teacher, salesperson).",
  ),
  active(
    "Spend a good part of the day doing some physical activity (e.g., food server, postal carrier).",
  ),
  veryActive(
    "Spend a good part of the day doing heavy physical activity (e.g., bike messenger, carpenter).",
  );

  final String subtitle;

  const ActivityLevelSubtitle(this.subtitle);
}
*/

enum ActivityLevel {
  low('Not Very Active'),
  medium('Lightly Active'),
  high('Very Active');

  final String title;

  const ActivityLevel(this.title);
}

/*
// class ActivityLevelEntity {
//   final int id;
//   final ActivityLevelTitle title;
//   final ActivityLevelSubtitle subtitle;
//
//   const ActivityLevelEntity({
//     required this.id,
//     required this.title,
//     required this.subtitle,
//   });
// }
// */
