import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
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
              S.of(context).getRegularCalorieTracking,
              style: textTheme.displayMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: .bold
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
              S.of(context).easilyTrackCaloriesMonitorNutritionAndStayAlignedWithYour,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: .w600
              ),
            ),
          ),
        ],
      ),
    );
  }
}
