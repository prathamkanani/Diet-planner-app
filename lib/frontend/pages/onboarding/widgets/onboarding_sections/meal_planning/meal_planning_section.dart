import 'package:flutter/material.dart';
import '../../../../../../domain/entity/item.dart';
import '../../../../../../domain/entity/meal_planning_entity.dart';
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
  final void Function(int) selectId;

  const MealPlanningSection({super.key, required this.selectId});

  @override
  State<MealPlanningSection> createState() => _MealPlanningSectionState();
}

class _MealPlanningSectionState extends State<MealPlanningSection> {

  void _handleTap(Item item) {
    setState(() {
      selectedItemId = (selectedItemId == item.id) ? null : item.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How often do you plan your meals in advance?',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpacing.h24,
        Flexible(
          child: ListView(
            padding: EdgeInsets.zero,
            children: mealPlans.map((meal) {
              final bool isSelected = selectedItemId == meal.id;
              widget.selectId(selectedItemId ?? -1);
              return CheckCircleContainer(
                isSelected: isSelected,
                onTap: _handleTap,
                item: mealToItem(meal),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
