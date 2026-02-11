import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/logic/bootstrap/bootstrap_cubit.dart';
import '../../../application/logic/bootstrap/bootstrap_state.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../home/home_page.dart';
import '../onboarding/onboarding_page.dart';
import '../overview/overview_page.dart';

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
    cubit = locator.get()..isOnboardingCompleted();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;

    return Scaffold(
      backgroundColor: cs.primary,
      body: BlocListener<BootstrapCubit, BootstrapState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is UserDidNotOnboardState) {
            context.pushReplacement(const OnboardingPage());
            return;
          } else if (state is UserOnboardedState) {
            context.pushAndRemoveUntil(const HomePage());
            return;
          }
          context.pushReplacement(const OverviewPage());
        },
        child: Center(child: CircularProgressIndicator(color: cs.onPrimary)),
      ),
    );
  }
}
