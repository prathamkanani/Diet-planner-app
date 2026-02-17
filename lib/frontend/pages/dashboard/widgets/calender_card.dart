import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../infrastructure/extension/context_extension.dart';

class WeekCalendarCard extends StatelessWidget {
  final DateTime date;
  final ValueChanged<DateTime> onDatePicked;
  final ScrollController scrollController;

  const WeekCalendarCard({
    super.key,
    required this.scrollController,
    required this.date,
    required this.onDatePicked,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return Container(
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TableCalendar(
          firstDay: DateTime(2000),
          lastDay: DateTime.now(),
          focusedDay: date,
          calendarFormat: .week,
          startingDayOfWeek: .monday,
          selectedDayPredicate: (day) => isSameDay(date, day),
          onDaySelected: (selectedDay, _) {
            onDatePicked(selectedDay);
          },

          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          onHeaderTapped: (focusDay) async {
            final picked = await showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
              initialDate: date,
            );
            picked != null ? onDatePicked(picked) : null;
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
