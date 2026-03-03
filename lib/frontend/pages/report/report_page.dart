import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/logic/report/report_cubit.dart';
import '../../../application/logic/report/report_state.dart';
import '../../../application/service/app_data_service.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../../infrastructure/utils/helpers.dart';
import '../../config/app_spacing.dart';
import '../error/error_page.dart';
import 'widgets/meal_log_chart.dart';

enum DateRangeType { custom, month, year }

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late final PageController controller;
  late final reportCubit = context.read<ReportCubit>();
  final AppDataService appDataService = locator.get();
  final startWeek = startOfTheWeek(DateTime.now());
  final endWeek = endOfTheWeek(DateTime.now());

  @override
  void initState() {
    super.initState();
    controller = PageController();
    reportCubit.getMealLogCount(
      reportCubit.startDate ?? startWeek,
      reportCubit.endDate ?? endWeek,
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
                    AppSpacing.h64,
                    MealLogLineChart(logs: state.entity),
                    // MealLogBarChart(logs: state.entity),
                    AppSpacing.h16,
                    FilledButton(
                      onPressed: () async {
                        showRangeTypePicker(context);
                      },
                      child: const Text('Select date range'),
                    ),
                  ],
                ),
              ),
              ReportErrorState() => GenericErrorPage(error: state.error),
            };
          },
        ),
      ),
    );
  }

  Future<DateRangeType?> showRangeTypePicker(BuildContext context) {
    return showModalBottomSheet<DateRangeType>(
      context: context,
      backgroundColor: context.cs.surface,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Custom date range'),
              onTap: () async {
                final range = await pickCustomRange(context);
                reportCubit.getMealLogCount(
                  range?.start ?? startWeek,
                  range?.end ?? endWeek,
                );
                if (context.mounted) {
                  Navigator.pop(context, DateRangeType.custom);
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(),
            ),
            ListTile(
              title: const Text('Month range'),
              onTap: () async {
                final range = await pickMonthRange(context);
                reportCubit.getMealLogCount(
                  range?.start ?? startWeek,
                  range?.end ?? endWeek,
                );
                if (context.mounted) {
                  Navigator.pop(context, DateRangeType.month);
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(),
            ),
            ListTile(
              title: const Text('Year range'),
              onTap: () async {
                final range = await pickYearRange(context);
                reportCubit.getMealLogCount(
                  range?.start ?? startWeek,
                  range?.end ?? endWeek,
                );
                if (context.mounted) Navigator.pop(context, DateRangeType.year);
              },
            ),
          ],
        );
      },
    );
  }

  Future<DateTimeRange?> pickCustomRange(BuildContext context) async {
    return showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: appDataService.planStartDate!,
        end: DateTime.now(),
      ),
      firstDate: appDataService.planStartDate!,
      lastDate: DateTime(2030),
    );
  }

  Future<DateTimeRange?> pickMonthRange(BuildContext context) async {
    final start = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: appDataService.planStartDate!,
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select the month start date!',
    );

    if (start == null) return null;

    final end = await showDatePicker(
      context: context,
      initialDate: start,
      firstDate: appDataService.planStartDate!,
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select the month end date!',
    );

    if (end == null) return null;

    return DateTimeRange(start: start, end: end);
  }

  Future<DateTimeRange?> pickYearRange(BuildContext context) async {
    final start = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: appDataService.planStartDate!,
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select the year start date!',
    );

    if (start == null) return null;

    final end = await showDatePicker(
      context: context,
      initialDate: start,
      firstDate: appDataService.planStartDate!,
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select the year end date!',
    );

    if (end == null) return null;

    return DateTimeRange(start: start, end: end);
  }
}
