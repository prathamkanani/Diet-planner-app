// © Meditab Software 2025
import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../config/app_spacing.dart';
import '../../../widgets/fade_animation.dart';

class OverviewSectionOne extends StatelessWidget {
  const OverviewSectionOne({super.key});

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
              S.of(context).welcomeHealthExplorer,
              style: textTheme.displayMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: .bold,
              ),
            ),
          ),
          AppSpacing.h48,
          FadingAnimation(
            delay: const Duration(milliseconds: 500),
            child: Text(
              S.of(context).iAmNutripal,
              style: textTheme.displayMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: .bold,
              ),
            ),
          ),
          AppSpacing.h48,
          FadingAnimation(
            delay: const Duration(milliseconds: 1000),
            child: Text(
              S.of(context).yourHealthsNewBestFriend,
              style: textTheme.displayMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: .bold,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
