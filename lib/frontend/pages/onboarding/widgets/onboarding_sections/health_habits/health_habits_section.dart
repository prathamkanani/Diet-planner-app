import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../application/logic/onboarding/onboarding_cubit.dart';
import '../../../../../../domain/entity/health_habits_entity.dart';
import '../../../../../config/app_spacing.dart';
import 'health_habit_chip.dart';

/// Contains:
///
/// chips listing different health habits and can multi-select chips like
/// eat mindfully, eat a balanced diet, eat more protein,
/// eat more whole foods, eat more fibre, eat more vegetables,
/// eat more fruit, something else, I'm not sure
class HealthHabitsSection extends StatefulWidget {
  final void Function(List<HealthHabits>) selectedHabit;

  const HealthHabitsSection({super.key, required this.selectedHabit});

  @override
  State<HealthHabitsSection> createState() => _HealthHabitsSectionState();
}

class _HealthHabitsSectionState extends State<HealthHabitsSection> {
  late final OnboardingCubit cubit = context.read<OnboardingCubit>();
  late final List<HealthHabits> selectedHabits = cubit.healthHabits;

  void _handleTap(HealthHabits habit) {
    setState(() {
      if (selectedHabits.contains(habit)) {
        selectedHabits.remove(habit);
        return;
      }
      selectedHabits.add(habit);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Which health habits are most important to you?',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpacing.h16,
        Text('Recommended health habits', style: textTheme.titleMedium),
        AppSpacing.h08,
        Flexible(
          child: ListView(
            padding: EdgeInsets.zero,
            children: HealthHabits.values.map((final HealthHabits habit) {
              final bool isSelected = selectedHabits.contains(habit);
              isSelected ? widget.selectedHabit(selectedHabits) : null;
              return Align(
                alignment: .centerLeft,
                child: HealthHabitChip(
                  habit: habit,
                  isSelected: isSelected,
                  onTap: _handleTap,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
