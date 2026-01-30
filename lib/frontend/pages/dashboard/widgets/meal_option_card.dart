import 'package:flutter/material.dart';

class MealOptionCard extends StatelessWidget {
  final String image;
  final String title;
  final int calories;

  const MealOptionCard({
    super.key,
    required this.image,
    required this.title,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);

    return Card(
      color: colorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Image.asset(image, width: 40, height: 40),
        title: Text(title),
        subtitle: Text('$calories kcal'),
        trailing: const Icon(Icons.chevron_right),
        // TODO
        onTap: () {},
      ),
    );
  }
}
