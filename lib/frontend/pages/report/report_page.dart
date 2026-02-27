import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/logic/report/report_cubit.dart';
import '../../../application/logic/report/report_state.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../../infrastructure/utils/helpers.dart';
import '../../config/app_spacing.dart';
import 'widgets/meal_log_bar_chart.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late final PageController controller;
  static const int initialPage = 1000;
  late final reportCubit = context.read<ReportCubit>();

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: initialPage);
    reportCubit.getMealLogCount(
      startOfTheWeek(DateTime.now()),
      endOfTheWeek(DateTime.now()),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final TextTheme th = context.th;
    final reportCubit = context.read<ReportCubit>();

    return Scaffold(
      backgroundColor: cs.secondaryContainer,
      appBar: AppBar(title: Text(S.of(context).report), centerTitle: true),
      body: SafeArea(
        child: BlocBuilder<ReportCubit, ReportState>(
          bloc: reportCubit,
          builder: (context, state) {
            return switch (state) {
              ReportLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              ReportLoadedState() => Padding(
                padding: const .all(16),
                child: Column(
                  children: [
                    Text(
                      S.of(context).numberOfMealsLogged,
                      style: th.titleSmall,
                    ),
                    AppSpacing.h16,
                    MealLogBarChart(logs: state.entity),
                  ],
                ),
              ),
              ReportErrorState() => Center(child: Text(state.error.toString())),
            };
          },
        ),
      ),
    );
  }
}
