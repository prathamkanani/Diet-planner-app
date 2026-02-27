import 'chat_state.dart';
import '../../../domain/repository/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This is responsible for sending message to the AI diet assistant.
class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;

  ChatCubit({required this.repository}) : super(const ChatInitialState());

  Future<void> sendMessage(String text) async {
    emit(const ChatLoadingState());

    final messages = await repository.sendMessage(text);

    emit(ChatLoadedState(messages: messages));
  }
}