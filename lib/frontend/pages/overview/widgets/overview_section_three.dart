import 'package:flutter/material.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_spacing.dart';
import 'fade_animation.dart';

class OverviewSectionThree extends StatelessWidget {
  const OverviewSectionThree({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final ColorScheme colorScheme = ColorScheme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
          FadingAnimation(
            delay: const Duration(milliseconds: 0),
            child: Text(
              'Make daily meal logs!',
              style: textTheme.displayMedium?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          AppSpacing.h16,
          Expanded(
            child: FadingAnimation(
              delay: const Duration(milliseconds: 500),
              needSliding: false,
              child: Image.asset(AppAssets.welcomeImage),
            ),
          ),
          FadingAnimation(
            delay: const Duration(milliseconds: 500),
            child: Text(
              'Log meals, understand your intake, and build healthier habits—one day at a time.',
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
