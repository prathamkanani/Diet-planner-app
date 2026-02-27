import '../../domain/entity/chat_message_entity.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatMessageModel extends ChatMessageEntity {
  ChatMessageModel({
    required super.message,
    required super.fromAssistant,
    required super.loading,
  });

  static List<ChatMessageModel> fromContents(List<Content> history) {
    return history
        .where((content) => content.role == 'user' || content.role == 'model')
        .where((content) => content.parts.any((p) => p is TextPart))
        .map(fromContent)
        .toList();
  }

  static ChatMessageModel fromContent(Content message) {
    return ChatMessageModel(
      message: [
        for (final part in message.parts)
          if (part is TextPart) part.text,
      ].join(""),
      fromAssistant: message.role != "user",
      loading: false,
    );
  }
}
