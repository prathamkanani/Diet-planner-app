import 'item.dart';

enum ActivityLevelEnumTitle {
  notVeryActive("Not Very Active"),
  lightlyActive("Lightly Active"),
  active("Active"),
  veryActive("Very Active");

  final String name;

  const ActivityLevelEnumTitle(this.name);
}

enum ActivityLevelEnumSubtitle {
  notVeryActive("Spend most of the day sitting (e.g., desk job)."),
  lightlyActive("Spend most of the day sitting (e.g., desk job)."),
  active("Spend most of the day sitting (e.g., desk job)."),
  veryActive("Spend most of the day sitting (e.g., desk job).");

  final String name;

  const ActivityLevelEnumSubtitle(this.name);
}

class ActivityLevelEntity {
  final int id;
  final ActivityLevelEnumTitle title;
  final ActivityLevelEnumSubtitle subtitle;

  const ActivityLevelEntity({
    required this.id,
    required this.title,
    required this.subtitle,
  });
}

Item activityToItem(ActivityLevelEntity activity) {
  return Item(
    id: activity.id,
    title: activity.title.name,
    isSubtitle: true,
    subtitle: activity.subtitle.name,
  );
}

int? selectedItemId;
final List<ActivityLevelEntity> activityLevels = [
  const ActivityLevelEntity(
    id: 1,
    title: ActivityLevelEnumTitle.notVeryActive,
    subtitle: ActivityLevelEnumSubtitle.notVeryActive,
  ),
];