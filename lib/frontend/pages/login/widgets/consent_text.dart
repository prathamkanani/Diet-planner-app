import 'package:flutter/material.dart';

/// Consent Text for play store/appstore approval
class ConsentText extends StatelessWidget {
  const ConsentText({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return Column(
      children: [
        Text(
          '',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSecondary,
          ),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.primary,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.tertiary,
                ),
              ),
              TextSpan(
                text: '',
                style: TextStyle(color: colorScheme.onSecondary),
              ),
              TextSpan(
                text: '',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.tertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
