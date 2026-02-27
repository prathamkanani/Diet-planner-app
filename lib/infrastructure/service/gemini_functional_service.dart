import '../utils/helpers.dart';
import 'gemini_assistant.dart';
import '../extension/generic_day_extension.dart';
import '../../domain/repository/report_repository.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

enum GenericDay {
  today('today'),
  yesterday('yesterday'),
  dayBeforeYesterday('day_before_yesterday'),
  specificDate('specific_date');

  final String label;

  const GenericDay(this.label);
}

class GeminiFunctionalService {
  final ReportRepository reportRepository;
  final GenerativeModel _model = geminiAssistant;
  late final ChatSession _chat = _model.startChat();

  GeminiFunctionalService(this.reportRepository);

  List<Content> get history => _chat.history.toList();

  /// The model identifies which function to call
  /// and generate the output accordingly.
  Future<Content> resolveFunctionCall(FunctionCall call) async {
    switch (call.name) {
      case 'getMealsLoggedForDate':
        String? specificDate;
        final String day = call.args['day'] as String;
        final GenericDay genericDay = GenericDayMapper.fromLabel(day);
        if (genericDay == GenericDay.specificDate) {
          specificDate = call.args['date'] as String;
        }

        final date = dateFromGenericDay(genericDay, specificDate);

        // Contains meals logged for a single day.
        final log = await reportRepository.fetchMealLogCount(date, date);

        // Model's response after function calling.
        return Content.functionResponse(call.name, {
          'date': date.toIso8601String(),
          'mealsLogged': log.first.mealsLogged,
        });

      default:
        throw Exception('Unknown function: ${call.name}');
    }
  }

  /// The model responded after executing function calling and now we need
  /// it to send the message back to the user with certain response.
  Future<void> handleFunctionCalls(GenerateContentResponse response) async {
    var currentResponse = response;

    while (currentResponse.functionCalls.isNotEmpty) {
      final call = currentResponse.functionCalls.first;

      final functionResult = await resolveFunctionCall(call);

      currentResponse = await _chat.sendMessage(functionResult);
    }
  }

  /// User sends the message.
  Future<void> sendMessage(String message) async {
    final response = await _chat.sendMessage(Content.text(message));

    await handleFunctionCalls(response);
  }
}
