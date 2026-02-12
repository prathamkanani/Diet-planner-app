import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/dashboard/meal_load/meal_cubit.dart';
import '../../../../application/logic/dashboard/meal_load/meal_state.dart';
import 'calender_card.dart';

class DashboardDate extends StatelessWidget {
  const DashboardDate({super.key});

  @override
  Widget build(BuildContext context) {
    final MealLoadingCubit cubit = context.read<MealLoadingCubit>();

    return BlocBuilder<MealLoadingCubit, MealState>(
      bloc: cubit,
      builder: (context, state) {
        return WeekCalendarCard(
          date: cubit.selectedDate,
          onDatePicked: (DateTime date) {
            cubit.changedDate(date);
          },
        );
      },
    );
  }
}
