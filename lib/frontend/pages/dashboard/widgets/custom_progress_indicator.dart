import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final int target;
  final int consumed;
  final String subtitle;
  final double textScale;
  final Color color;
  final bool isCalorieIndicator;

  const CustomProgressIndicator({
    super.key,
    required this.target,
    required this.consumed,
    required this.subtitle,
    required this.color,
    this.textScale = 1.0,
    this.isCalorieIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);

    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Smallest available size
          final size = constraints.maxWidth.clamp(100.0, 140.0);
          final stroke = size * 0.02;
          double progress = 1 - (target - consumed) / target;
          int remaining = target - consumed;
          if (remaining < 0) remaining = 0;

          return SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.scale(
                  scale: isCalorieIndicator ? size / 30 : size / 40,
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: progress),
                    duration: const Duration(milliseconds: 1500),
                    builder: (context, progress, _) {
                      return CircularProgressIndicator(
                        value: progress,
                        strokeWidth: stroke,
                        color: color,
                        backgroundColor: color.withValues(alpha: 0.2),
                        strokeCap: .round,
                      );
                    },
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$remaining',
                        style: textTheme.displayLarge?.copyWith(
                          fontSize: isCalorieIndicator
                              ? size * 0.25 * textScale
                              : size * 0.25 * textScale,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: textTheme.titleSmall?.copyWith(
                          fontSize: isCalorieIndicator
                              ? size * 0.125 * textScale
                              : size * 0.125 * textScale,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
