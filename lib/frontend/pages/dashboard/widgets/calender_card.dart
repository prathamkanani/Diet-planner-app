import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../infrastructure/extension/context_extension.dart';

class WeekCalendarCard extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onDatePicked;

  const WeekCalendarCard({
    super.key,
    required this.date,
    required this.onDatePicked,
  });

  @override
  State<WeekCalendarCard> createState() => _WeekCalendarCardState();
}

class _WeekCalendarCardState extends State<WeekCalendarCard> {
  late DateTime _focusedDay = widget.date;
  late DateTime? _selectedDay = widget.date;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TableCalendar(
          firstDay: DateTime(2000),
          lastDay: DateTime.now(),
          focusedDay: _focusedDay,
          calendarFormat: .week,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            widget.onDatePicked(selectedDay);
          },

          headerStyle: const HeaderStyle(
            formatButtonVisible: false
          ),
          onHeaderTapped: (focusDay) async {
            final picked = await showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
              initialDate: _selectedDay
            );
            setState(() {
              picked != null ? _focusedDay = picked : null;
            });
          },
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              return DayCard(day: day, isToday: false);
            },
            todayBuilder: (context, day, focusedDay) {
              return DayCard(day: day, isToday: true);
            },
            selectedBuilder: (context, day, focusedDay) {
              return DayCard(day: day, isToday: false, selected: true);
            },
          ),
        ),
      ),
    );
  }
}

class DayCard extends StatelessWidget {
  final DateTime day;
  final bool isToday;
  final bool selected;

  const DayCard({
    super.key,
    required this.day,
    required this.isToday,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: selected
            ? cs.primary
            : isToday
            ? cs.primary.withValues(alpha: 0.3)
            : cs.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          ?selected
              ? BoxShadow(
                  color: cs.primary.withValues(alpha: 0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              : null,
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Center(
              child: Text(
                '${day.day}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: selected ? cs.onPrimary : cs.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
