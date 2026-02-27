import 'package:flutter/material.dart';
import '../../config/app_spacing.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../domain/entity/chat_message_entity.dart';
import '../../../infrastructure/extension/context_extension.dart';

class ChatList extends StatelessWidget {
  final List<ChatMessageEntity> chat;

  const ChatList({required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    final th = context.th;
    final cs = context.cs;

    return Container(
      decoration: BoxDecoration(color: cs.surface),
      child: ListView.builder(
        reverse: true,
        itemCount: chat.length,
        itemBuilder: (context, index) {
          final reverseIndex = chat.length - index - 1;
          final message = chat[reverseIndex];
          return Container(
            padding: EdgeInsetsDirectional.only(
              start: message.fromAssistant ? 8.0 : 24,
              end: message.fromAssistant ? 24.0 : 8,
              top: 8.0,
              bottom: 8.0,
            ),
            alignment: message.fromAssistant
                ? AlignmentDirectional.centerStart
                : AlignmentDirectional.centerEnd,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ... spreads inner list so it is broken down from
                    // list of list of widgets to list of widgets.
                    if (message.fromAssistant) ...[
                      Text("Diet assistant", style: th.titleSmall),
                      AppSpacing.h08,
                    ],
                    if (message.loading)
                      const CircularProgressIndicator()
                    else
                      MarkdownBody(data: message.message),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
