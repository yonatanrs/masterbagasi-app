import '../../../../domain/entity/chat/help/help_message.dart';
import '../../../../domain/entity/chat/user_message.dart';
import '../../../../domain/entity/user/user.dart';
import '../list_item_controller_state.dart';

class ChatBubbleListItemControllerState extends ListItemControllerState {
  UserMessage userMessage;
  User loggedUser;

  ChatBubbleListItemControllerState({
    required this.userMessage,
    required this.loggedUser
  });
}