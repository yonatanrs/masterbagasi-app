import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/deliveryreviewcontroller/delivery_review_controller.dart';
import '../../../../misc/getextended/get_extended.dart';
import '../../../../misc/getextended/get_restorable_route_future.dart';
import '../../../../misc/manager/controller_manager.dart';
import '../../../controller/deliveryreviewcontroller/deliveryreviewsubpagecontroller/history_delivery_review_sub_controller.dart';
import '../../../controller/deliveryreviewcontroller/deliveryreviewsubpagecontroller/waiting_to_be_reviewed_delivery_review_sub_controller.dart';
import '../../../misc/injector.dart';
import '../../../misc/main_route_observer.dart';
import '../../../misc/refresh_delivery_review.dart';
import '../../widget/modified_tab_bar.dart';
import '../../widget/modifiedappbar/modified_app_bar.dart';
import '../getx_page.dart';
import 'deliveryreviewsubpage/history_delivery_review_sub_page.dart';
import 'deliveryreviewsubpage/waiting_to_be_reviewed_delivery_review_sub_page.dart';

class DeliveryReviewPage extends RestorableGetxPage<_DeliveryReviewPageRestoration> {
  late final ControllerMember<DeliveryReviewController> _deliveryReviewController = ControllerMember<DeliveryReviewController>().addToControllerManager(controllerManager);
  late final List<List<dynamic>> _deliveryReviewSubControllerList;

  DeliveryReviewPage({Key? key}) : super(key: key, pageRestorationId: () => "delivery-review-page") {
    _deliveryReviewSubControllerList = [
      [
        null,
        () => ControllerMember<WaitingToBeReviewedDeliveryReviewSubController>().addToControllerManager(controllerManager),
        null
      ],
      [
        null,
        () => ControllerMember<HistoryDeliveryReviewSubController>().addToControllerManager(controllerManager),
        null
      ],
    ];
    _deliveryReviewSubControllerList[0][2] = () {
      if (_deliveryReviewSubControllerList[0][0] == null) {
        _deliveryReviewSubControllerList[0][0] = _deliveryReviewSubControllerList[0][1]();
      }
      return _deliveryReviewSubControllerList[0][0];
    };
    _deliveryReviewSubControllerList[1][2] = () {
      if (_deliveryReviewSubControllerList[1][0] == null) {
        _deliveryReviewSubControllerList[1][0] = _deliveryReviewSubControllerList[1][1]();
      }
      return _deliveryReviewSubControllerList[1][0];
    };
  }

  @override
  void onSetController() {
    _deliveryReviewController.controller = GetExtended.put<DeliveryReviewController>(
      DeliveryReviewController(
        controllerManager,
      ),
      tag: pageName
    );
  }

  @override
  _DeliveryReviewPageRestoration createPageRestoration() => _DeliveryReviewPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulDeliveryReviewControllerMediatorWidget(
      deliveryReviewController: _deliveryReviewController.controller,
      deliveryReviewSubControllerList: _deliveryReviewSubControllerList,
      pageName: pageName
    );
  }
}

class _DeliveryReviewPageRestoration extends MixableGetxPageRestoration {
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

class DeliveryReviewPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  @override
  GetPageBuilder get pageBuilder => (() => DeliveryReviewPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(DeliveryReviewPage()));
}

mixin DeliveryReviewPageRestorationMixin on MixableGetxPageRestoration {
  late DeliveryReviewPageRestorableRouteFuture deliveryReviewPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    deliveryReviewPageRestorableRouteFuture = DeliveryReviewPageRestorableRouteFuture(restorationId: restorationIdWithPageName('delivery-review-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    deliveryReviewPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    deliveryReviewPageRestorableRouteFuture.dispose();
  }
}

class DeliveryReviewPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  DeliveryReviewPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(DeliveryReviewPageGetPageBuilderAssistant()),
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

class _StatefulDeliveryReviewControllerMediatorWidget extends StatefulWidget {
  final DeliveryReviewController deliveryReviewController;
  final List<List<dynamic>> deliveryReviewSubControllerList;
  final String pageName;

  const _StatefulDeliveryReviewControllerMediatorWidget({
    required this.deliveryReviewController,
    required this.deliveryReviewSubControllerList,
    required this.pageName
  });

  @override
  State<_StatefulDeliveryReviewControllerMediatorWidget> createState() => _StatefulDeliveryReviewControllerMediatorWidgetState();
}

class _StatefulDeliveryReviewControllerMediatorWidgetState extends State<_StatefulDeliveryReviewControllerMediatorWidget> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _tabControllerIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() => _tabControllerIndex = _tabController.index);
    });
    MainRouteObserver.onRefreshDeliveryReview = RefreshDeliveryReview();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModifiedAppBar(
        titleInterceptor: (context, title) => Row(
          children: [
            Text("Delivery Review".tr),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ModifiedTabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                  text: "Waiting To Be Reviewed".tr,
                ),
                Tab(
                  text: "History".tr
                )
              ],
            ),
            Expanded(
              child: IndexedStack(
                index: _tabControllerIndex,
                children: [
                  WaitingToBeReviewedDeliveryReviewSubPage(
                    ancestorPageName: widget.pageName,
                    onAddControllerMember: () => widget.deliveryReviewSubControllerList[0][2]() as ControllerMember<WaitingToBeReviewedDeliveryReviewSubController>,
                  ),
                  HistoryDeliveryReviewSubPage(
                    ancestorPageName: widget.pageName,
                    onAddControllerMember: () => widget.deliveryReviewSubControllerList[1][2]() as ControllerMember<HistoryDeliveryReviewSubController>,
                  )
                ],
              )
            )
          ]
        )
      ),
    );
  }

  @override
  void dispose() {
    MainRouteObserver.onRefreshDeliveryReview?.dispose();
    MainRouteObserver.onRefreshDeliveryReview = null;
    super.dispose();
  }
}