import 'package:flutter/material.dart';

import '../../../../application/logic/auth/auth_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_spacing.dart';
import 'google_signin.dart';

class LoginView extends StatelessWidget {
  final AuthCubit cubit;
  final double size;

  const LoginView({super.key, required this.cubit, required this.size});

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
              height: size,
              width: size,
              fit: .cover,
            ),
            Text(
              S.of(context).nutripal,
              style: textTheme.displaySmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: .bold,
              ),
            ),
            Text(
              S.of(context).healthyEatingMadeEasy,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: .bold,
              ),
            ),
            AppSpacing.h24,
            Text(
              S.of(context).signInToSecurelySaveYourData,
              textAlign: .center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.primary,
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
                color: colorScheme.primary,
              ),
            ),
            Text(
              S.of(context).privacyPolicy,
              style: textTheme.titleSmall?.copyWith(
                color: colorScheme.primary,
                decoration: TextDecoration.underline,
                decorationColor: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
