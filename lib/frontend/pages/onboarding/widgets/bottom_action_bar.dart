import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../config/app_spacing.dart';

class BottomActionBar extends StatelessWidget {
  final VoidCallback onNext;

  final VoidCallback onPrevious;

  const BottomActionBar({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    final TextTheme textTheme = TextTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            spreadRadius: 5,
            blurRadius: 2,
          ),
        ],
      ),
      height: MediaQuery.sizeOf(context).height * 0.08,
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            IconButton.filled(
              onPressed: onPrevious,
              icon: Center(
                child: Icon(Icons.arrow_back, color: colorScheme.primary),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary.withValues(alpha: 0.3),
              ),
            ),
            AppSpacing.w08,
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.75,
              child: FilledButton(
                onPressed: onNext,
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                ),
                child: Center(
                  child: Text(
                    S.of(context).next,
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
