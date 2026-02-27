import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../application/logic/auth/auth_cubit.dart';
import '../../../application/logic/auth/auth_state.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../app/router/route_paths.dart';
import '../../config/app_spacing.dart';
import '../error/error_page.dart';
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

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final TextTheme th = context.th;
    final double logoSize = context.getLogoSize;

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: cubit,
        listener: _listenToAuthState,
        builder: (_, state) {
          return switch (state) {
            AuthLoading() => Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  CircularProgressIndicator(color: cs.primary),
                  AppSpacing.h16,
                  Text(
                    S.of(context).pleaseWaitWhileWeLogYouIn,
                    style: th.titleMedium,
                  ),
                ],
              ),
            ),
            AuthAuthenticated() => const Center(
              child: CircularProgressIndicator(),
            ),
            AuthUnauthenticated() => LoginView(cubit: cubit, size: logoSize),
            AuthAuthenticationFailed() => GenericErrorPage(error: state.error),
          };
        },
      ),
    );
  }

  //region Custom Methods
  /// Navigating to the User Profile page
  void _listenToAuthState(BuildContext context, final AuthState state) {
    if (state is AuthAuthenticated) {
      state.isOnboarded
          ? context.go(RoutePaths.home)
          : context.go(RoutePaths.onboarding);
    }
  }

  //endregion
}
