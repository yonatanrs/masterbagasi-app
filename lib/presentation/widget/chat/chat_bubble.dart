import 'package:flutter/material.dart';

import '../../../domain/entity/chat/help/help_message.dart';
import '../../../domain/entity/chat/user_message.dart';
import '../../../domain/entity/user/user.dart';
import '../../../misc/constant.dart';

class ChatBubble extends StatelessWidget {
  final UserMessage userMessage;
  final User loggedUser;

  const ChatBubble({
    super.key,
    required this.userMessage,
    required this.loggedUser
  });

  @override
  Widget build(BuildContext context) {
    bool isLoggedUser = userMessage.userId == loggedUser.id;
    return Column(
      crossAxisAlignment: isLoggedUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!isLoggedUser) ... [
          Text(userMessage.userChat.name, style: const TextStyle(fontSize: 11)),
          const SizedBox(height: 5),
        ],
        Container(
          decoration: BoxDecoration(
            color: isLoggedUser ? Constant.colorMain : Constant.colorGrey6,
            borderRadius: BorderRadius.circular(8)
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            userMessage.message,
            style: TextStyle(
              color: isLoggedUser ? Colors.white : null
            )
          ),
        )
      ],
    );
  }
}