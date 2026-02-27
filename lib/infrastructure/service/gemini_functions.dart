import 'package:google_generative_ai/google_generative_ai.dart';

final getMealsLoggedForDateFunction = FunctionDeclaration(
  'getMealsLoggedForDate',
  'Get number of meals logged for a specific date, usually between the range [0, 3]',
  Schema.object(
    properties: {
      'day': Schema.enumString(
        enumValues: [
          'today',
          'yesterday',
          'day_before_yesterday',
          'specific_date',
        ],
        description:
            'One of: today, yesterday, day before yesterday, specific_date',
      ),
      'date': Schema.string(
        description:
            'REQUIRED: If day is specific_date, get date in format: YYYY-MM-DD',
      ),
    },
    requiredProperties: ['day'],
  ),
);
