import '../../../../domain/entity/chat/help/help_message.dart';
import '../../../../domain/entity/chat/user_message.dart';
import '../../../../domain/entity/user/user.dart';
import '../list_item_controller_state.dart';

class ChatContainerListItemControllerState extends ListItemControllerState {
  List<UserMessage> userMessageList;
  User loggedUser;
  ChatContainerInterceptingActionListItemControllerState chatContainerInterceptingActionListItemControllerState;
  void Function() onUpdateState;

  ChatContainerListItemControllerState({
    required this.userMessageList,
    required this.loggedUser,
    required this.chatContainerInterceptingActionListItemControllerState,
    required this.onUpdateState
  });
}

abstract class ChatContainerInterceptingActionListItemControllerState extends ListItemControllerState {
  void Function(List<UserMessage>)? get onUpdateUserMessage;
  void Function(UserMessage)? get onAddUserMessage;
}