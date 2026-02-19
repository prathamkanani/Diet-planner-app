import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/logic/bootstrap/bootstrap_cubit.dart';
import '../../../application/logic/bootstrap/bootstrap_state.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../config/app_assets.dart';
import '../../config/app_spacing.dart';
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
    cubit = locator.get();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.isOnboardingCompleted();
    });
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme th = context.th;
    final Size size = MediaQuery.sizeOf(context);
    final double shortestSide = size.shortestSide;
    final logoSize = (shortestSide * 0.22).clamp(120, 180).toDouble();

    return BlocListener<BootstrapCubit, BootstrapState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is UserDidNotOnboardState) {
          context.pushReplacement(const OnboardingPage());
          return;
        } else if (state is UserOnboardedState) {
          context.pushAndRemoveUntil(const HomePage());
          return;
        } else if (state is UserUnauthenticatedState) {
          context.pushReplacement(const OverviewPage());
          return;
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

    // TODO: Remove the screen image and only show logo or loader.
    // TODO: Remove try for free
    // return Scaffold(
    //   body: BlocListener<BootstrapCubit, BootstrapState>(
    //     bloc: cubit,
    //     listenWhen: (_, next) => next is! BootstrapLoadingState,
    //     listener: (context, state) {
    //       if (state is UserDidNotOnboardState) {
    //         context.pushReplacement(const OnboardingPage());
    //         return;
    //       } else if (state is UserOnboardedState) {
    //         context.pushAndRemoveUntil(const HomePage());
    //         return;
    //       }
    //       context.pushReplacement(const OverviewPage());
    //     },
    //     child: Stack(
    //       fit: .expand,
    //       children: [
    //         Image.asset(AppAssets.bootStrapImage, fit: .cover),
    //         Padding(
    //           padding: const EdgeInsets.all(16.0),
    //           child: Column(
    //             children: [
    //               SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
    //               Text(
    //                 S.of(context).getYourIdealBodyAndHealthier,
    //                 style: th.displaySmall,
    //                 textAlign: .center,
    //               ),
    //               AppSpacing.h16,
    //               Text(
    //                 S.of(context).makeYourDietMoreEnjoyableAndTrackYourDietWith,
    //                 style: th.titleMedium?.copyWith(fontWeight: .w400),
    //                 textAlign: .center,
    //               ),
    //               const Spacer(),
    //               BlocBuilder(
    //                 bloc: cubit,
    //                 builder: (_, final BootstrapState state) {
    //                   String label = S.of(context).tryForFree;
    //                   Widget icon = const Icon(Icons.arrow_forward);
    //                   VoidCallback? onPressed = cubit.isOnboardingCompleted;
    //
    //                   if (state is BootstrapLoadingState) {
    //                     icon = CircularProgressIndicator(color: cs.surface);
    //                     onPressed = null;
    //                   }
    //
    //                   return FilledButton.icon(
    //                     onPressed: onPressed,
    //                     icon: icon,
    //                     label: Text(
    //                       label,
    //                       style: th.titleMedium?.copyWith(color: cs.surface),
    //                     ),
    //                     style: FilledButton.styleFrom(
    //                       shape: RoundedSuperellipseBorder(
    //                         borderRadius: BorderRadius.circular(16),
    //                       ),
    //                       fixedSize: const Size.fromHeight(48),
    //                     ),
    //                   );
    //                 },
    //               ),
    //               /*FilledButton.icon(
    //                 onPressed: cubit.isOnboardingCompleted,
    //                 style: FilledButton.styleFrom(
    //                   shape: RoundedSuperellipseBorder(
    //                     borderRadius: BorderRadius.circular(16),
    //                   ),
    //                   fixedSize: const Size.fromHeight(48),
    //                 ),
    //                 label: BlocBuilder<BootstrapCubit, BootstrapState>(
    //                   bloc: cubit,
    //                   builder: (context, state) {
    //                     if (state is BootstrapLoadingState) {
    //                       return CircularProgressIndicator(color: cs.surface);
    //                     }
    //                     return Text(
    //                       S.of(context).tryForFree,
    //                       style: textTheme.titleMedium?.copyWith(
    //                         color: cs.surface,
    //                       ),
    //                     );
    //                   },
    //                 ),
    //                 icon: BlocBuilder<BootstrapCubit, BootstrapState>(
    //                   bloc: cubit,
    //                   builder: (context, state) {
    //                     if (state is BootstrapLoadingState) {
    //                       return const SizedBox.shrink();
    //                     }
    //                     return const Icon(Icons.arrow_forward);
    //                   },
    //                 ),
    //                 iconAlignment: .end,
    //               ),*/
    //               SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
