import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/logic/dashboard/meal_load/meal_cubit.dart';
import '../../../application/logic/dashboard/meal_load/meal_state.dart';
import '../../../application/logic/dashboard/meal_log/meal_log_cubit.dart';
import '../../../application/service/app_data_service.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../config/app_spacing.dart';
import 'widgets/calorie_progress.dart';
import 'widgets/dashboard_date.dart';
import 'widgets/log_meal_button.dart';
import 'widgets/meal_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  final AppDataService appDataService = locator.get<AppDataService>();
  late final ScrollController scrollController;
  late final MealLoadingCubit mealLoadingCubit;
  late final MealLogCubit mealLogCubit;

  @override
  void initState() {
    super.initState();
    mealLoadingCubit = locator.get();
    mealLogCubit = locator.get();
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isNewUser = appDataService.isNewUser;
      if (isNewUser != null && isNewUser) {
        await mealLoadingCubit.saveGeneratedMealPlan(appDataService.jsonList);
        await mealLoadingCubit.fetchExistingMealPlan(
          appDataService.mealPlanId!,
          DateTime.now(),
        );
        return;
      }
      mealLoadingCubit.fetchExistingMealPlan(
        appDataService.mealPlanId!,
        DateTime.now(),
      );
    });
  }

  @override
  void dispose() {
    mealLoadingCubit.close();
    mealLogCubit.close();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: mealLoadingCubit),
        BlocProvider.value(value: mealLogCubit),
      ],
      child: Scaffold(
        backgroundColor: cs.secondaryContainer,
        body: Padding(
          padding: const .all(16.0),
          child: Column(
            mainAxisAlignment: .start,
            children: [
              const DashboardDate(),
              AppSpacing.h16,
              BlocBuilder<MealLoadingCubit, MealState>(
                bloc: mealLoadingCubit,
                builder: (context, state) {
                  return switch (state) {
                    MealLoadingState() => const Expanded(
                      child: Column(
                        children: [
                          Spacer(),
                          CircularProgressIndicator(),
                          Spacer(),
                        ],
                      ),
                    ),
                    MealLoadedState() => Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: CalorieProgress(
                              targetCalories:
                                  state.dailyMealList.targetCalories,
                              consumedCalories:
                                  state.dailyMealList.consumedCalories,
                            ),
                          ),
                          AppSpacing.h16,
                          Expanded(
                            child: DailyMealList(
                              dailyMealsEntity: state.dailyMealList,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MealNotFoundState() => Expanded(
                      child: Column(
                        children: [
                          const Spacer(),
                          Text(S.of(context).oopsNoDataFound),
                          const Spacer(),
                        ],
                      ),
                    ),
                    MealErrorState() => Expanded(
                      child: Column(
                        children: [
                          const Spacer(),
                          Text(state.error.toString()),
                          const Spacer(),
                        ],
                      ),
                    ),
                  };
                },
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: .centerFloat,
        floatingActionButton: const LogMealButton(),
      ),
    );
  }
}
