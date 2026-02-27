import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../../application/logic/onboarding/onboarding_cubit.dart';
import '../../../../../../domain/entity/user_preferences.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../config/app_spacing.dart';
import 'check_circle_container.dart';

class MealPlanningSection extends StatefulWidget {
  final void Function(MealPlanning) advanceMealPlanning;

  const MealPlanningSection({super.key, required this.advanceMealPlanning});

  @override
  State<MealPlanningSection> createState() => _MealPlanningSectionState();
}

class _MealPlanningSectionState extends State<MealPlanningSection> {
  late final OnboardingCubit cubit = context.read<OnboardingCubit>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).howOftenDoYouPlanYourMealsInAdvance,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpacing.h24,
        Flexible(
          child: ListView(
            padding: EdgeInsets.zero,
            children: MealPlanning.values.map((meal) {
              bool isSelected = cubit.mealPlan == meal;
              isSelected ? widget.advanceMealPlanning(cubit.mealPlan!) : null;
              return CheckCircleContainer<MealPlanning>(
                title: Intl.message(meal.name),
                isSelected: isSelected,
                onTap: _handleTap,
                value: meal,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  //region Custom Methods
  void _handleTap(MealPlanning meal) {
    setState(() {
      cubit.mealPlan = (cubit.mealPlan == meal) ? null : meal;
    });
  }

  //endregion
}
