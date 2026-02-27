import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../config/app_assets.dart';

class SignInWithGoogleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignInWithGoogleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    final TextTheme textTheme = TextTheme.of(context);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.primary,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        fixedSize: const Size.fromHeight(48)
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
            S.of(context).continueWithGoogle,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: .bold,
            ),
          ),
        ],
      ),
    );
  }
}
