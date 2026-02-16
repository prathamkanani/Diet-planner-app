import 'package:flutter/material.dart';
import '../../../../domain/entity/meal_entity.dart';
import '../../../../infrastructure/extension/context_extension.dart';
import '../../../config/app_color_palette.dart';
import '../../../config/app_spacing.dart';

class NutrientChip extends StatelessWidget {
  final Nutrient nutrientType;
  final int nutrientValue;

  const NutrientChip({
    super.key,
    required this.nutrientType,
    required this.nutrientValue,
  });

  Color colorFromType(Nutrient nutrient) {
    if (nutrient == .carbs) {
      return AppColorPalette.red.withValues(alpha: 0.8);
    } else if (nutrient == .protein) {
      return AppColorPalette.orange.withValues(alpha: 0.8);
    }
    return AppColorPalette.blue.withValues(alpha: 0.8);
  }

  String emojiFromType(Nutrient nutrient) {
    if (nutrient == .calories) {
      return '🔥';
    } else if (nutrient == .carbs) {
      return '🍞';
    } else if (nutrient == .protein) {
      return '🍗';
    }
    return '🧀';
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final TextTheme textTheme = TextTheme.of(context);
    return Container(
      margin: const .fromLTRB(0, 8, 12, 4),
      decoration: BoxDecoration(
        color: nutrientType == .calories
            ? cs.primary.withValues(alpha: 0.7)
            : colorFromType(nutrientType),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Row(
          mainAxisSize: .min,
          children: [
            Text(emojiFromType(nutrientType)),
            AppSpacing.w04,
            Text(
              '${nutrientType.nutrientType}:',
              style: textTheme.bodySmall?.copyWith(
                color: cs.secondary,
                fontWeight: .w600,
              ),
            ),
            AppSpacing.w04,
            nutrientType == .calories
                ? Text(
                    '$nutrientValue kcal',
                    style: textTheme.bodySmall?.copyWith(
                      color: cs.secondary,
                      fontWeight: .w600,
                    ),
                  )
                : Text(
                    '$nutrientValue g',
                    style: textTheme.bodySmall?.copyWith(
                      color: cs.secondary,
                      fontWeight: .w600,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
