import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
  final MealLoggerEntity mealLoggerEntity;
  final List<MealOptionListEntity> meals;

  const MealLoadedDashboard({
    super.key,
    required this.mealLoggerEntity,
    required this.meals,
  });

  @override
  State<MealLoadedDashboard> createState() => _MealLoadedDashboardState();
}

class _MealLoadedDashboardState extends State<MealLoadedDashboard>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  int count = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return setTab();
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void setTab() {
    final DateTime currentDate = widget.mealLoggerEntity.currentDate;
    return switch (fromTime(currentDate)) {
      MealType.breakfast => tabController.animateTo(0),
      MealType.lunch => tabController.animateTo(1),
      MealType.dinner => tabController.animateTo(2),
    };
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
            return IndicatorCard(mealLoggerEntity: widget.mealLoggerEntity);
          },
        ),
        const SliverToBoxAdapter(child: AppSpacing.h16),
        BlocBuilder<MealLogCubit, MealLogState>(
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
                    children: widget.meals.map((final mealOption) {
                      return Column(
                        mainAxisSize: .min,
                        mainAxisAlignment: .start,
                        children: [
                          Text(
                            Intl.message(mealOption.mealType.name),
                            style: textTheme.titleLarge,
                          ),
                          AppSpacing.h16,
                          Text(S.of(context).selectAnyOneOptionToLog),
                          AppSpacing.h08,
                          Expanded(
                            child: MealOptionList(
                              loggedMeals: widget.mealLoggerEntity.loggedMeal,
                              mealOptionListEntity: mealOption,
                              currentDate: widget.mealLoggerEntity.currentDate,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
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
  const IndicatorCard({super.key, required this.mealLoggerEntity});

  final MealLoggerEntity mealLoggerEntity;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const .all(16),
        child: Column(
          children: [
            CalorieProgressIndicator(mealLoggerEntity: mealLoggerEntity),
            AppSpacing.h16,
            MacroProgress(entity: mealLoggerEntity),
          ],
        ),
      ),
    );
  }
}

class CalorieProgressIndicator extends StatelessWidget {
  final MealLoggerEntity mealLoggerEntity;

  const CalorieProgressIndicator({super.key, required this.mealLoggerEntity});

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.45,
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomProgressIndicator(
          target: mealLoggerEntity.targetCalories,
          consumed: mealLoggerEntity.consumedCalories,
          subtitle: S.of(context).kcalLeft,
          color: cs.primary,
          isCalorieIndicator: true,
        ),
      ),
    );
  }
}
