import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../application/logic/bootstrap/bootstrap_cubit.dart';
import '../../../application/logic/bootstrap/bootstrap_state.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../app/router/route_paths.dart';
import '../../config/app_assets.dart';
import '../../config/app_spacing.dart';

class BootstrapPage extends StatefulWidget {
  const BootstrapPage({super.key});

  @override
  State<BootstrapPage> createState() => _BootstrapPageState();
}

class _BootstrapPageState extends State<BootstrapPage> {
  late final BootstrapCubit cubit;

  @override
  void initState() {
    super.initState();
    // For necessary bootstrap process like dependency injection
    cubit = locator.get<BootstrapCubit>()..fetchOnboardingStatus();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme th = context.th;
    final double logoSize = context.getLogoSize;

    return BlocListener<BootstrapCubit, BootstrapState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is UserDidNotOnboardState) {
          context.go(RoutePaths.onboarding);
        } else if (state is UserOnboardedState) {
          context.go(RoutePaths.home);
        } else if (state is UserUnauthenticatedState) {
          context.go(RoutePaths.overview);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Image.asset(
                AppAssets.appLogo,
                height: logoSize,
                width: logoSize,
                fit: .cover,
              ),
              AppSpacing.h08,
              Text(S.of(context).nutripal, style: th.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}
