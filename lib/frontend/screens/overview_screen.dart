// © Meditab Software 2025
import 'package:flutter/material.dart';
import '../pages/overview/overview_page.dart';

/// Purposes of Screen
/// 1. Defines the layout.
/// 2. Provides state-management.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // TODO: Initialise cubit.

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(padding: .all(48.0), child: OverviewPage()),
      ),
    );
  }
}
