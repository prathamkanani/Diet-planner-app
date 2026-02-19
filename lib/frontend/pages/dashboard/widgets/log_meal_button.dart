import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/meal_log/meal_log_cubit.dart';
import '../../../../application/logic/meal_log/meal_log_state.dart';
import '../../../../generated/l10n.dart';
import '../../../../infrastructure/extension/context_extension.dart';

class LogMealButton extends StatelessWidget {
  const LogMealButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final TextTheme textTheme = TextTheme.of(context);
    final MealLogCubit mealLogCubit = context.read<MealLogCubit>();

    return BlocConsumer<MealLogCubit, MealLogState>(
      bloc: mealLogCubit,
      listener: (context, state) {
        if (state is MealUndoAvailableState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).mealLoggedSuccessfully),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  mealLogCubit.didPressUndo();
                },
              ),
              duration: const Duration(seconds: 10),
              behavior: .floating,
            ),
          );
        } else if(state is MealLogSuccessState) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }

        if (state is MealLogErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).failedToLog),
              duration: const Duration(milliseconds: 500),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is MealSelectedState || state is MealLoggingState) {
          return SizedBox(
            height: 44,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FilledButton(
                onPressed: () => mealLogCubit.logMeals(),
                child: Center(
                  child: (state is MealLoggingState)
                      ? CircularProgressIndicator(color: cs.onPrimary)
                      : Text(
                          S.of(context).logMeal,
                          style: textTheme.bodyLarge?.copyWith(
                            color: cs.onPrimary,
                            fontWeight: .w600,
                          ),
                        ),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
