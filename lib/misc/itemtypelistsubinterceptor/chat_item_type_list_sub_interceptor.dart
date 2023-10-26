import 'package:flutter/material.dart';

import '../../domain/entity/chat/user_message.dart';
import '../../domain/entity/user/user.dart';
import '../controllerstate/listitemcontrollerstate/chatlistitemcontrollerstate/chat_bubble_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/chatlistitemcontrollerstate/chat_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../typedef.dart';
import 'item_type_list_sub_interceptor.dart';

class ChatItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  ChatItemTypeListSubInterceptor({
    required this.padding,
    required this.itemSpacing,
    required this.listItemControllerStateItemTypeInterceptorChecker
  });

  @override
  bool intercept(
    int i,
    ListItemControllerStateWrapper oldItemTypeWrapper,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newItemTypeList
  ) {
    ListItemControllerState oldItemType = oldItemTypeWrapper.listItemControllerState;
    List<ListItemControllerState> newChildListItemControllerState = [];
    if (oldItemType is ChatContainerListItemControllerState) {
      ChatContainerInterceptingActionListItemControllerState chatContainerInterceptingActionListItemControllerState = oldItemType.chatContainerInterceptingActionListItemControllerState;
      if (chatContainerInterceptingActionListItemControllerState is DefaultChatContainerInterceptingActionListItemControllerState) {
        chatContainerInterceptingActionListItemControllerState._onUpdateUserMessage = (userMessageList) {
          oldItemType.userMessageList = userMessageList;
          oldItemType.onUpdateState();
        };
        chatContainerInterceptingActionListItemControllerState._onAddUserMessage = (userMessage) {
          oldItemType.userMessageList.add(userMessage);
          oldItemType.onUpdateState();
        };
      }
      User loggedUser = oldItemType.loggedUser;
      List<ChatBubbleListItemControllerState> chatBubbleListItemControllerStateList = oldItemType.userMessageList.map<ChatBubbleListItemControllerState>(
        (userMessage) => ChatBubbleListItemControllerState(userMessage: userMessage, loggedUser: loggedUser)
      ).toList();
      int j = 0;
      while (j < chatBubbleListItemControllerStateList.length) {
        ListItemControllerState listItemControllerState = CompoundListItemControllerState(
          listItemControllerState: [
            if (j > 0) VirtualSpacingListItemControllerState(height: itemSpacing()),
            PaddingContainerListItemControllerState(
              padding: EdgeInsets.symmetric(horizontal: padding()),
              paddingChildListItemControllerState: chatBubbleListItemControllerStateList[j],
            ),
            if (j == chatBubbleListItemControllerStateList.length - 1) VirtualSpacingListItemControllerState(height: padding())
          ]
        );
        listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
          i, ListItemControllerStateWrapper(listItemControllerState), oldItemTypeList, newChildListItemControllerState
        );
        j++;
      }
      newItemTypeList.addAll(newChildListItemControllerState);
      return true;
    }
    return false;
  }
}

class DefaultChatContainerInterceptingActionListItemControllerState extends ChatContainerInterceptingActionListItemControllerState {
  void Function(List<UserMessage>)? _onUpdateUserMessage;
  void Function(UserMessage)? _onAddUserMessage;

  @override
  void Function(List<UserMessage>)? get onUpdateUserMessage => _onUpdateUserMessage ?? (throw UnimplementedError());

  @override
  void Function(UserMessage)? get onAddUserMessage => _onAddUserMessage ?? (throw UnimplementedError());
}