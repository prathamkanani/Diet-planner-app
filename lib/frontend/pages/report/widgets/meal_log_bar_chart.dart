import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entity/daily_meal_log_entity.dart';

class MealLogBarChart extends StatelessWidget {
  final List<DailyMealLogEntity> logs;

  const MealLogBarChart({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          maxY: 3,
          minY: 0,

          barGroups: buildBarGroups(logs),

          gridData: const FlGridData(show: false),

          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              axisNameWidget: const RotatedBox(
                quarterTurns: 4,
                child: Text('Meals Logged', style: TextStyle(fontSize: 12)),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 10,
                getTitlesWidget: (value, _) {
                  return Text(value.toInt().toString());
                },
              ),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 15,
                getTitlesWidget: (value, _) {
                  final index = value.toInt();
                  final date = logs[index].date;
                  return Text(
                    DateFormat('d MMM').format(date),
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),

            // To not show the data on right or top side of the chart.
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> buildBarGroups(List<DailyMealLogEntity> logs) {
    return List.generate(logs.length, (index) {
      final log = logs[index];

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: log.mealsLogged.toDouble(),
            color: logToColor(log.mealsLogged),
            width: 12,
          ),
        ],
      );
    });
  }

  Color logToColor(int meal) {
    switch(meal) {
      case 3:
        return Colors.green.shade800;
      case 2:
        return Colors.orange.shade800;
      case 1:
        return Colors.red.shade800;
      default:
        return Colors.grey;
    }
  }
}
