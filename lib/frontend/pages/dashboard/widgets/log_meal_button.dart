import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/meal_log/meal_log_cubit.dart';
import '../../../../application/logic/meal_log/meal_log_state.dart';
import '../../../../generated/l10n.dart';
import '../../../../infrastructure/extension/context_extension.dart';
import '../../../config/app_spacing.dart';

class LogMealButton extends StatelessWidget {
  const LogMealButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final TextTheme textTheme = TextTheme.of(context);
    final MealLogCubit mealLogCubit = context.read<MealLogCubit>();

    return BlocConsumer<MealLogCubit, MealLogState>(
      bloc: mealLogCubit,
      listener: (context, state) {
        if (state is MealUndoAvailableState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).mealLoggedSuccessfully),
              action: SnackBarAction(
                label: S.of(context).undo,
                onPressed: () {
                  mealLogCubit.onUndo();
                },
              ),
              behavior: .floating,
            ),
          );
        } else if (state is MealLogSuccessState) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
          onPressed: () => mealLogCubit.logMeals(),
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
