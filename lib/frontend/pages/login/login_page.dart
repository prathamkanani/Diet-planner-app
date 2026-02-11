import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/logic/auth/auth_cubit.dart';
import '../../../application/logic/auth/auth_state.dart';
import '../../../application/service/app_data_service.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../config/app_spacing.dart';
import '../onboarding/onboarding_page.dart';
import 'widgets/login_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = locator.get<AuthCubit>()..getUser();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  /// Navigating to the User Profile page
  void _listenToAuthState(BuildContext context, final AuthState state) {
    if (state is AuthAuthenticated) {
      final AppDataService appDataService = locator.get<AppDataService>();
      appDataService.userId = state.authEntity.userId;
      context.pushAndRemoveUntil(const OnboardingPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final TextTheme textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: cs.primary,
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: cubit,
        listener: _listenToAuthState,
        builder: (context, state) {
          return switch (state) {
            AuthLoading() => Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  CircularProgressIndicator(color: cs.onPrimary),
                  AppSpacing.h16,
                  Text(
                    S.of(context).pleaseWaitWhileWeLogYouIn,
                    style: textTheme.titleMedium?.copyWith(color: cs.onPrimary),
                  ),
                ],
              ),
            ),
            AuthAuthenticated() => const Center(
              child: CircularProgressIndicator(),
            ),
            AuthUnauthenticated() => LoginView(cubit: cubit),
            AuthAuthenticationFailed() => AlertDialog(
              title: Text(S.of(context).loginFailed),
              content: Text(S.of(context).sorryUnableToLogIn),
              actions: [
                TextButton(
                  onPressed: cubit.getUser,
                  child: Text(S.of(context).tryAgain),
                ),
              ],
            ),
          };
        },
      ),
    );
  }
}
