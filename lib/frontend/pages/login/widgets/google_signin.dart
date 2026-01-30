import 'package:flutter/material.dart';
import '../../../config/app_assets.dart';

class SignInWithGoogleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignInWithGoogleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    final TextTheme textTheme = TextTheme.of(context);

    return SizedBox(
      height: 48,
      // width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.onSecondary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsetsGeometry.only(right: 12),
              child: Image.asset(AppAssets.googleLogo, height: 20, width: 20),
            ),
            Text(
              'Continue with Google',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: .bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
