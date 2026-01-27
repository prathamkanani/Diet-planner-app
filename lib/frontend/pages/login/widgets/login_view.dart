import 'package:flutter/material.dart';

import '../../../../application/logic/auth/auth_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_spacing.dart';
import 'google_signin.dart';

class LoginView extends StatelessWidget {
  final AuthCubit cubit;

  const LoginView({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final ColorScheme colorScheme = ColorScheme.of(context);

    return Padding(
      padding: const EdgeInsetsGeometry.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: .center,
          children: [
            const Spacer(),
            Image.asset(
              AppAssets.appLogo,
              height: 100,
              width: 100,
              fit: .cover,
            ),
            AppSpacing.h08,
            Text(
              S.of(context).nutripal,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: .bold,
              ),
            ),
            AppSpacing.h08,
            Text(
              S.of(context).healthyEatingMadeEasy,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: .bold,
              ),
            ),
            AppSpacing.h24,
            Text(
              'Sign in to securely save your data, personalize your experience, and track your progress',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            AppSpacing.h24,
            SignInWithGoogleButton(
              onPressed: () {
                cubit.signIn();
              },
            ),
            const Spacer(),
            Text(
              S.of(context).byContinuingYouAgreeToOur,
              style: textTheme.titleSmall?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
            Text(
              S.of(context).privacyPolicy,
              style: textTheme.titleSmall?.copyWith(
                color: colorScheme.onPrimary,
                decoration: TextDecoration.underline,
                decorationColor: colorScheme.onPrimary
              ),
            ),
          ],
        ),
      ),
    );
  }
}
