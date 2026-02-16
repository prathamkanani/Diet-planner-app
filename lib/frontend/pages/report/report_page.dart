import 'package:flutter/material.dart';
import '../../config/app_spacing.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.secondaryContainer,
      body: const SafeArea(
        child: Padding(
          padding: .all(16.0),
          child: Column(
            children: [
              // MealLogBarChart(logs: logs),
              AppSpacing.h16,
            ],
          ),
        ),
      ),
    );
  }
}
