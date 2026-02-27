import 'chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../application/logic/chat/chat_cubit.dart';
import '../../../application/logic/chat/chat_state.dart';
import '../../../domain/entity/chat_message_entity.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../infrastructure/extension/context_extension.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatCubit cubit;
  late final TextEditingController controller;
  late final ChatSession chat;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    cubit = locator.get();
  }

  @override
  void dispose() {
    cubit.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;

    return Scaffold(
      backgroundColor: cs.secondaryContainer,
      appBar: AppBar(title: const Text('Diet Assistant')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder(
                bloc: cubit,
                builder: (_, state) {
                  List<ChatMessageEntity> messages = [
                    ChatMessageEntity(
                      message: 'Ask for number of meals logged on any day?',
                      fromAssistant: false,
                      loading: false,
                    ),
                  ];
                  if (state is ChatLoadedState) messages.addAll(state.messages);

                  if (state is ChatLoadingState) {
                    messages.add(
                      ChatMessageEntity(
                        message: '',
                        fromAssistant: true,
                        loading: true,
                      ),
                    );
                  }

                  return ChatList(chat: messages);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: cs.surface,
              child: BlocBuilder<ChatCubit, ChatState>(
                bloc: cubit,
                builder: (context, state) {
                  final isLoading = state is ChatLoadingState;

                  return TextField(
                    controller: controller,
                    enabled: !isLoading,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _send(),
                    decoration: InputDecoration(
                      hintText: 'Ask about your logged meals…',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: cs.onPrimaryContainer),
                        onPressed: isLoading ? null : () => _send(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //region Custom Methods
  void _send() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    cubit.sendMessage(text);
    controller.clear();
  }

  //endregion
}
