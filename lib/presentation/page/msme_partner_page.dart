import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../controller/msme_partner_controller.dart';
import '../../misc/constant.dart';
import '../../misc/dialog_helper.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/multi_language_string.dart';
import '../../misc/page_restoration_helper.dart';
import '../../misc/string_util.dart';
import '../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import '../widget/tap_area.dart';
import 'getx_page.dart';

class MsmePartnerPage extends RestorableGetxPage<_MsmePartnerPageRestoration> {
  late final ControllerMember<MsmePartnerController> _msmePartnerController = ControllerMember<MsmePartnerController>().addToControllerManager(controllerManager);

  MsmePartnerPage({
    Key? key
  }) : super(key: key, pageRestorationId: () => "msme-partner-page");

  @override
  void onSetController() {
    _msmePartnerController.controller = GetExtended.put<MsmePartnerController>(
      MsmePartnerController(
        controllerManager,
      ), tag: pageName
    );
  }

  @override
  _MsmePartnerPageRestoration createPageRestoration() => _MsmePartnerPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulMsmePartnerControllerMediatorWidget(
      msmePartnerController: _msmePartnerController.controller
    );
  }
}

class _MsmePartnerPageRestoration extends MixableGetxPageRestoration {
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

class MsmePartnerPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  MsmePartnerPageGetPageBuilderAssistant();

  @override
  GetPageBuilder get pageBuilder => (() => MsmePartnerPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(MsmePartnerPage()));
}

mixin MsmePartnerPageRestorationMixin on MixableGetxPageRestoration {
  late MsmePartnerPageRestorableRouteFuture msmePartnerPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    msmePartnerPageRestorableRouteFuture = MsmePartnerPageRestorableRouteFuture(
      restorationId: restorationIdWithPageName('msme-partner-route')
    );
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    msmePartnerPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    msmePartnerPageRestorableRouteFuture.dispose();
  }
}

class MsmePartnerPageRestorableRouteFuture extends GetRestorableRouteFuture {
  final RouteCompletionCallback<bool?>? onComplete;

  late RestorableRouteFuture<bool?> _pageRoute;

  MsmePartnerPageRestorableRouteFuture({
    required String restorationId,
    this.onComplete
  }) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<bool?>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
      onComplete: onComplete
    );
  }

  static Route<bool?>? _getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<bool?>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(
        MsmePartnerPageGetPageBuilderAssistant()
      ),
    );
  }

  @pragma('vm:entry-point')
  static Route<bool?> _pageRouteBuilder(BuildContext context, Object? arguments) {
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

class _StatefulMsmePartnerControllerMediatorWidget extends StatefulWidget {
  final MsmePartnerController msmePartnerController;

  const _StatefulMsmePartnerControllerMediatorWidget({
    required this.msmePartnerController,
  });

  @override
  State<_StatefulMsmePartnerControllerMediatorWidget> createState() => _StatefulMsmePartnerControllerMediatorWidgetState();
}

class _StatefulMsmePartnerControllerMediatorWidgetState extends State<_StatefulMsmePartnerControllerMediatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModifiedAppBar(
        titleInterceptor: (context, title) => Row(
          children: [
            Text("MSME Partner".tr),
            Expanded(
              child: title ?? Container()
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 30.h,
                      child: FittedBox(
                        child: Image.asset(Constant.imageMsmePartner),
                      )
                    ),
                    const SizedBox(height: 50),
                    Text(
                      MultiLanguageString({
                        Constant.textEnUsLanguageKey: "Create Your Opportunity!",
                        Constant.textInIdLanguageKey: "Ciptakan Peluangmu!"
                      }).toEmptyStringNonNull,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    const SizedBox(height: 10),
                    Text(
                      MultiLanguageString({
                        Constant.textEnUsLanguageKey: "Reach 27 million buyers from various countries around the world free of charge and get experience managing a business as easy as updating status.",
                        Constant.textInIdLanguageKey: "Raih 27 juta pembeli dari berbagai Negara di belahan dunia tanpa biaya dan dapatkan pengalaman mengelola usaha semudah update status."
                      }).toEmptyStringNonNull,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedOutlineGradientButton(
                        onPressed: () => DialogHelper.showPromptUnderConstruction(context),
                        text: "Become Master Bagasi Partner".tr,
                        outlineGradientButtonType: OutlineGradientButtonType.solid,
                        outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                      ),
                    ),
                  ]
                )
              )
            ),
          ]
        )
      )
    );
  }
}