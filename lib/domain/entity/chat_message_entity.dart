/// Chat for talking with AI Diet assistant.
class ChatMessageEntity {
  /// The message sent or received
  final String message;

  /// To check whether the message is from assistant or user
  final bool fromAssistant;

  /// To check whether the message is loading or not
  final bool loading;

  ChatMessageEntity({
    required this.message,
    required this.fromAssistant,
    required this.loading,
  });
}
