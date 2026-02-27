import '../../env.dart';
import 'gemini_functions.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final geminiAssistant = GenerativeModel(
  model: 'gemini-2.5-flash-lite',
  apiKey: geminiKey,
  systemInstruction: Content.system(
  '''
    You are a diet assistant.
    Use functions when users ask about meals logged on a date.
  '''),
  tools: [
    Tool(functionDeclarations: [getMealsLoggedForDateFunction]),
  ],
);
