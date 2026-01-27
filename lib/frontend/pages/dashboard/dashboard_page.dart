import 'package:flutter/material.dart';
import '../../config/app_spacing.dart';
import 'widgets/date_picker_button.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  DateTime selectedDate = DateTime.now();

  void _previousDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _nextDay() {
    if (!_isToday(selectedDate)) {
      setState(() {
        selectedDate = selectedDate.add(const Duration(days: 1));
      });
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorScheme.onPrimaryContainer
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _previousDay,
                  icon: const Icon(Icons.arrow_back_ios),
                ),

                DatePickerButton(
                  date: selectedDate,
                  onDatePicked: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),

                IconButton(
                  onPressed: _isToday(selectedDate) ? null : _nextDay,
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
          AppSpacing.h16,

        ],
      ),
    );
  }
}
