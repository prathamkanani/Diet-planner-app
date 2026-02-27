import '../../../domain/entity/chat_message_entity.dart';

sealed class ChatState {
  const ChatState();
}

final class ChatInitialState extends ChatState {
  const ChatInitialState();
}

final class ChatLoadingState extends ChatState {
  const ChatLoadingState();
}

final class ChatLoadedState extends ChatState {
  final List<ChatMessageEntity> messages;

  const ChatLoadedState({required this.messages});
}
