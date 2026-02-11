import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/dashboard/meal_load/meal_cubit.dart';
import '../../../../application/logic/dashboard/meal_load/meal_state.dart';
import '../../../../infrastructure/extension/context_extension.dart';
import 'date_picker_button.dart';

class DashboardDate extends StatelessWidget {
  const DashboardDate({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final MealLoadingCubit cubit = context.read<MealLoadingCubit>();

    return BlocBuilder<MealLoadingCubit, MealState>(
      bloc: cubit,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: cubit.previousDay,
              icon: const Icon(Icons.arrow_back_ios),
            ),
            DatePickerButton(
              date: cubit.selectedDate,
              onDatePicked: (date) => cubit.changedDate(date),
            ),
            IconButton(
              onPressed: cubit.nextDay,
              icon: cubit.isToday(cubit.selectedDate)
                  ? Icon(
                      Icons.arrow_forward_ios,
                      color: cs.onSecondaryContainer.withValues(alpha: 0.3),
                    )
                  : const Icon(Icons.arrow_forward_ios),
            ),
          ],
        );
      },
    );
  }
}
