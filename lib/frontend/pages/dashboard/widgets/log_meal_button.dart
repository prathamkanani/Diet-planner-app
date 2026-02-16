import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/dashboard/meal_load/meal_cubit.dart';
import '../../../../application/logic/dashboard/meal_log/meal_log_cubit.dart';
import '../../../../application/logic/dashboard/meal_log/meal_log_state.dart';
import '../../../../generated/l10n.dart';
import '../../../../infrastructure/extension/context_extension.dart';

class LogMealButton extends StatelessWidget {
  const LogMealButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final TextTheme textTheme = TextTheme.of(context);
    final MealLogCubit mealLogCubit = context.read<MealLogCubit>();

    return BlocBuilder<MealLogCubit, MealLogState>(
      bloc: mealLogCubit,
      buildWhen: (prev, next) =>
          // Upon selection of a meal to log
          prev is MealLogInitialState ||
          // Upon unselection of a meal
          (prev is MealSelectedState && next is MealLogInitialState) ||
          // Once the meal is logged in.
          (prev is MealLogSuccessState && next is MealLoggingState) ||
          // After one meal logging, selecting the other meal.
          (prev is MealLoggingState && next is MealSelectedState),
      builder: (context, state) {
        if (state is MealSelectedState) {
          return SizedBox(
            height: 44,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FilledButton(
                onPressed: () => mealLogCubit.logMeal(DateTime.now()),
                child: Center(
                  child: BlocConsumer<MealLogCubit, MealLogState>(
                    bloc: mealLogCubit,
                    listener: (context, state) {
                      if (state is MealLogSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(S.of(context).mealLoggedSuccessfully),
                            duration: const Duration(milliseconds: 500),
                          ),
                        );
                        context.read<MealLoadingCubit>().fetchExistingMealPlan(
                          DateTime.now(),
                        );
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
                    buildWhen: (_, next) => next is MealLoggingState,
                    builder: (context, state) {
                      if (state is MealLoggingState && state.isLogging) {
                        return CircularProgressIndicator(color: cs.onPrimary);
                      }
                      return Text(
                        S.of(context).logMeal,
                        style: textTheme.bodyLarge?.copyWith(
                          color: cs.onPrimary,
                          fontWeight: .w600,
                        ),
                      );
                    },
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
