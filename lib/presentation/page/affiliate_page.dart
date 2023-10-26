import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../controller/affiliate_controller.dart';
import '../../domain/entity/user/user.dart';
import '../../domain/usecase/get_user_use_case.dart';
import '../../misc/constant.dart';
import '../../misc/dialog_helper.dart';
import '../../misc/errorprovider/error_provider.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/multi_language_string.dart';
import '../../misc/page_restoration_helper.dart';
import '../../misc/string_util.dart';
import '../widget/affiliate_user_candidate_indicator.dart';
import '../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import '../widget/rx_consumer.dart';
import '../widget/tap_area.dart';
import 'getx_page.dart';

class AffiliatePage extends RestorableGetxPage<_AffiliatePageRestoration> {
  late final ControllerMember<AffiliateController> _affiliateController = ControllerMember<AffiliateController>().addToControllerManager(controllerManager);

  AffiliatePage({
    Key? key
  }) : super(key: key, pageRestorationId: () => "affiliate-page");

  @override
  void onSetController() {
    _affiliateController.controller = GetExtended.put<AffiliateController>(
      AffiliateController(
        controllerManager,
        Injector.locator<GetUserUseCase>()
      ), tag: pageName
    );
  }

  @override
  _AffiliatePageRestoration createPageRestoration() => _AffiliatePageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulAffiliateControllerMediatorWidget(
      affiliateController: _affiliateController.controller
    );
  }
}

class _AffiliatePageRestoration extends MixableGetxPageRestoration {
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

class AffiliatePageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  AffiliatePageGetPageBuilderAssistant();

  @override
  GetPageBuilder get pageBuilder => (() => AffiliatePage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(AffiliatePage()));
}

mixin AffiliatePageRestorationMixin on MixableGetxPageRestoration {
  late AffiliatePageRestorableRouteFuture affiliatePageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    affiliatePageRestorableRouteFuture = AffiliatePageRestorableRouteFuture(
      restorationId: restorationIdWithPageName('affiliate-route')
    );
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    affiliatePageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    affiliatePageRestorableRouteFuture.dispose();
  }
}

class AffiliatePageRestorableRouteFuture extends GetRestorableRouteFuture {
  final RouteCompletionCallback<bool?>? onComplete;

  late RestorableRouteFuture<bool?> _pageRoute;

  AffiliatePageRestorableRouteFuture({
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
        AffiliatePageGetPageBuilderAssistant()
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

class _StatefulAffiliateControllerMediatorWidget extends StatefulWidget {
  final AffiliateController affiliateController;

  const _StatefulAffiliateControllerMediatorWidget({
    required this.affiliateController,
  });

  @override
  State<_StatefulAffiliateControllerMediatorWidget> createState() => _StatefulAffiliateControllerMediatorWidgetState();
}

class _StatefulAffiliateControllerMediatorWidgetState extends State<_StatefulAffiliateControllerMediatorWidget> {
  @override
  Widget build(BuildContext context) {
    widget.affiliateController.setAffiliateDelegate(
      AffiliateDelegate()
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.affiliateController.loadLoggedUser();
    });
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        return false;
      },
      child: Scaffold(
        appBar: ModifiedAppBar(
          titleInterceptor: (context, title) => Row(
            children: [
              Text("Affiliate".tr),
              Expanded(
                child: title ?? Container()
              ),
              TapArea(
                onTap: () {
                  PageRestorationHelper.toWebViewerPage(
                    context, <String, dynamic>{
                      Constant.textEncodedUrlKey: StringUtil.encodeBase64String("https://masterbagasi.com/affiliate")
                    }
                  );
                },
                child: DefaultTextStyle(
                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  child: Text("Learn".tr),
                )
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
                          child: Image.asset(Constant.imageAffiliate),
                        )
                      ),
                      const SizedBox(height: 50),
                      Text(
                        MultiLanguageString({
                          Constant.textEnUsLanguageKey: "Commissions of up to millions with\r\na click & share",
                          Constant.textInIdLanguageKey: "Komisi hingga jutaan cuma dengan\r\nklik & share"
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
                          Constant.textEnUsLanguageKey: "Promote Master Baggage products on your social media, and get\r\nMBpay coins that you can spend here.",
                          Constant.textInIdLanguageKey: "Promosikan produk Master Bagasi di sosmed kamu, dan dapatkan\r\nMBpay koin yang bisa kamu belanjakan di sini."
                        }).toEmptyStringNonNull,
                        textAlign: TextAlign.center,
                      ),
                    ]
                  )
                )
              ),
              Column(
                children: [
                  Text(
                    MultiLanguageString({
                      Constant.textEnUsLanguageKey: "Register This Account:",
                      Constant.textInIdLanguageKey: "Daftarkan Akun Ini:"
                    }).toEmptyStringNonNull,
                    style: const TextStyle(
                      fontSize: 12
                    ),
                  ),
                  const SizedBox(height: 10),
                  RxConsumer<LoadDataResultWrapper<User>>(
                    rxValue: widget.affiliateController.userLoadDataResultWrapperRx,
                    onConsumeValue: (context, userLoadDataResultWrapper) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: AffiliateUserCandidateIndicator(
                          userLoadDataResult: userLoadDataResultWrapper.loadDataResult,
                          errorProvider: Injector.locator<ErrorProvider>(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedOutlineGradientButton(
                      onPressed: () => DialogHelper.showPromptUnderConstruction(context),
                      text: "Register Now".tr,
                      outlineGradientButtonType: OutlineGradientButtonType.solid,
                      outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                    ),
                  ),
                  const SizedBox(height: 16.0)
                ]
              ),
            ]
          )
        )
      ),
    );
  }
}