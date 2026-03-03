import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/meal_load/meal_cubit.dart';
import '../../../../application/logic/meal_load/meal_state.dart';
import '../../../config/app_spacing.dart';
import 'calender_card.dart';

class DashboardDate extends StatelessWidget {
  final ScrollController scrollController;

  const DashboardDate({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final MealLoadingCubit cubit = context.read<MealLoadingCubit>();

    return BlocBuilder<MealLoadingCubit, MealState>(
      bloc: cubit,
      buildWhen: (_, next) => next is MealLoadingState,
      builder: (context, state) {
        return Column(
          children: [
            AppSpacing.h08,
            WeekCalendarCard(
              scrollController: scrollController,
              date: cubit.selectedDate,
              onDatePicked: cubit.changedDate,
            ),
          ],
        );
      },
    );
  }
}
