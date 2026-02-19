import 'package:flutter/material.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../config/app_spacing.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final steps = [
    "Analyzing your preferences",
    "Calculating daily calories",
    "Generating personalized meals",
  ];

  int activeStep = 0;

  @override
  void initState() {
    super.initState();
    _startSetupFlow();
  }

  Future<void> _startSetupFlow() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    setState(() => activeStep = 1);

    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    setState(() => activeStep = 2);

    // AI call would go here
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final TextTheme textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: cs.secondaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              CircularProgressIndicator(color: cs.primary),
              AppSpacing.h16,
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.2),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  steps[activeStep],
                  key: ValueKey(activeStep),
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
