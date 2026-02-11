import 'package:flutter/material.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_spacing.dart';
import '../../../widgets/fade_animation.dart';

class OverviewSectionTwo extends StatelessWidget {
  const OverviewSectionTwo({super.key});

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
              'Get regular calorie tracking!',
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
              'Easily track calories, monitor nutrition, and stay aligned with your health goals.',
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
