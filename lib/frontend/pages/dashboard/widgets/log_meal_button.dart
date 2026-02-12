import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/dashboard/meal_load/meal_cubit.dart';
import '../../../../application/logic/dashboard/meal_log/meal_log_cubit.dart';
import '../../../../application/logic/dashboard/meal_log/meal_log_state.dart';
import '../../../../application/service/app_data_service.dart';
import '../../../../infrastructure/app_injector.dart';
import '../../../../infrastructure/extension/context_extension.dart';

class LogMealButton extends StatelessWidget {
  const LogMealButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final TextTheme textTheme = TextTheme.of(context);
    final MealLogCubit mealLogCubit = context.read<MealLogCubit>();
    final AppDataService appDataService = locator.get();

    return BlocBuilder(
      bloc: mealLogCubit,
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
                          const SnackBar(
                            content: Text('Meal logged successfully!'),
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                        // TODO: fetching meals for the day everytime user logs(should not be).
                        context.read<MealLoadingCubit>().fetchExistingMealPlan(
                          appDataService.mealPlanId!,
                          DateTime.now(),
                        );
                      }

                      if (state is MealLogErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to log!'),
                            duration: Duration(milliseconds: 500),
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
                        'Log Meal!',
                        style: textTheme.bodyLarge?.copyWith(
                          color: cs.onPrimary,
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
