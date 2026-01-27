import 'package:flutter/material.dart';
import '../../../../../../domain/entity/health_habits_entity.dart';
import '../../../../../../domain/entity/item.dart';
import '../../../../../config/app_spacing.dart';
import 'health_habit_chip.dart';

/// Contains:
///
/// chips listing different health habits and can multi-select chips like
/// eat mindfully, eat a balanced diet, eat more protein,
/// eat more whole foods, eat more fibre, eat more vegetables,
/// eat more fruit, something else, I'm not sure
class HealthHabitsSection extends StatefulWidget {
  const HealthHabitsSection({super.key});

  @override
  State<HealthHabitsSection> createState() => _HealthHabitsSectionState();
}

class _HealthHabitsSectionState extends State<HealthHabitsSection> {

  void _handleTap(Item item) {
    setState(() {
      if (selectedIds.contains(item.id)) {
        selectedIds.remove(item.id);
      } else {
        selectedIds.add(item.id);
      }
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
            children: healthHabits.map((hHabit) {
              final bool isSelected = selectedIds.contains(hHabit.id);
              return Align(
                alignment: .centerLeft,
                child: HealthHabitChip(
                  isSelected: isSelected,
                  item: healthToItem(hHabit),
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
