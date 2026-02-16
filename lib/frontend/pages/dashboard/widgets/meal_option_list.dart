import 'package:flutter/material.dart';
import '../../../../domain/entity/meal_entity.dart';
import '../../../../domain/entity/meal_option_list_entity.dart';
import '../../../config/app_spacing.dart';
import 'expandable_meal_option.dart';

class MealOptionList extends StatefulWidget {
  final MealOptionListEntity? mealOptionListEntity;
  final Map<MealType, MealOption> loggedMeals;
  final DateTime currentDate;

  const MealOptionList({
    super.key,
    this.mealOptionListEntity,
    required this.loggedMeals,
    required this.currentDate,
  });

  @override
  State<MealOptionList> createState() => _MealOptionListState();
}

class _MealOptionListState extends State<MealOptionList> {
  late final MealType? mealType = widget.mealOptionListEntity?.mealType;
  late final List<MealEntity>? meals = widget.mealOptionListEntity?.mealOptions;

  bool _isPast(DateTime date) {
    DateTime today = DateTime.now();
    DateTime todayDate = DateTime(today.year, today.month, today.day);
    DateTime dateOnly = DateTime(date.year, date.month, date.day);
    return dateOnly.isBefore(todayDate);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: .zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: meals?.length ?? 0,
      separatorBuilder: (_, _) => AppSpacing.h08,
      itemBuilder: (context, index) {
        final mealEntity = meals?[index];
        bool isTypeLogged = widget.loggedMeals.containsKey(mealType);
        bool isLogged = widget.loggedMeals[mealType] == mealEntity?.option;
        if (mealEntity == null) return null;
        return ExpandableMealOption(
          mealType: mealType!,
          meal: mealEntity,
          isLogged: isLogged,
          isTypeLogged: isTypeLogged,
          isPast: _isPast(widget.currentDate),
        );
      },
    );
  }
}
