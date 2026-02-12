import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/dashboard/meal_load/meal_cubit.dart';
import '../../../../application/logic/dashboard/meal_load/meal_state.dart';
import '../../../../generated/l10n.dart';
import '../../../config/app_spacing.dart';
import 'calorie_progress.dart';
import 'meal_list.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final MealLoadingCubit mealLoadingCubit = context.read<MealLoadingCubit>();
    return BlocBuilder<MealLoadingCubit, MealState>(
      bloc: mealLoadingCubit,
      builder: (context, state) {
        return switch (state) {
          MealLoadingState() => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          MealLoadedState() => SliverPadding(
            padding: const .symmetric(horizontal: 16),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: CalorieProgress(
                    targetCalories: state.dailyMealList.targetCalories,
                    consumedCalories: state.dailyMealList.consumedCalories,
                  ),
                ),
                const SliverToBoxAdapter(child: AppSpacing.h16),
                DailyMealList(dailyMealsEntity: state.dailyMealList),
              ],
            ),
          ),
          MealNotFoundState() => SliverFillRemaining(
            child: Center(child: Text(S.of(context).oopsNoDataFound)),
          ),
          MealErrorState() => SliverFillRemaining(
            child: Center(child: Text(state.error.toString())),
          ),
        };
      },
    );
  }
}
