import 'package:flutter/material.dart';
import '../../../../../../domain/entity/dialog_entity.dart';
import '../../../../../../infrastructure/extension/context_extension.dart';

class CustomAlertDialog extends StatelessWidget {
  final DialogEntity dialog;

  const CustomAlertDialog({super.key, required this.dialog});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);

    return AlertDialog(
      title: Text(
        dialog.title,
        style: textTheme.titleLarge,
      ),
      content: Text(dialog.content),
      actions: [
        TextButton(onPressed: context.pop, child: const Text('Go back')),
      ],
    );
  }
}
