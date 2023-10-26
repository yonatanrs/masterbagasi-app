import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';

import '../../controller/product_chat_controller.dart';
import '../../domain/entity/chat/product/answer_product_conversation_parameter.dart';
import '../../domain/entity/chat/product/create_product_conversation_parameter.dart';
import '../../domain/entity/chat/product/create_product_conversation_response.dart';
import '../../domain/entity/chat/product/get_product_message_by_product_parameter.dart';
import '../../domain/entity/chat/product/get_product_message_by_product_response.dart';
import '../../domain/entity/chat/product/get_product_message_by_user_parameter.dart';
import '../../domain/entity/chat/product/get_product_message_by_user_response.dart';
import '../../domain/entity/chat/user_message_response_wrapper.dart';
import '../../domain/entity/user/getuser/get_user_parameter.dart';
import '../../domain/entity/user/getuser/get_user_response.dart';
import '../../domain/entity/user/user.dart';
import '../../domain/usecase/answer_product_conversation_use_case.dart';
import '../../domain/usecase/create_product_conversation_use_case.dart';
import '../../domain/usecase/get_product_message_by_product_use_case.dart';
import '../../domain/usecase/get_product_message_by_user_use_case.dart';
import '../../domain/usecase/get_user_use_case.dart';
import '../../misc/constant.dart';
import '../../misc/controllerstate/listitemcontrollerstate/chatlistitemcontrollerstate/chat_container_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/error/empty_chat_error.dart';
import '../../misc/error/message_error.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/itemtypelistsubinterceptor/chat_item_type_list_sub_interceptor.dart';
import '../../misc/itemtypelistsubinterceptor/delivery_cart_item_type_list_sub_interceptor.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/paging/modified_paging_controller.dart';
import '../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/paging/pagingresult/paging_result.dart';
import '../widget/modified_paged_list_view.dart';
import '../widget/modified_svg_picture.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import '../widget/tap_area.dart';
import 'getx_page.dart';

class ProductChatPage extends RestorableGetxPage<_ProductChatPageRestoration> {
  final String productId;

  late final ControllerMember<ProductChatController> _productChatController = ControllerMember<ProductChatController>().addToControllerManager(controllerManager);

  ProductChatPage({Key? key, required this.productId}) : super(key: key, pageRestorationId: () => "product-chat-page");

  @override
  void onSetController() {
    _productChatController.controller = GetExtended.put<ProductChatController>(
      ProductChatController(
        controllerManager,
        Injector.locator<GetProductMessageByUserUseCase>(),
        Injector.locator<GetProductMessageByProductUseCase>(),
        Injector.locator<CreateProductConversationUseCase>(),
        Injector.locator<AnswerProductConversationUseCase>(),
        Injector.locator<GetUserUseCase>(),
      ),
      tag: pageName
    );
  }

  @override
  _ProductChatPageRestoration createPageRestoration() => _ProductChatPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _StatefulProductChatControllerMediatorWidget(
        productId: productId,
        productChatController: _productChatController.controller,
      ),
    );
  }
}

class _ProductChatPageRestoration extends MixableGetxPageRestoration with ProductChatPageRestorationMixin {
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

class ProductChatPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  final String productId;

  ProductChatPageGetPageBuilderAssistant({
    required this.productId
  });

  @override
  GetPageBuilder get pageBuilder => (() => ProductChatPage(productId: productId));

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(ProductChatPage(productId: productId)));
}

mixin ProductChatPageRestorationMixin on MixableGetxPageRestoration {
  late ProductChatPageRestorableRouteFuture productChatPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    productChatPageRestorableRouteFuture = ProductChatPageRestorableRouteFuture(restorationId: restorationIdWithPageName('product-chat-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    productChatPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    productChatPageRestorableRouteFuture.dispose();
  }
}

class ProductChatPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  ProductChatPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    if (arguments is! String) {
      throw MessageError(message: "Arguments must be a String");
    }
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(ProductChatPageGetPageBuilderAssistant(productId: arguments))
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

class _StatefulProductChatControllerMediatorWidget extends StatefulWidget {
  final String productId;
  final ProductChatController productChatController;

  const _StatefulProductChatControllerMediatorWidget({
    required this.productId,
    required this.productChatController
  });

  @override
  State<_StatefulProductChatControllerMediatorWidget> createState() => _StatefulProductChatControllerMediatorWidgetState();
}

class _StatefulProductChatControllerMediatorWidgetState extends State<_StatefulProductChatControllerMediatorWidget> {
  late final ScrollController _productChatScrollController;
  late final ModifiedPagingController<int, ListItemControllerState> _productChatListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _productChatListItemPagingControllerState;

  final TextEditingController _productChatTextEditingController = TextEditingController();
  bool _isFirstEmpty = false;

  final DefaultChatContainerInterceptingActionListItemControllerState _defaultChatContainerInterceptingActionListItemControllerState = DefaultChatContainerInterceptingActionListItemControllerState();

  @override
  void initState() {
    super.initState();
    _productChatScrollController = ScrollController();
    _productChatListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.productChatController.apiRequestManager
    );
    _productChatListItemPagingControllerState = PagingControllerState(
      pagingController: _productChatListItemPagingController,
      isPagingControllerExist: false
    );
    _productChatListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _helpChatListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _productChatListItemPagingControllerState.isPagingControllerExist = true;
  }

  Future<UserMessageResponseWrapper<GetProductMessageByProductResponse>> getProductMessageByProduct() async {
    LoadDataResult<User> getUserLoadDataResult = await widget.productChatController.getUser(
      GetUserParameter()
    ).map<User>((value) => value.user);
    if (getUserLoadDataResult.isFailed) {
      Future<LoadDataResult<GetProductMessageByProductResponse>> returnUserLoadFailed() async {
        return getUserLoadDataResult.map<GetProductMessageByProductResponse>(
          // This is for required argument purposes only, not will be used for further process
          (_) => GetProductMessageByProductResponse(
            id: "",
            userOne: null,
            userTwo: null,
            unreadMessagesCount: 1,
            productMessageList: []
          )
        );
      }
      return UserMessageResponseWrapper(
        userLoadDataResult: getUserLoadDataResult,
        valueLoadDataResult: await returnUserLoadFailed()
      );
    }
    return UserMessageResponseWrapper(
      userLoadDataResult: getUserLoadDataResult,
      valueLoadDataResult: await widget.productChatController.getProductMessageByProduct(
        GetProductMessageByProductParameter(productId: widget.productId)
      )
    );
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _helpChatListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? listItemControllerStateList) async {
    UserMessageResponseWrapper<GetProductMessageByProductResponse> getProductMessageByProductResponseLoadDataResult = await getProductMessageByProduct();
    if (getProductMessageByProductResponseLoadDataResult.valueLoadDataResult.isFailed) {
      dynamic e = getProductMessageByProductResponseLoadDataResult.valueLoadDataResult.resultIfFailed;
      if (e is EmptyChatError) {
        _isFirstEmpty = true;
        User user = getProductMessageByProductResponseLoadDataResult.userLoadDataResult.resultIfSuccess!;
        return SuccessLoadDataResult(
          value: PagingDataResult<ListItemControllerState>(
            itemList: [
              ChatContainerListItemControllerState(
                userMessageList: [],
                loggedUser: user,
                chatContainerInterceptingActionListItemControllerState: _defaultChatContainerInterceptingActionListItemControllerState,
                onUpdateState: () => setState(() {})
              )
            ],
            page: 1,
            totalPage: 1,
            totalItem: 1
          )
        );
      }
    }
    return getProductMessageByProductResponseLoadDataResult.valueLoadDataResult.map<PagingResult<ListItemControllerState>>((getProductMessageByUserResponse) {
      User user = getProductMessageByProductResponseLoadDataResult.userLoadDataResult.resultIfSuccess!;
      return PagingDataResult<ListItemControllerState>(
        itemList: [
          ChatContainerListItemControllerState(
            userMessageList: getProductMessageByUserResponse.productMessageList,
            loggedUser: user,
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
            Text("Product Chat".tr),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
                pagingControllerState: _productChatListItemPagingControllerState,
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
                        controller: _productChatTextEditingController,
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
                      onTap: () async {
                        if (_isFirstEmpty) {
                          await widget.productChatController.createChatConversation(
                            CreateProductConversationParameter(
                              productId: widget.productId,
                              message: _productChatTextEditingController.text
                            )
                          );
                          _isFirstEmpty = false;
                          var productResponse = await getProductMessageByProduct();
                          if (productResponse.valueLoadDataResult.isSuccess) {
                            if (_defaultChatContainerInterceptingActionListItemControllerState.onUpdateUserMessage != null) {
                              _defaultChatContainerInterceptingActionListItemControllerState.onUpdateUserMessage!(
                                productResponse.valueLoadDataResult.resultIfSuccess!.productMessageList
                              );
                            }
                          }
                        } else {
                          widget.productChatController.answerProductConversation(
                            AnswerProductConversationParameter(
                              productConversationId: "",
                              message: _productChatTextEditingController.text
                            )
                          );
                        }
                      },
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
}