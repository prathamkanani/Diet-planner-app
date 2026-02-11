import 'package:flutter/material.dart';
import '../../../../domain/entity/meal_entity.dart';
import '../../../../domain/entity/meal_option_list_entity.dart';
import 'expandable_meal_option.dart';

class MealTile extends StatefulWidget {
  final MealOptionListEntity? mealOptionListEntity;
  final Map<MealType, MealOption> loggedMeals;
  final DateTime currentDate;

  const MealTile({
    super.key,
    required this.loggedMeals,
    required this.mealOptionListEntity,
    required this.currentDate,
  });

  @override
  State<MealTile> createState() => _MealTileState();
}

class _MealTileState extends State<MealTile> {
  late final MealType? mealType = widget.mealOptionListEntity?.mealType;

  bool isPast(DateTime date) {
    DateTime today = DateTime.now();
    DateTime todayDate = DateTime(today.year, today.month, today.day);
    DateTime dateOnly = DateTime(date.year, date.month, date.day);
    return dateOnly.isBefore(todayDate);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);

    return Padding(
      padding: const .only(bottom: 16.0),
      child: Material(
        elevation: 3.0,
        shadowColor: colorScheme.shadow,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(12),
          child: ExpansionTile(
            backgroundColor: colorScheme.surface,
            collapsedBackgroundColor: colorScheme.surface,
            childrenPadding: const .symmetric(horizontal: 16, vertical: 8),
            title: Text(
              mealType?.mealType ?? '',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            children:
            widget.mealOptionListEntity?.mealOptions?.map((
                final MealEntity mealEntity,
                ) {
              bool isTypeLogged = widget.loggedMeals.containsKey(
                mealType,
              );
              bool isLogged =
                  widget.loggedMeals[mealType] == mealEntity.option;

              return ExpandableMealOption(
                mealType: mealType!,
                meal: mealEntity,
                isLogged: isLogged,
                isTypeLogged: isTypeLogged,
                isPast: isPast(widget.currentDate),
              );
            }).toList()
            as List<Widget>,
          ),
        ),
      ),
    );
  }
}
