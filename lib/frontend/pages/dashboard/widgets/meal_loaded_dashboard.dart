import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/meal_log/meal_log_cubit.dart';
import '../../../../application/logic/meal_log/meal_log_state.dart';
import '../../../../domain/entity/daily_meals_entity.dart';
import '../../../../domain/entity/meal_entity.dart';
import '../../../../domain/entity/meal_option_list_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../../infrastructure/extension/context_extension.dart';
import '../../../../infrastructure/utils/helpers.dart';
import '../../../config/app_spacing.dart';
import 'custom_progress_indicator.dart';
import 'macro_progress.dart';
import 'meal_option_list.dart';
import 'meal_tab_bar.dart';

class MealLoadedDashboard extends StatefulWidget {
  final DailyMealsEntity dailyMealsEntity;

  const MealLoadedDashboard({super.key, required this.dailyMealsEntity});

  @override
  State<MealLoadedDashboard> createState() => _MealLoadedDashboardState();
}

class _MealLoadedDashboardState extends State<MealLoadedDashboard>
    with TickerProviderStateMixin {
  late final TabController tabController;
  late final DailyMealsEntity dailyMealEntity = widget.dailyMealsEntity;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void checkMealType(MealType mealType) {
    if (mealType == fromTime(dailyMealEntity.currentDate) &&
        mealType == .breakfast) {
      tabController.animateTo(0);
    } else if (mealType == fromTime(dailyMealEntity.currentDate) &&
        mealType == .lunch) {
      tabController.animateTo(1);
    } else if (mealType == fromTime(dailyMealEntity.currentDate)) {
      tabController.animateTo(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final MealLogCubit mealLogCubit = context.read<MealLogCubit>();

    return SliverMainAxisGroup(
      slivers: [
        BlocBuilder<MealLogCubit, MealLogState>(
          bloc: mealLogCubit,
          builder: (context, state) {
            return IndicatorCard(dailyMealsEntity: dailyMealEntity);
          },
        ),
        const SliverToBoxAdapter(child: AppSpacing.h16),
        BlocBuilder(
          bloc: mealLogCubit,
          buildWhen: (prev, next) {
            return next is MealLogInitialState;
          },
          builder: (context, state) {
            return SliverMainAxisGroup(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MealTabBarHeader(controller: tabController),
                ),
                const SliverToBoxAdapter(child: AppSpacing.h16),
                // TODO: How to remove the extra space?
                SliverFillRemaining(
                  child: TabBarView(
                    controller: tabController,
                    children:
                        dailyMealEntity.mealOptionListEntity.map((
                              final MealOptionListEntity mealOption,
                            ) {
                              final MealType mealType = mealOption.mealType;
                              checkMealType(mealType);
                              return Column(
                                mainAxisSize: .min,
                                mainAxisAlignment: .start,
                                children: [
                                  Text(
                                    mealOption.mealType.mealType,
                                    style: textTheme.titleLarge,
                                  ),
                                  AppSpacing.h16,
                                  Expanded(
                                    child: MealOptionList(
                                      loggedMeals: dailyMealEntity.loggedMeal,
                                      mealOptionListEntity: mealOption,
                                      currentDate: dailyMealEntity.currentDate,
                                    ),
                                  ),
                                ],
                              );
                            }).toList()
                            as List<Widget>,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class IndicatorCard extends StatelessWidget {
  const IndicatorCard({super.key, required this.dailyMealsEntity});

  final DailyMealsEntity dailyMealsEntity;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const .all(16),
        child: Column(
          children: [
            CalorieProgressIndicator(dailyMealsEntity: dailyMealsEntity),
            AppSpacing.h16,
            MacroProgress(entity: dailyMealsEntity),
          ],
        ),
      ),
    );
  }
}

class CalorieProgressIndicator extends StatelessWidget {
  final DailyMealsEntity dailyMealsEntity;

  const CalorieProgressIndicator({super.key, required this.dailyMealsEntity});

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.45,
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomProgressIndicator(
          target: dailyMealsEntity.targetCalories,
          consumed: dailyMealsEntity.consumedCalories,
          subtitle: S.of(context).kcalLeft,
          color: cs.primary,
          isCalorieIndicator: true,
        ),
      ),
    );
  }
}
