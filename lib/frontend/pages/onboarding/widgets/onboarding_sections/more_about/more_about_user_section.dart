import 'package:flutter/material.dart';
import '../../../../../config/app_spacing.dart';

class MoreAboutUserSection extends StatelessWidget {
  final TextEditingController heightController;
  final TextEditingController weightController;

  const MoreAboutUserSection({
    super.key,
    required this.heightController,
    required this.weightController,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            'Just a few more questions',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          AppSpacing.h24,
          Text('How tall are you? (in cm)', style: textTheme.titleSmall),
          AppSpacing.h08,
          TextFormField(controller: heightController, keyboardType: .number),
          AppSpacing.h16,
          Text('How much do you weigh? (in kg)', style: textTheme.titleSmall),
          AppSpacing.h08,
          TextFormField(controller: weightController, keyboardType: .number),
        ],
      ),
    );
  }
}
