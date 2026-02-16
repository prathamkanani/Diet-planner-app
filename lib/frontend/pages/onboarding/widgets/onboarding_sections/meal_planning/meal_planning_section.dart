import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../application/logic/onboarding/onboarding_cubit.dart';
import '../../../../../../domain/entity/onboarding_entity.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../config/app_spacing.dart';
import 'check_circle_container.dart';

/// Contains:
///
/// How often does a user plan meals in advance?
///
/// never
/// rarely
/// occasionally
/// frequently
/// always
class MealPlanningSection extends StatefulWidget {
  final void Function(MealPlanning) advanceMealPlanning;
  const MealPlanningSection({super.key, required this.advanceMealPlanning});

  @override
  State<MealPlanningSection> createState() => _MealPlanningSectionState();
}

class _MealPlanningSectionState extends State<MealPlanningSection> {
  late final OnboardingCubit cubit = context.read<OnboardingCubit>();

  void _handleTap(MealPlanning meal) {
    setState(() {
      if(cubit.mealPlan == null) {
        cubit.mealPlan = meal;
        return;
      }
      cubit.mealPlan = (cubit.mealPlan == meal) ? null : meal;
    });
  }

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
              isSelected? widget.advanceMealPlanning(cubit.mealPlan!) : null;
              return CheckCircleContainer<MealPlanning>(
                title: meal.meal,
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
}
