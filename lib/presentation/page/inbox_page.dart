import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';

import '../../controller/inbox_controller.dart';
import '../../domain/entity/faq/faq.dart';
import '../../domain/entity/faq/faq_list_parameter.dart';
import '../../domain/usecase/get_faq_list_use_case.dart';
import '../../misc/constant.dart';
import '../../misc/controllerstate/listitemcontrollerstate/divider_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/faqlistitemcontrollerstate/faq_container_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/faqlistitemcontrollerstate/faq_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/profilemenulistitemcontrollerstate/profile_menu_list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/dialog_helper.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/page_restoration_helper.dart';
import '../../misc/paging/modified_paging_controller.dart';
import '../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/paging/pagingresult/paging_result.dart';
import '../widget/modified_paged_list_view.dart';
import '../widget/modified_svg_picture.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import '../widget/titleanddescriptionitem/title_and_description_item.dart';
import 'deliveryreview/delivery_review_page.dart';
import 'getx_page.dart';
import 'help_page.dart';
import 'product_discussion_page.dart';

class InboxPage extends RestorableGetxPage<_InboxPageRestoration> {
  late final ControllerMember<InboxController> _inboxController = ControllerMember<InboxController>().addToControllerManager(controllerManager);

  InboxPage({Key? key}) : super(key: key, pageRestorationId: () => "inbox-page");

  @override
  void onSetController() {
    _inboxController.controller = GetExtended.put<InboxController>(
      InboxController(
        controllerManager,
        Injector.locator<GetFaqListUseCase>()
      ),
      tag: pageName
    );
  }

  @override
  _InboxPageRestoration createPageRestoration() => _InboxPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _StatefulInboxControllerMediatorWidget(
        inboxController: _inboxController.controller,
      ),
    );
  }
}

class _InboxPageRestoration extends MixableGetxPageRestoration with InboxPageRestorationMixin, ProductDiscussionPageRestorationMixin, DeliveryReviewPageRestorationMixin, HelpPageRestorationMixin {
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

class InboxPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  @override
  GetPageBuilder get pageBuilder => (() => InboxPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(InboxPage()));
}

mixin InboxPageRestorationMixin on MixableGetxPageRestoration {
  late InboxPageRestorableRouteFuture inboxPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    inboxPageRestorableRouteFuture = InboxPageRestorableRouteFuture(restorationId: restorationIdWithPageName('inbox-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    inboxPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    inboxPageRestorableRouteFuture.dispose();
  }
}

class InboxPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  InboxPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(InboxPageGetPageBuilderAssistant())
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

class _StatefulInboxControllerMediatorWidget extends StatefulWidget {
  final InboxController inboxController;

  const _StatefulInboxControllerMediatorWidget({
    required this.inboxController
  });

  @override
  State<_StatefulInboxControllerMediatorWidget> createState() => _StatefulInboxControllerMediatorWidgetState();
}

class _StatefulInboxControllerMediatorWidgetState extends State<_StatefulInboxControllerMediatorWidget> {
  late final ScrollController _inboxScrollController;
  late final ModifiedPagingController<int, ListItemControllerState> _inboxListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _inboxListItemPagingControllerState;

  @override
  void initState() {
    super.initState();
    _inboxScrollController = ScrollController();
    _inboxListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.inboxController.apiRequestManager,
    );
    _inboxListItemPagingControllerState = PagingControllerState(
      pagingController: _inboxListItemPagingController,
      scrollController: _inboxScrollController,
      isPagingControllerExist: false
    );
    _inboxListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _inboxListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _inboxListItemPagingControllerState.isPagingControllerExist = true;
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _inboxListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? cartListItemControllerStateList) async {
    LoadDataResult<List<Faq>> faqPagingLoadDataResult = await widget.inboxController.getFaqList(FaqListParameter());
    Color iconColor = Colors.grey.shade500;
    Widget descriptionInterceptor(description, lastDescriptionTextStyle) => Text(description);
    return faqPagingLoadDataResult.map<PagingResult<ListItemControllerState>>((faqList) {
      return PagingDataResult<ListItemControllerState>(
        itemList: [
          ProfileMenuListItemControllerState(
            onTap: (context) => DialogHelper.showPromptUnderConstruction(context),
            icon: (BuildContext context) => ModifiedSvgPicture.asset(Constant.vectorChat, color: iconColor, width: 20.0),
            title: 'Chat'.tr,
            description: "Your private conversations".tr,
            descriptionInterceptor: descriptionInterceptor
          ),
          DividerListItemControllerState(),
          ProfileMenuListItemControllerState(
            onTap: (context) => PageRestorationHelper.toProductDiscussionPage(context),
            icon: (BuildContext context) => ModifiedSvgPicture.asset(Constant.vectorProductDiscussion2, color: iconColor, width: 20.0),
            title: 'Product Discussion'.tr,
            description: "Ask questions about the product".tr,
            descriptionInterceptor: descriptionInterceptor
          ),
          DividerListItemControllerState(),
          ProfileMenuListItemControllerState(
            onTap: (context) => PageRestorationHelper.toDeliveryReviewPage(context),
            icon: (BuildContext context) => ModifiedSvgPicture.asset(Constant.vectorDeliveryReview2, color: iconColor, width: 20.0),
            title: 'Delivery Review'.tr,
            description: "Please rate the shipping review".tr,
            descriptionInterceptor: descriptionInterceptor
          ),
          DividerListItemControllerState(),
          ProfileMenuListItemControllerState(
            onTap: (context) => PageRestorationHelper.toHelpPage(context),
            icon: (BuildContext context) => ModifiedSvgPicture.asset(Constant.vectorSupportMessage, color: iconColor, width: 20.0),
            title: 'Support Message'.tr,
            description: "Monitor the status of assistance from Master Bagasi".tr,
            descriptionInterceptor: descriptionInterceptor
          ),
          FaqContainerListItemControllerState(
            faqListItemValueList: faqList.map<FaqListItemValue>((faq) {
              return FaqListItemValue(
                faq: faq,
                isExpanded: false
              );
            }).toList(),
            onUpdateState: () => setState(() {})
          )
        ],
        page: 1,
        totalPage: 1,
        totalItem: 0
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModifiedAppBar(
        titleInterceptor: (context, title) => Row(
          children: [
            Text("Inbox".tr),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
                pagingControllerState: _inboxListItemPagingControllerState,
                onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
                  pagingControllerState: pagingControllerState!
                ),
                pullToRefresh: true
              ),
            ),
          ]
        )
      ),
    );
  }
}