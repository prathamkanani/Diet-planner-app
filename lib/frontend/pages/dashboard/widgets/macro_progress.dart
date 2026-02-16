import 'package:flutter/material.dart';
import '../../../../domain/entity/daily_meals_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../config/app_color_palette.dart';
import '../../../config/app_spacing.dart';
import 'custom_progress_indicator.dart';

class MacroProgress extends StatelessWidget {
  final DailyMealsEntity entity;

  const MacroProgress({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Flexible(
            child: Column(
              children: [
                CustomProgressIndicator(
                  target: entity.targetCarbs,
                  consumed: entity.consumedCarbs,
                  subtitle: '/${entity.targetCarbs} g',
                  color: AppColorPalette.red,
                ),
                Text(S.of(context).carbs),
              ],
            ),
          ),
          AppSpacing.w08,
          Flexible(
            child: Column(
              children: [
                CustomProgressIndicator(
                  target: entity.targetProtein,
                  consumed: entity.consumedProtein,
                  subtitle: '/${entity.targetProtein} g',
                  color: AppColorPalette.orange,
                ),
                Text(S.of(context).protein),
              ],
            ),
          ),
          AppSpacing.w08,
          Flexible(
            child: Column(
              children: [
                CustomProgressIndicator(
                  target: entity.targetFats,
                  consumed: entity.consumedFats,
                  subtitle: '/${entity.targetFats} g',
                  color: AppColorPalette.blue,
                ),
                Text(S.of(context).fat),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
