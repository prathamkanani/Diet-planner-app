import 'package:flutter/material.dart';
import '../../../../../../domain/entity/activity_level_entity.dart';
import '../../../../../../domain/entity/item.dart';
import '../../../../../config/app_spacing.dart';
import '../meal_planning/check_circle_container.dart';

/// Contains:
///
/// what is your baseline activity level?
///
/// not very active, lightly active, active, very active
class ActivityLevelSection extends StatefulWidget {
  final void Function(int) selectId;

  const ActivityLevelSection({super.key, required this.selectId});

  @override
  State<ActivityLevelSection> createState() => _ActivityLevelSectionState();
}

class _ActivityLevelSectionState extends State<ActivityLevelSection> {

  void _handleTap(Item item) {
    setState(() {
      selectedItemId = (selectedItemId == item.id) ? null : item.id;
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
              final bool isSelected = selectedItemId == activity.id;
              widget.selectId(selectedItemId ?? -1);
              return CheckCircleContainer(
                item: activityToItem(activity),
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
