import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/meal_log/meal_log_cubit.dart';
import '../../../../application/logic/meal_log/meal_log_state.dart';
import '../../../../domain/entity/meal_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../../infrastructure/extension/context_extension.dart';
import '../../../config/app_color_palette.dart';
import 'nutrients_row.dart';

class ExpandableMealOption extends StatelessWidget {
  final MealType mealType;
  final MealEntity meal;
  final bool isLogged;
  final bool isTypeLogged;
  final bool isPast;

  const ExpandableMealOption({
    super.key,
    required this.mealType,
    required this.meal,
    required this.isLogged,
    required this.isTypeLogged,
    required this.isPast,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final TextTheme textTheme = TextTheme.of(context);
    final MealLogCubit cubit = context.read<MealLogCubit>();

    Future<void> dialogBuilder(BuildContext context, bool isPast) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: isPast
                ? Text(S.of(context).forgotToLog)
                : Text(S.of(context).logged),
            content: isPast
                ? Text(S.of(context).sorryCannotLogPastMeals)
                : Text(S.of(context).alreadyLoggedOnceCannotChangeOrLogAgain),
            actions: [
              TextButton(
                onPressed: context.pop,
                child: Text(S.of(context).ok, style: textTheme.bodyLarge),
              ),
            ],
          );
        },
      );
    }

    return BlocBuilder<MealLogCubit, MealLogState>(
      bloc: cubit,
      builder: (context, state) {
        bool isSelected = false;
        if (state is MealSelectedState) {
          isSelected = state.selectedMeals.entries.any(
            (e) => e.key == mealType && e.value == meal,
          );
        }
        return Padding(
          padding: const .only(bottom: 4.0),
          child: GestureDetector(
            onTap: isPast
                ? () => dialogBuilder(context, true)
                : isTypeLogged
                ? () => dialogBuilder(context, false)
                : isSelected
                ? () => cubit.unselectMeal(mealType)
                : () => cubit.selectMeal(mealType, meal),
            child: Container(
              margin: const .symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isPast && !isTypeLogged
                    ? cs.tertiaryContainer
                    : isTypeLogged && isLogged
                    ? cs.primary.withValues(alpha: 0.3)
                    : isTypeLogged && !isLogged
                    ? cs.tertiaryContainer
                    : isSelected
                    ? cs.primary.withValues(alpha: 0.3)
                    : cs.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? cs.primary
                      : cs.onPrimaryContainer.withValues(alpha: 0.5),
                  width: 2,
                ),
              ),
              child: ListTile(
                title: Text(
                  meal.dish,
                  style: textTheme.bodyLarge?.copyWith(fontWeight: .bold),
                ),
                subtitle: NutrientsRow(mealEntity: meal),
                trailing: isPast && !isLogged
                    ? Icon(
                        Icons.cancel,
                        color: AppColorPalette.red.withValues(alpha: 0.8),
                      )
                    : isLogged
                    ? Icon(
                        Icons.check_circle,
                        color: cs.primary.withValues(alpha: 0.7),
                      )
                    : isSelected
                    ? Icon(Icons.check_circle, color: cs.primary)
                    : isTypeLogged
                    ? Icon(
                        Icons.cancel,
                        color: AppColorPalette.red.withValues(alpha: 0.8),
                      )
                    : Icon(
                        Icons.circle_outlined,
                        color: cs.onPrimaryContainer.withValues(alpha: 0.5),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
