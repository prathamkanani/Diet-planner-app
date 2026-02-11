import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../infrastructure/extension/context_extension.dart';

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
    final ColorScheme cs = context.cs;

    return TextButton.icon(
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
      icon: Icon(Icons.calendar_month_rounded, color: cs.onSurface),
      iconAlignment: .end,
      label: Text(
        formatDateWithToday(date),
        style: TextStyle(color: cs.onSurface),
      ),
    );
  }
}
