import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/dashboard/meal_log/meal_log_cubit.dart';
import '../../../../application/logic/dashboard/meal_log/meal_log_state.dart';
import '../../../../domain/entity/meal_entity.dart';
import '../../../../infrastructure/extension/context_extension.dart';

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
                ? const Text('Forgot to log!')
                : const Text('Logged!'),
            content: isPast
                ? const Text('Sorry, cannot log past meals.')
                : const Text(
                    'Already logged once. Cannot change or log again!',
                  ),
            actions: [
              TextButton(
                onPressed: context.pop,
                child: Text('Ok', style: textTheme.bodyLarge),
              ),
            ],
          );
        },
      );
    }

    return BlocBuilder<MealLogCubit, MealLogState>(
      bloc: cubit,
      // TODO: Stop building it when its loading and build when its logged.
      buildWhen: (_, next) {
        return next is! MealLoggingState;
      },
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
                ? () => cubit.unselectedMeal(mealType, meal)
                : () => cubit.selectedMeal(mealType, meal),
            child: Card(
              color: cs.secondaryContainer,
              child: ListTile(
                title: Text(meal.dish, style: textTheme.bodyMedium),
                subtitle: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text('Calories ${meal.calorie} kcal'),
                    Text('Protein ${meal.protein} g'),
                    Text('Carbs ${meal.carbs} g'),
                    Text('Fat ${meal.fat} g'),
                  ],
                ),
                trailing: isPast && !isLogged
                    ? Icon(
                        Icons.circle_outlined,
                        color: cs.primaryContainer.withValues(alpha: 0.3),
                      )
                    : isLogged
                    ? Icon(
                        Icons.check_circle,
                        color: cs.primary.withValues(alpha: 0.3),
                      )
                    : isSelected
                    ? Icon(Icons.check_circle, color: cs.primary)
                    : Icon(
                        Icons.circle_outlined,
                        color: isTypeLogged
                            ? cs.primaryContainer.withValues(alpha: 0.3)
                            : cs.primaryContainer,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
