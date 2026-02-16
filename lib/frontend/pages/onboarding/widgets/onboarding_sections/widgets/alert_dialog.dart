import 'package:flutter/material.dart';
import '../../../../../../domain/entity/dialog_entity.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../infrastructure/extension/context_extension.dart';

class CustomAlertDialog extends StatelessWidget {
  final DialogEntity dialog;

  const CustomAlertDialog({super.key, required this.dialog});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final bool isContent = dialog.content != null;

    return AlertDialog(
      title: Text(
        dialog.title,
        style: textTheme.titleLarge,
      ),
      content: isContent ? Text(dialog.content!) : null,
      actions: [
        TextButton(onPressed: context.pop, child: Text(S.of(context).goBack)),
      ],
    );
  }
}
