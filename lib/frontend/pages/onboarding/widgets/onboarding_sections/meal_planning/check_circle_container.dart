import 'package:flutter/material.dart';
import '../../../../../../domain/entity/item.dart';

class CheckCircleContainer extends StatelessWidget {
  final Item item;
  final bool isSelected;
  final ValueChanged<Item> onTap;

  const CheckCircleContainer({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    final TextTheme textTheme = TextTheme.of(context);

    return GestureDetector(
      onTap: () => onTap(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer.withValues(alpha: 0.6),
          border: BoxBorder.all(
            color: isSelected ? colorScheme.primary : colorScheme.onPrimary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: .min,
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      item.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ?item.isSubtitle
                        ? Text(
                            item.subtitle,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : null,
                  ],
                ),
              ),
              isSelected
                  ? Icon(Icons.check_circle, color: colorScheme.primary)
                  : Icon(
                      Icons.circle_outlined,
                      color: colorScheme.onPrimaryContainer,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
