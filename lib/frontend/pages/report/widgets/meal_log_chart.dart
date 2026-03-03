import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entity/daily_meal_log_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../../infrastructure/extension/context_extension.dart';
import '../../../../infrastructure/utils/helpers.dart';
import '../../../config/app_color_palette.dart';

class MealLogLineChart extends StatelessWidget {
  final List<DailyMealLogEntity> logs;

  MealLogLineChart({super.key, required this.logs});

  late final Map<int, DateTime> _monthLabels = computeMonthLabelPositions(logs);
  late final Map<int, DateTime> _intervalMonth = computeMonthLabelPositions(
    logs,
    3,
  );

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;

    return SizedBox(
      height: MediaQuery.heightOf(context) * 0.4,
      child: LineChart(
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
        LineChartData(
          minY: 0,
          maxY: 3,

          clipData: const .all(),

          // gridData: const FlGridData(show: false),

          // borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: _buildSpots(logs),
              isCurved: true,
              curveSmoothness: 0.2,
              barWidth: 3,
              // color: cs.primary,
              gradient: LinearGradient(
                begin: .centerLeft,
                end: .centerRight,
                colors: [
                  cs.primary,
                  AppColorPalette.red,
                  AppColorPalette.orange,
                ],
                stops: [0.33, 0.66, 1],
              ),
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: cs.primary.withValues(alpha: 0.15),
                gradient: LinearGradient(
                  begin: .centerLeft,
                  end: .centerRight,
                  colors: [
                    cs.primary.withValues(alpha: 0.4),
                    AppColorPalette.red.withValues(alpha: 0.4),
                    AppColorPalette.orange.withValues(alpha: 0.4),
                  ],
                  stops: [0.33, 0.66, 1],
                ),
              ),
            ),
          ],

          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              axisNameSize: 24,
              axisNameWidget: RotatedBox(
                quarterTurns: 4,
                child: Text(
                  S.of(context).numberOfMealsLogged,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 12,
                getTitlesWidget: (value, meta) {
                  final isFirst = value == meta.min;

                  return Padding(
                    padding: EdgeInsets.only(bottom: isFirst ? 12 : 0),
                    child: Text(value.toInt().toString()),
                  );
                },
              ),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 20,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  final totalLogs = logs.length;

                  // Getting the first and last values to add padding.
                  final isFirst = value == meta.min;
                  final isLast = value == meta.max;

                  if (index < 0 || index >= totalLogs) {
                    return const SizedBox.shrink();
                  }

                  // For showing more than 6 months logs
                  if (totalLogs > 30 && totalLogs < 180) {
                    final date = _monthLabels[index];
                    if (date == null) return const SizedBox.shrink();
                    return Text(DateFormat('MMM').format(date));
                  }

                  // For showing more than 1 year logs
                  if (totalLogs > 180) {
                    final date = _intervalMonth[index];
                    if (date == null) return const SizedBox.shrink();
                    return Text(DateFormat('MMM').format(date));
                  }

                  final date = logs[index].date;
                  // Padding on left and right elements.
                  return Padding(
                    padding: EdgeInsets.only(
                      left: isFirst ? 16 : 0,
                      right: isLast ? 16 : 0,
                      top: 4,
                    ),
                    child: Text(
                      isToday(date)
                          ? S.of(context).today
                          : DateFormat('d MMM').format(date),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),

            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),

          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final index = spot.x.toInt();
                  final log = logs[index];

                  return LineTooltipItem(
                    '${DateFormat('d MMM').format(log.date)}\n'
                    '${log.mealsLogged} meals logged',
                    const TextStyle(color: Colors.white, fontSize: 12),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  /// This method build the points in a coordinate system where
  /// x: index or date order and y: number of meals logged on that day
  List<FlSpot> _buildSpots(List<DailyMealLogEntity> logs) {
    return List.generate(
      logs.length,
      (index) => FlSpot(index.toDouble(), logs[index].mealsLogged.toDouble()),
    );
  }

  /// This method shows the month label on the X axis.
  ///
  /// * [logs]: It shows the number of meals logged on a particular day.
  /// * [skipMonth]: It is an optional value that only shows few month's label
  /// skipping other months with a certain interval.
  Map<int, DateTime> computeMonthLabelPositions(
    List<DailyMealLogEntity> logs, [
    int skipMonth = 0,
  ]) {
    int monthCounter = 0;
    final Map<int, DateTime> result = {};

    if (logs.isEmpty) return result;

    DateTime? lastMonth;

    for (int i = 0; i < logs.length; i++) {
      final date = logs[i].date;
      final currentMonth = DateTime(date.year, date.month);

      // Prints first occurrence of every month.
      if (lastMonth == null ||
          currentMonth.year != lastMonth.year ||
          currentMonth.month != lastMonth.month) {
        // Skips some occurrences and only shows with gap of skipMonths.
        if (skipMonth != 0 && monthCounter % skipMonth == 0) {
          result[i] = date;
        }
        lastMonth = currentMonth;
        monthCounter++;
      }
    }

    return result;
  }
}
