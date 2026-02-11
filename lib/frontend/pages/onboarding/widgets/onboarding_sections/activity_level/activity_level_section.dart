import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../application/logic/onboarding/onboarding_cubit.dart';
import '../../../../../../domain/eum/activity_level_entity.dart';
import '../../../../../config/app_spacing.dart';
import '../meal_planning/check_circle_container.dart';

/// Contains:
///
/// what is your baseline activity level?
///
/// not very active, lightly active, active, very active
class ActivityLevelSection extends StatefulWidget {
  final void Function(ActivityLevel) selectedActivity;

  const ActivityLevelSection({super.key, required this.selectedActivity});

  @override
  State<ActivityLevelSection> createState() => _ActivityLevelSectionState();
}

class _ActivityLevelSectionState extends State<ActivityLevelSection> {
  late final OnboardingCubit cubit = context.read<OnboardingCubit>();
  late ActivityLevel? activityLevel = cubit.activityLevel;

  void _handleTap(ActivityLevel activity) {
    setState(() {
      activityLevel = (activityLevel == activity) ? null : activity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          'What is your baseline activity level?',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpacing.h24,
        Text('Choose what describes you best:', style: textTheme.titleMedium),
        AppSpacing.h16,
        Flexible(
          child: ListView(
            padding: EdgeInsets.zero,
            children: ActivityLevel.values.map((activity) {
              final bool isSelected = activityLevel == activity;
              isSelected ? widget.selectedActivity(activity) : null;
              final String title = switch (activity) {
                ActivityLevel.low => 'Not Very Active',
                ActivityLevel.medium => 'Lightly Active',
                ActivityLevel.high => 'Very Active',
              };
              final String subtitle = switch (activity) {
                ActivityLevel.low =>
                  "Spend most of the day sitting (e.g., desk job).",
                ActivityLevel.high =>
                  "Spend a good part of the day doing heavy physical activity (e.g., bike messenger, carpenter).",
                ActivityLevel.medium =>
                  "Spend a good part of the day on your feet (e.g., teacher, salesperson).",
              };
              return CheckCircleContainer<ActivityLevel>(
                title: title,
                subtitle: subtitle,
                isSubtitle: true,
                value: activity,
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
