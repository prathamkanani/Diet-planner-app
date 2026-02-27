import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../domain/entity/user_preferences.dart';

class HealthHabitChip extends StatelessWidget {
  final HealthHabits habit;
  final bool isSelected;
  final ValueChanged<HealthHabits> onTap;

  const HealthHabitChip({
    super.key,
    required this.habit,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final ColorScheme colorScheme = ColorScheme.of(context);

    return GestureDetector(
      onTap: () => onTap(habit),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.2)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.primaryContainer,
            width: 2,
          ),
        ),
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            Intl.message(habit.name),
            style: textTheme.titleSmall?.copyWith(
              color: isSelected ? colorScheme.primary : null,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
