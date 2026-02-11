import 'package:flutter/material.dart';
import '../../../domain/entity/daily_meal_log.dart';
import '../../config/app_spacing.dart';
import 'widgets/meal_log_bar_chart.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.secondaryContainer,
      body: Padding(
        padding: const .all(16.0),
        child: Column(
          children: [
            MealLogBarChart(logs: logs),
            AppSpacing.h16,
          ],
        ),
      ),
    );
  }
}
