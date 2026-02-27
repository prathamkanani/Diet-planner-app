import 'package:google_generative_ai/google_generative_ai.dart';
import '../../domain/entity/user_preferences.dart';
import '../../env.dart';
import '../model/meal_plan_preferences.dart';

class GeminiClientService {
  GeminiClientService();

  Future<String?> generateMealAI(UserPreferences userPreferences) async {
    final geminiModel = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: geminiKey,
      systemInstruction: Content.text('''
    You are a certified nutritionist AI.

    USER PROFILE:
    - Country: ${userPreferences.country}
    - Activity level: ${userPreferences.activityLevel.name}
    - Meal Preference: ${userPreferences.mealPref.name}
    - Daily calorie target: Research what is average calorie target according 
      to the provided data and consider that value.
      
     DIETARY PREFERENCE RULES (STRICT):
    - vegetarian: 
      - Allowed: plant-based foods, dairy, eggs
      - Forbidden: meat, poultry, fish, seafood
    - non_vegetarian:
      - Allowed: all foods including meat, poultry, fish, eggs, dairy
    - vegan:
      - Allowed: plant-based foods only
      - Forbidden: all animal products including meat, poultry, fish, dairy, eggs, honey
    - pescatarian:
      - Allowed: plant-based foods, fish, seafood, dairy, eggs
      - Forbidden: meat and poultry
    
    IMPORTANT:
    - Do NOT include any forbidden ingredients based on the selected meal preference
    - If a meal violates the preference, the entire response is invalid
    
    DIET RULES:
    ${MealPlanPreferences.activityInstructions(userPreferences.activityLevel)}
    
    INGREDIENT RULES:
    ${MealPlanPreferences.countryInstructions(userPreferences.country)}
    
    MEAL PLAN RULES:
    - Generate a 7-day meal plan starting from today
    - Each day must include breakfast, lunch, and dinner
    - Each meal should contain 1–2 food items
    - Use realistic portion sizes
    - Balance macros across the day
    - Generate EXACTLY TWO meal options
    - Do not generate more or fewer than two
    - Both options must be different
    - Each option must be a complete meal item
    - For each meal, label the two options as "A" and "B"
    - There must be exactly one "A" and one "B" per meal

    
    OUTPUT RULES:
    - Follow the provided JSON schema strictly
    - Output valid JSON only
    - Do not include explanations, markdown, or extra text
    '''),
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: generateMealPlanSchema,
      ),
      // tools: [Tool(functionDeclarations: [])],
    );

    final response = await geminiModel.generateContent([
      Content.text('Generate the meal plan.'),
    ]);

    return response.text;
  }

  late final generateMealPlanSchema = Schema(
    SchemaType.array,
    items: Schema(
      SchemaType.object,
      properties: {
        'day': Schema(
          SchemaType.string,
          description:
              'Day of the week. Must be one of Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday.',
        ),
        'meals': Schema(
          SchemaType.object,
          properties: {
            'breakfast': Schema(SchemaType.array, items: mealItemSchema),
            'lunch': Schema(SchemaType.array, items: mealItemSchema),
            'dinner': Schema(SchemaType.array, items: mealItemSchema),
          },
          requiredProperties: ['breakfast', 'lunch', 'dinner'],
        ),
      },
      requiredProperties: ['day', 'meals'],
    ),
  );

  final mealItemSchema = Schema(
    SchemaType.object,
    properties: {
      'option': Schema.enumString(
        enumValues: ['A', 'B'],
        description: 'Meal Options',
      ),
      'name': Schema(SchemaType.string),
      'calories': Schema(SchemaType.number),
      'protein_g': Schema(SchemaType.number),
      'carbs_g': Schema(SchemaType.number),
      'fat_g': Schema(SchemaType.number),
    },
    requiredProperties: [
      'option',
      'name',
      'calories',
      'protein_g',
      'carbs_g',
      'fat_g',
    ],
  );
}
