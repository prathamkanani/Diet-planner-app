import 'package:flutter/material.dart';
import '../../../../../../domain/entity/item.dart';

class HealthHabitChip extends StatelessWidget {
  final Item item;
  final bool isSelected;
  final ValueChanged<Item> onTap;

  const HealthHabitChip({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final ColorScheme colorScheme = ColorScheme.of(context);

    return GestureDetector(
      onTap: () => onTap(item),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary.withValues(alpha: 0.2) : null,
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
            item.title,
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
