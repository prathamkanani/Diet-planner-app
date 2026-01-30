import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerButton extends StatelessWidget {
  final DateTime date;
  final ValueChanged<DateTime> onDatePicked;

  const DatePickerButton({
    super.key,
    required this.date,
    required this.onDatePicked,
  });

  String formatDateWithToday(DateTime date) {
    final now = DateTime.now();

    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;

    if (isToday) {
      return 'Today';
    }

    return DateFormat('d MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);

    return TextButton(
      onPressed: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          initialDate: date,
        );

        if (pickedDate != null) {
          onDatePicked(pickedDate);
        }
      },
      child: Text(
        formatDateWithToday(date),
        style: TextStyle(color: colorScheme.onSurface),
      ),
    );
  }
}
