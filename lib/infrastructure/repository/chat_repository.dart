import '../model/chat_message_model.dart';
import '../service/gemini_functional_service.dart';
import '../../domain/entity/chat_message_entity.dart';
import '../../domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final GeminiFunctionalService geminiService;

  ChatRepositoryImpl(this.geminiService);

  @override
  Future<List<ChatMessageEntity>> sendMessage(String message) async {
    await geminiService.sendMessage(message);
    return ChatMessageModel.fromContents(geminiService.history);
  }
}