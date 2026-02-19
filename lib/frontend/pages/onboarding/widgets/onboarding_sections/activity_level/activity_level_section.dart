import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../application/logic/onboarding/onboarding_cubit.dart';
import '../../../../../../domain/entity/user_preferences.dart';
import '../../../../../../generated/l10n.dart';
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

  void _handleTap(ActivityLevel activity) {
    setState(() {
      cubit.activityLevel = (cubit.activityLevel == activity) ? null : activity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          S.of(context).whatIsYourBaselineActivityLevel,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpacing.h24,
        Text(
          S.of(context).chooseWhatDescribesYouBest,
          style: textTheme.titleMedium,
        ),
        AppSpacing.h16,
        Flexible(
          child: ListView(
            padding: EdgeInsets.zero,
            children: ActivityLevel.values.map((activity) {
              final bool isSelected = cubit.activityLevel == activity;
              isSelected ? widget.selectedActivity(activity) : null;
              final String title = switch (activity) {
                ActivityLevel.low => S.of(context).notVeryActive,
                ActivityLevel.medium => S.of(context).lightlyActive,
                ActivityLevel.high => S.of(context).veryActive,
              };
              final String subtitle = switch (activity) {
                ActivityLevel.low =>
                  S.of(context).spendMostOfTheDaySittingEgDeskJob,
                ActivityLevel.high =>
                  S.of(context).spendAGoodPartOfTheDayDoingHeavyPhysical,
                ActivityLevel.medium =>
                  S.of(context).spendAGoodPartOfTheDayOnYourFeet,
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
