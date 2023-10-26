import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controller/introduction_controller.dart';
import '../../misc/constant.dart';
import '../../misc/controllerstate/page_view_controller_state.dart';
import '../../misc/customclipper/introduction_button_custom_clipper.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/page_restoration_helper.dart';
import '../../misc/pageviewchildrenbuilder/introduction_page_view_children_builder.dart';
import '../../misc/pageviewchildrenbuilder/page_view_children_builder.dart';
import 'package:preload_page_view/preload_page_view.dart';
import '../widget/preload_page_controller_smooth_page_indicator.dart';
import '../widget/rx_consumer.dart';
import 'getx_page.dart';
import 'login_page.dart';
import 'mainmenu/main_menu_page.dart';

class IntroductionPage extends RestorableGetxPage<_IntroductionPageRestoration> {
  late final ControllerMember<IntroductionController> _introductionController = ControllerMember<IntroductionController>().addToControllerManager(controllerManager);

  IntroductionPage({Key? key}) : super(key: key, pageRestorationId: () => "introduction-page", systemUiOverlayStyle: SystemUiOverlayStyle.light);

  @override
  void onSetController() {
    _introductionController.controller = GetExtended.put<IntroductionController>(IntroductionController(controllerManager), tag: pageName);
  }

  @override
  _IntroductionPageRestoration createPageRestoration() => _IntroductionPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: RxConsumer<PageViewControllerState>(
          rxValue: _introductionController.controller.introductionPageController,
          onConsumeValue: (context, value) => _IntroductionPageView(
            pageViewControllerState: value,
            onSkip: () => PageRestorationHelper.toMainMenuPage(context, Constant.restorableRouteFuturePushAndRemoveUntil),
          )
        ),
      )
    );
  }
}

class _IntroductionPageRestoration extends MixableGetxPageRestoration with MainMenuPageRestorationMixin {
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

class IntroductionPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  @override
  GetPageBuilder get pageBuilder => (() => IntroductionPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(IntroductionPage()));
}

class IntroductionPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  IntroductionPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        if (arguments is String) {
          if (arguments == Constant.restorableRouteFuturePushAndRemoveUntil) {
            return navigator.restorablePushAndRemoveUntil(_pageRouteBuilder, (route) => false, arguments: arguments);
          } else {
            return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
          }
        } else {
          return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
        }
      },
    );
  }

  static Route<void>? getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(IntroductionPageGetPageBuilderAssistant())
    );
  }

  @pragma('vm:entry-point')
  static Route<void> _pageRouteBuilder(BuildContext context, Object? arguments) {
    return getRoute(arguments)!;
  }

  @override
  bool checkBeforePresent([Object? arguments]) => getRoute(arguments) != null;

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

class _IntroductionPageView extends StatefulWidget {
  final PageViewControllerState pageViewControllerState;
  final VoidCallback? onSkip;

  const _IntroductionPageView({
    required this.pageViewControllerState,
    this.onSkip
  });

  @override
  _IntroductionPageViewState createState() => _IntroductionPageViewState();
}

class _IntroductionPageViewState extends State<_IntroductionPageView> {
  GlobalKey pageViewGlobalKey = GlobalKey();
  IntroductionPageViewChildrenBuilder? _introductionPageViewChildrenBuilder;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    PreloadPageViewChildrenBuilder pageViewChildrenBuilder = widget.pageViewControllerState.pageViewChildrenBuilder;
    if (pageViewChildrenBuilder is IntroductionPageViewChildrenBuilder) {
      _introductionPageViewChildrenBuilder = pageViewChildrenBuilder;
      _introductionPageViewChildrenBuilder?.initGlobalKey();
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      List<GlobalKey> pageViewContentGlobalKeyList = _introductionPageViewChildrenBuilder?.pageViewContentGlobalKeyList ?? [];
      double biggestPageViewContentHeight = -1;
      for (var pageViewContentGlobalKey in pageViewContentGlobalKeyList) {
        RenderBox? pageViewContentRenderBox = pageViewContentGlobalKey.currentContext?.findRenderObject() as RenderBox?;
        Size pageViewContentSize = pageViewContentRenderBox?.size ?? Size.zero;
        if (pageViewContentSize.height > biggestPageViewContentHeight) {
          biggestPageViewContentHeight = pageViewContentSize.height;
        }
      }
      RenderBox? pageViewRenderBox = pageViewGlobalKey.currentContext?.findRenderObject() as RenderBox?;
      Size pageViewSize = pageViewRenderBox?.size ?? Size.zero;
      double topMarginForPageViewContent = (pageViewSize.height - biggestPageViewContentHeight) / 2.0;
      if (_introductionPageViewChildrenBuilder?.topMarginForPageViewContent != topMarginForPageViewContent) {
        _introductionPageViewChildrenBuilder?.topMarginForPageViewContent = topMarginForPageViewContent;
        setState(() {});
      }
    });
    PageViewControllerState pageViewControllerState = widget.pageViewControllerState;
    List<Widget> pageViewWidgetList = pageViewControllerState.pageViewChildrenBuilder.buildPageViewChildrenDelegate()(context, pageViewControllerState.preloadPageController);
    bool checkIsLastIntroductionPageView() => _currentPage == pageViewWidgetList.length - 1;
    void onSkip() {
      if (widget.onSkip != null) {
        widget.onSkip!();
      }
    }
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Material(
              child: InkWell(
                onTap: onSkip,
                child: SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
                    child: Text(checkIsLastIntroductionPageView() ? "Finish".tr : "Skip".tr, style: const TextStyle(fontWeight: FontWeight.bold))
                  )
                ),
              ),
            ),
          ),
        ),
        Expanded(
          key: pageViewGlobalKey,
          child: PreloadPageView(
            preloadPagesCount: pageViewWidgetList.length,
            controller: pageViewControllerState.preloadPageController,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: pageViewWidgetList,
          )
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PreloadPageControllerSmoothPageIndicator(
                controller: pageViewControllerState.preloadPageController,
                count: pageViewWidgetList.length,
                effect: WormEffect(
                  dotColor: Colors.grey.shade400,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  dotHeight: 8.0,
                  dotWidth: 25.0,
                ),
              ),
            ],
          )
        )
      ],
    );
  }
}