import '../entity/chat_message_entity.dart';

abstract interface class ChatRepository {
  /// This allows the user to ask questions to the AI diet assistant.
  Future<List<ChatMessageEntity>> sendMessage(String message);
}