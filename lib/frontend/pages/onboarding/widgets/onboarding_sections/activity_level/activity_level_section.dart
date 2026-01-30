import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../application/logic/onboarding/onboarding_cubit.dart';
import '../../../../../../domain/entity/activity_level_entity.dart';
import '../../../../../config/app_spacing.dart';
import '../meal_planning/check_circle_container.dart';

/// Contains:
///
/// what is your baseline activity level?
///
/// not very active, lightly active, active, very active
class ActivityLevelSection extends StatefulWidget {
  final void Function(ActivityLevelEntity) selectedActivity;

  const ActivityLevelSection({super.key, required this.selectedActivity});

  @override
  State<ActivityLevelSection> createState() => _ActivityLevelSectionState();
}

class _ActivityLevelSectionState extends State<ActivityLevelSection> {
  late final OnboardingCubit cubit = context.read<OnboardingCubit>();
  late ActivityLevelEntity? selectedActivity = cubit.activityLevel;
  late List<ActivityLevelEntity> activityLevels = cubit.activityLevels;

  void _handleTap(ActivityLevelEntity activity) {
    setState(() {
      selectedActivity = (selectedActivity == activity) ? null : activity;
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
            children: activityLevels.map((activity) {
              final bool isSelected = selectedActivity == activity;
              isSelected ? widget.selectedActivity(activity) : null;
              return CheckCircleContainer<ActivityLevelEntity>(
                title: activity.title.title,
                subtitle: activity.subtitle.subtitle,
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
