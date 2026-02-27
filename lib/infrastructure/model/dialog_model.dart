import 'package:intl/intl.dart';
import '../../domain/entity/dialog.dart';

/// This maps the dialog enum to its dialog entity for showing it in the UI.
DialogEntity dialogMapper(DialogEnum dialog) {
  switch (dialog) {
    case DialogEnum.fullNameDialog:
      return DialogEntity(
        dialog: dialog,
        title: Intl.message("fullNameDialogTitle"),
        content: Intl.message("fullNameDialogContent")
      );
    case DialogEnum.healthHabitsDialog:
      return DialogEntity(dialog: dialog, title: '');
    case DialogEnum.mealPlanDialog:
      return DialogEntity(
        dialog: dialog,
        title: Intl.message("mealPlanDialogTitle"),
        content: Intl.message("mealPlanDialogContent")
      );
    case DialogEnum.activityLevelDialog:
      return DialogEntity(
        dialog: dialog,
        title: Intl.message("activityLevelDialogTitle"),
        content: Intl.message("activityLevelDialogContent")
      );
    case DialogEnum.mealPrefDialog:
      return DialogEntity(
        dialog: dialog,
        title: Intl.message("mealPrefDialogTitle"),
        content: Intl.message("mealPrefDialogContent")
      );
    case DialogEnum.userDetailDialog:
      return DialogEntity(
        dialog: dialog,
        title: Intl.message("userDetailDialogTitle"),
      );
    case DialogEnum.moreAboutDialog:
      return DialogEntity(
        dialog: dialog,
        title: Intl.message("userDetailDialogTitle"),
      );
  }
}
