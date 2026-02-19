import 'package:flutter/material.dart';

class CheckCircleContainer<T> extends StatelessWidget {
  final T value;
  final String title;
  final String? subtitle;
  final bool isSubtitle;
  final bool isSelected;
  final ValueChanged<T> onTap;

  const CheckCircleContainer({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.value,
    required this.title,
    this.subtitle,
    this.isSubtitle = false,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    final TextTheme textTheme = TextTheme.of(context);

    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.3)
              : colorScheme.surface,
          border: BoxBorder.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.primaryContainer,
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
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ?isSubtitle
                        ? Text(
                            subtitle!,
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
                      color: colorScheme.primaryContainer,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
