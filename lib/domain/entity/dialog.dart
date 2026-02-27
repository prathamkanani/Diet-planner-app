/// Different Dialogs to show for different parts of onboarding.
enum DialogEnum {
  fullNameDialog,
  healthHabitsDialog,
  mealPlanDialog,
  activityLevelDialog,
  mealPrefDialog,
  userDetailDialog,
  moreAboutDialog,
}

class DialogEntity {
  final DialogEnum dialog;
  final String title;
  final String? content;

  const DialogEntity({required this.dialog, required this.title, this.content});
}
