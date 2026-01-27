import 'package:flutter/material.dart';
import '../../../../../../application/validator/name_validator.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../config/app_spacing.dart';

class UsernameSection extends StatelessWidget {
  final TextEditingController controller;

  const UsernameSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).firstWhatCanWeCallYou,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpacing.h08,
        Text(
          S.of(context).wedLikeToGetToKnowYou,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSpacing.h24,
        Text(S.of(context).preferredFirstName, style: textTheme.titleSmall),
        AppSpacing.h08,
        TextFormField(
          controller: controller,
          validator: (value) => nameValidator(value),
        ),
      ],
    );
  }
}
