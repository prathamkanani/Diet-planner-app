import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/meal_load/meal_cubit.dart';
import '../../../../application/logic/meal_log/meal_log_cubit.dart';
import '../../../../application/logic/meal_log/meal_log_state.dart';
import '../../../../generated/l10n.dart';
import '../../../../infrastructure/extension/context_extension.dart';
import '../../../config/app_spacing.dart';

class LogMealButton extends StatelessWidget {
  const LogMealButton({super.key});

  static final _UndoSnackBarController _snackBarController =
      _UndoSnackBarController();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final TextTheme textTheme = TextTheme.of(context);
    final MealLogCubit mealLogCubit = context.read();

    // Gets the selected date from the dashboard.
    final MealLoadingCubit mealLoadingCubit = context.read();
    final DateTime selectedDate = mealLoadingCubit.selectedDate;

    return BlocConsumer<MealLogCubit, MealLogState>(
      bloc: mealLogCubit,
      listenWhen: (prev, next) =>
          !(prev is MealLogSuccessState && next is MealLogSuccessState),
      listener: (context, state) {
        if (state is MealLogSuccessState) {
          _snackBarController.show(
            context,
            snackBar: SnackBar(
              content: Text(S.of(context).mealLoggedSuccessfully),
              action: SnackBarAction(
                label: S.of(context).undo,
                onPressed: () {
                  _snackBarController.clear();
                  mealLogCubit.onUndo(selectedDate);
                },
              ),
              behavior: .floating,
            ),
          );
        }

        if (state is MealLogErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).failedToLog),
              duration: const Duration(milliseconds: 500),
            ),
          );
        }
      },
      buildWhen: (prev, next) {
        return !(prev is MealSelectedState && next is MealSelectedState);
      },
      builder: (context, state) {
        Widget? loader;
        if (state is MealLoggingState) {
          loader = CircularProgressIndicator(color: cs.onPrimary);
        } else if (state is! MealSelectedState) {
          return const SizedBox.shrink();
        }
        return FilledButton(
          onPressed: () => mealLogCubit.logMeals(selectedDate),
          style: FilledButton.styleFrom(fixedSize: const Size.fromHeight(44)),
          child: Row(
            mainAxisSize: .min,
            children: [
              ?loader,
              AppSpacing.w08,
              Text(
                S.of(context).logMeal,
                style: textTheme.bodyLarge?.copyWith(
                  color: cs.onPrimary,
                  fontWeight: .w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _UndoSnackBarController {
  Timer? timer;

  void show(
    BuildContext context, {
    required SnackBar snackBar,
    Duration timeout = const Duration(seconds: 10),
  }) {
    final messenger = ScaffoldMessenger.of(context);

    timer?.cancel();
    timer = null;

    messenger.removeCurrentSnackBar();
    messenger.showSnackBar(snackBar);

    timer = Timer((timeout), () {
      messenger.hideCurrentSnackBar();
    });
  }

  void clear() {
    timer?.cancel();
    timer = null;
  }
}
