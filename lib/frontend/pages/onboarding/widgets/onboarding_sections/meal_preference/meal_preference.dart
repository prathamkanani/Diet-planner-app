import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../../application/logic/onboarding/onboarding_cubit.dart';
import '../../../../../../domain/entity/user_preferences.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../config/app_spacing.dart';
import '../meal_planning/check_circle_container.dart';

class MealPreferenceView extends StatefulWidget {
  final void Function(MealPreferences) selectedMealPref;

  const MealPreferenceView({super.key, required this.selectedMealPref});

  @override
  State<MealPreferenceView> createState() => _MealPreferenceViewState();
}

class _MealPreferenceViewState extends State<MealPreferenceView> {
  late final OnboardingCubit cubit = context.read<OnboardingCubit>();

  void _handleTap(MealPreferences mealPref) {
    setState(() {
      cubit.mealPref = (cubit.mealPref == mealPref) ? null : mealPref;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);

    return Column(
      mainAxisAlignment: .start,
      children: [
        Text(
          S.of(context).primaryDietPreference,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpacing.h24,
        Flexible(
          child: ListView(
            padding: EdgeInsets.zero,
            children: MealPreferences.values.map((meal) {
              final bool isSelected = cubit.mealPref == meal;
              isSelected ? widget.selectedMealPref(meal) : null;
              final String title = switch (meal) {
                MealPreferences.vegetarian => Intl.message(meal.name),
                MealPreferences.nonVegetarian => Intl.message(meal.name),
                MealPreferences.vegan => Intl.message(meal.name),
                MealPreferences.pescatarian => Intl.message(meal.name),
              };
              final String subtitle = switch (meal) {
                MealPreferences.vegetarian => S.of(context).vegetarianSubtitle,
                MealPreferences.nonVegetarian =>
                  S.of(context).nonVegetarianSubtitle,
                MealPreferences.vegan => S.of(context).veganSubtitle,
                MealPreferences.pescatarian =>
                  S.of(context).pescatarianSubtitle,
              };
              return CheckCircleContainer<MealPreferences>(
                title: title,
                subtitle: subtitle,
                isSubtitle: true,
                value: meal,
                isSelected: isSelected,
                onTap: _handleTap,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
