// import 'package:google_generative_ai/google_generative_ai.dart';
// import '../../domain/entity/activity_level_entity.dart';
// import '../../domain/entity/meal_entity.dart';
// import '../../env.dart';
// import '../model/meal_plan_preferences.dart';
//
// final geminiModel = GenerativeModel(
//   model: 'gemini-2.5-flash',
//   apiKey: geminiKey,
//   systemInstruction: Content.text('''
//     You are a certified nutritionist AI.
//
//     USER PROFILE:
//     - Country: India
//     - Activity level: Low
//     - Daily calorie target: ${prefs.dailyCalories}
//
//     DIET RULES:
//     ${MealPlanPreferences.activityInstructions(prefs.activityLevel)}
//
//     INGREDIENT RULES:
//     ${MealPlanPreferences.countryInstructions(prefs.country)}
//
//     MEAL PLAN RULES:
//     - Generate a 7-day meal plan starting from today
//     - Each day must include breakfast, lunch, and dinner
//     - Each meal should contain 1–2 food items
//     - Use realistic portion sizes
//     - Balance macros across the day
//
//     OUTPUT RULES:
//     - Follow the provided JSON schema strictly
//     - Output valid JSON only
//     - Do not include explanations, markdown, or extra text
//   '''),
//   generationConfig: GenerationConfig(
//     responseMimeType: 'application/json',
//     responseSchema: generateMealPlanSchema,
//   ),
//   tools: [
//     Tool(functionDeclarations: [generateMealPlan]),
//   ],
// );
//
// Future<String?> generateMeal() async {
//   final response = await geminiModel.generateContent([
//     Content.text('Generate the meal plan.'),
//   ]);
//
//   return response.text;
// }
//
// Future<void> generateMealPlan(
//   Map<String, Object?> arguments,
// ) async {
//   final chat = geminiModel.startChat();
//   final prompt = arguments['text']?.toString();
//   var response = await chat.sendMessage(Content.text(prompt ?? ''));
//
//   final functionCalls = response.functionCalls;
//   if (functionCalls.isNotEmpty) {
//     response = await _handleFunctionCalls(functionCalls.first);
//   }
// }
//
// final mealItemSchema = Schema(
//   SchemaType.object,
//   properties: {
//     'name': Schema(SchemaType.string),
//     'calories': Schema(SchemaType.number),
//     'protein_g': Schema(SchemaType.number),
//     'carbs_g': Schema(SchemaType.number),
//     'fat_g': Schema(SchemaType.number),
//   },
//   requiredProperties: ['name', 'calories', 'protein_g', 'carbs_g', 'fat_g'],
// );
//
// final generateMealPlanSchema = Schema(
//   SchemaType.array,
//   items: Schema(
//     SchemaType.object,
//     properties: {
//       'day': Schema(
//         SchemaType.string,
//         description:
//             'Day of the week. Must be one of Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday.',
//       ),
//       'meals': Schema(
//         SchemaType.object,
//         properties: {
//           'breakfast': Schema(SchemaType.array, items: mealItemSchema),
//           'lunch': Schema(SchemaType.array, items: mealItemSchema),
//           'dinner': Schema(
//             SchemaType.array,
//             items: Schema(
//               SchemaType.object,
//               properties: {
//                 'name': Schema(SchemaType.string),
//                 'calories': Schema(SchemaType.number),
//                 'protein_g': Schema(SchemaType.number),
//                 'carbs_g': Schema(SchemaType.number),
//                 'fat_g': Schema(SchemaType.number),
//               },
//               requiredProperties: [
//                 'name',
//                 'calories',
//                 'protein_g',
//                 'carbs_g',
//                 'fat_g',
//               ],
//             ),
//           ),
//         },
//         requiredProperties: ['breakfast', 'lunch', 'dinner'],
//       ),
//     },
//     requiredProperties: ['day', 'meals'],
//   ),
// );
//
// Future<GenerateContentResponse> _handleFunctionCalls(
//   FunctionCall functionCall,
// ) async {
//   final _ = switch (functionCall.name) {
//     'generateMealPlanMethodCall' => await generateMeal(functionCall.args),
//     String() => throw UnimplementedError(),
//   };
//
//   final chat = geminiModel.startChat();
//   return chat.sendMessage(Content.functionResponse(functionCall.name));
// }
