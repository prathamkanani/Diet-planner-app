import 'package:flutter/material.dart';
import '../../../../infrastructure/extension/context_extension.dart';

class CalorieProgress extends StatelessWidget {
  final int targetCalories;
  final int consumedCalories;

  const CalorieProgress({
    super.key,
    required this.targetCalories,
    required this.consumedCalories,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final TextTheme textTheme = TextTheme.of(context);

    return Card(
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.maxWidth.clamp(140.0, 280.0);
            final stroke = size * 0.01;
            double progress =
                1 - (targetCalories - consumedCalories) / targetCalories;
            int showCalories = targetCalories - consumedCalories;
            if (showCalories < 0) showCalories = 0;

            return SizedBox(
              width: size,
              height: size,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: size / 45,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: stroke,
                      backgroundColor: cs.secondary,
                      strokeCap: .round,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$showCalories', style: textTheme.displayLarge),
                      Text('kcal left', style: textTheme.titleSmall),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
