import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/controller/help_controller.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/misc/getextended/get_extended.dart';
import 'package:masterbagasi/misc/getextended/get_restorable_route_future.dart';
import 'package:masterbagasi/misc/manager/controller_manager.dart';
import 'package:masterbagasi/misc/page_restoration_helper.dart';
import 'package:masterbagasi/presentation/widget/tap_area.dart';
import 'package:sizer/sizer.dart';

import '../../misc/constant.dart';
import '../../misc/dialog_helper.dart';
import '../../misc/multi_language_string.dart';
import '../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../widget/modified_svg_picture.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import 'getx_page.dart';
import 'help_chat_page.dart';

class HelpPage extends RestorableGetxPage<_HelpPageRestoration> {
  late final ControllerMember<HelpController> _helpController = ControllerMember<HelpController>().addToControllerManager(controllerManager);

  HelpPage({Key? key}) : super(key: key, pageRestorationId: () => "help-page");

  @override
  void onSetController() {
    _helpController.controller = GetExtended.put<HelpController>(
      HelpController(
        controllerManager
      ),
      tag: pageName
    );
  }

  @override
  _HelpPageRestoration createPageRestoration() => _HelpPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _StatefulHelpControllerMediatorWidget(
        helpController: _helpController.controller,
      ),
    );
  }
}

class _HelpPageRestoration extends MixableGetxPageRestoration with HelpChatPageRestorationMixin {
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

class HelpPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  @override
  GetPageBuilder get pageBuilder => (() => HelpPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(HelpPage()));
}

mixin HelpPageRestorationMixin on MixableGetxPageRestoration {
  late HelpPageRestorableRouteFuture helpPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    helpPageRestorableRouteFuture = HelpPageRestorableRouteFuture(restorationId: restorationIdWithPageName('help-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    helpPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    helpPageRestorableRouteFuture.dispose();
  }
}

class HelpPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  HelpPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(HelpPageGetPageBuilderAssistant())
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

class _StatefulHelpControllerMediatorWidget extends StatefulWidget {
  final HelpController helpController;

  const _StatefulHelpControllerMediatorWidget({
    required this.helpController
  });

  @override
  State<_StatefulHelpControllerMediatorWidget> createState() => _StatefulHelpControllerMediatorWidgetState();
}

class _StatefulHelpControllerMediatorWidgetState extends State<_StatefulHelpControllerMediatorWidget> {
  late final ScrollController _helpScrollController;

  @override
  void initState() {
    super.initState();
    _helpScrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModifiedAppBar(
        titleInterceptor: (context, title) => Row(
          children: [
            Text("Pesan Bantuan".tr),
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
                        child: Image.asset(Constant.imageHelpMessage),
                      )
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: SizedOutlineGradientButton(
                        onPressed: () => DialogHelper.showPromptUnderConstruction(context),
                        text: "Ke Masterbagasi Care".tr,
                        outlineGradientButtonType: OutlineGradientButtonType.solid,
                        outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                      ),
                    ),
                  ]
                )
              ),
            )
          ]
        )
      ),
      floatingActionButton: TapArea(
        onTap: () => PageRestorationHelper.toHelpChatPage(context),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
              ),
              ClipOval(
                child: ModifiedSvgPicture.asset(
                  Constant.vectorDirectChat,
                  overrideDefaultColorWithSingleColor: false
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}