import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../config/app_spacing.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final TextTheme textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: cs.secondaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              CircularProgressIndicator(color: cs.primary),
              AppSpacing.h16,
              Text(
                S.of(context).waitWhileTheMealPlanIsGenerated,
                style: textTheme.titleMedium,
                textAlign: .center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
