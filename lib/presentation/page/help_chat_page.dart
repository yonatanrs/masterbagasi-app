import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/controller/help_chat_controller.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';
import 'package:masterbagasi/misc/getextended/get_extended.dart';
import 'package:masterbagasi/misc/getextended/get_restorable_route_future.dart';
import 'package:masterbagasi/misc/manager/controller_manager.dart';
import 'package:masterbagasi/misc/paging/pagingresult/paging_data_result.dart';
import 'package:masterbagasi/presentation/widget/modified_paged_list_view.dart';
import 'package:masterbagasi/presentation/widget/modifiedappbar/modified_app_bar.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../domain/entity/chat/help/create_help_conversation_parameter.dart';
import '../../domain/entity/chat/help/get_help_message_by_user_parameter.dart';
import '../../domain/entity/chat/help/get_help_message_by_user_response.dart';
import '../../domain/entity/user/getuser/get_user_parameter.dart';
import '../../domain/entity/user/getuser/get_user_response.dart';
import '../../domain/usecase/answer_help_conversation_use_case.dart';
import '../../domain/usecase/create_help_conversation_use_case.dart';
import '../../domain/usecase/get_help_message_by_user_use_case.dart';
import '../../domain/usecase/get_user_use_case.dart';
import '../../misc/constant.dart';
import '../../misc/controllerstate/listitemcontrollerstate/chatlistitemcontrollerstate/chat_container_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/injector.dart';
import '../../misc/itemtypelistsubinterceptor/chat_item_type_list_sub_interceptor.dart';
import '../../misc/load_data_result.dart';
import '../../misc/paging/modified_paging_controller.dart';
import '../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../misc/paging/pagingresult/paging_result.dart';
import '../widget/modified_svg_picture.dart';
import '../widget/tap_area.dart';
import 'getx_page.dart';

class HelpChatPage extends RestorableGetxPage<_HelpChatPageRestoration> {
  late final ControllerMember<HelpChatController> _helpChatController = ControllerMember<HelpChatController>().addToControllerManager(controllerManager);

  HelpChatPage({Key? key}) : super(key: key, pageRestorationId: () => "help-chat-page");

  @override
  void onSetController() {
    _helpChatController.controller = GetExtended.put<HelpChatController>(
      HelpChatController(
        controllerManager,
        Injector.locator<GetHelpMessageByUserUseCase>(),
        Injector.locator<CreateHelpConversationUseCase>(),
        Injector.locator<AnswerHelpConversationUseCase>(),
        Injector.locator<GetUserUseCase>()
      ),
      tag: pageName
    );
  }

  @override
  _HelpChatPageRestoration createPageRestoration() => _HelpChatPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _StatefulHelpChatControllerMediatorWidget(
        helpChatController: _helpChatController.controller,
      ),
    );
  }
}

class _HelpChatPageRestoration extends MixableGetxPageRestoration with HelpChatPageRestorationMixin {
  @override
  // ignore: unnecessary_overrides
  void initState() {
    super.initState();
  }

  @override
  // ignore: unnecessary_overrides
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  // ignore: unnecessary_overrides
  void dispose() {
    super.dispose();
  }
}

class HelpChatPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  @override
  GetPageBuilder get pageBuilder => (() => HelpChatPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(HelpChatPage()));
}

mixin HelpChatPageRestorationMixin on MixableGetxPageRestoration {
  late HelpChatPageRestorableRouteFuture helpChatPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    helpChatPageRestorableRouteFuture = HelpChatPageRestorableRouteFuture(restorationId: restorationIdWithPageName('help-chat-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    helpChatPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    helpChatPageRestorableRouteFuture.dispose();
  }
}

class HelpChatPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  HelpChatPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(HelpChatPageGetPageBuilderAssistant())
    );
  }

  @pragma('vm:entry-point')
  static Route<void> _pageRouteBuilder(BuildContext context, Object? arguments) {
    return _getRoute(arguments)!;
  }

  @override
  bool checkBeforePresent([Object? arguments]) => _getRoute(arguments) != null;

  @override
  void presentIfCheckIsPassed([Object? arguments]) => _pageRoute.present(arguments);

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    restorator.registerForRestoration(_pageRoute, restorationId);
  }

  @override
  void dispose() {
    _pageRoute.dispose();
  }
}

class _StatefulHelpChatControllerMediatorWidget extends StatefulWidget {
  final HelpChatController helpChatController;

  const _StatefulHelpChatControllerMediatorWidget({
    required this.helpChatController
  });

  @override
  State<_StatefulHelpChatControllerMediatorWidget> createState() => _StatefulHelpChatControllerMediatorWidgetState();
}

class _StatefulHelpChatControllerMediatorWidgetState extends State<_StatefulHelpChatControllerMediatorWidget> {
  late final ScrollController _helpChatScrollController;
  late final ModifiedPagingController<int, ListItemControllerState> _helpChatListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _helpChatListItemPagingControllerState;
  PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

  final TextEditingController _helpTextEditingController = TextEditingController();
  final DefaultChatContainerInterceptingActionListItemControllerState _defaultChatContainerInterceptingActionListItemControllerState = DefaultChatContainerInterceptingActionListItemControllerState();

  @override
  void initState() {
    super.initState();
    _helpChatScrollController = ScrollController();
    _helpChatListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.helpChatController.apiRequestManager
    );
    _helpChatListItemPagingControllerState = PagingControllerState(
      pagingController: _helpChatListItemPagingController,
      isPagingControllerExist: false
    );
    _helpChatListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _helpChatListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _helpChatListItemPagingControllerState.isPagingControllerExist = true;
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _helpChatListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? listItemControllerStateList) async {
    LoadDataResult<GetUserResponse> getUserResponse = await widget.helpChatController.getUser(
      GetUserParameter()
    );
    if (getUserResponse.isFailed) {
      Future<LoadDataResult<PagingResult<ListItemControllerState>>> returnUserLoadFailed() async {
        return getUserResponse.map<PagingResult<ListItemControllerState>>(
          // This is for required argument purposes only, not will be used for further process
          (_) => PagingDataResult<ListItemControllerState>(
            itemList: [],
            page: 1,
            totalPage: 1,
            totalItem: 1
          )
        );
      }
      return returnUserLoadFailed();
    }
    LoadDataResult<GetHelpMessageByUserResponse> getHelpMessageByUserResponseLoadDataResult = await widget.helpChatController.getHelpMessageByUser(
      GetHelpMessageByUserParameter()
    );
    await _connectToPusher();
    return getHelpMessageByUserResponseLoadDataResult.map<PagingResult<ListItemControllerState>>((getHelpMessageByUserResponse) {
      return PagingDataResult<ListItemControllerState>(
        itemList: [
          ChatContainerListItemControllerState(
            userMessageList: getHelpMessageByUserResponse.helpMessageList,
            loggedUser: getUserResponse.resultIfSuccess!.user,
            chatContainerInterceptingActionListItemControllerState: _defaultChatContainerInterceptingActionListItemControllerState,
            onUpdateState: () => setState(() {})
          )
        ],
        page: 1,
        totalPage: 1,
        totalItem: 1
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModifiedAppBar(
        titleInterceptor: (context, title) => Row(
          children: [
            Text("Mista".tr),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
                pagingControllerState: _helpChatListItemPagingControllerState,
                onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
                  pagingControllerState: pagingControllerState!
                ),
                pullToRefresh: true
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Constant.colorGrey4
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _helpTextEditingController,
                        decoration: InputDecoration.collapsed(
                          hintText: "Type Chat".tr,
                        ),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: 5
                      ),
                    ),
                    TapArea(
                      onTap: () => widget.helpChatController.createHelpConversation(
                        CreateHelpConversationParameter(message: _helpTextEditingController.text)
                      ),
                      child: ModifiedSvgPicture.asset(Constant.vectorSendMessage, overrideDefaultColorWithSingleColor: false),
                    )
                  ],
                )
              )
            )
          ]
        )
      ),
    );
  }

  Future<void> _connectToPusher() async {
    try {
      await _pusher.init(
        apiKey: "aec3cf529553db66701a",
        cluster: "ap1",
        onConnectionStateChange: _onConnectionStateChange,
        onError: _onError,
        onEvent: _onEvent,
        onDecryptionFailure: _onDecryptionFailure,
      );
      await _pusher.subscribe(channelName: "masterbagasi.com-development");
      await _pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void _onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print("Connection: $currentState");
  }

  void _onError(String message, int? code, dynamic e) {
    print("onError: $message code: $code exception: $e");
  }

  void _onEvent(PusherEvent event) {
    print("onEvent: $event");
  }

  void _onDecryptionFailure(String event, String reason) {
    print("onDecryptionFailure: $event reason: $reason");
  }

  @override
  void dispose() {
    _helpTextEditingController.dispose();
    _pusher.disconnect();
    super.dispose();
  }
}