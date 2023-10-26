import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../controller/web_viewer_controller.dart';
import '../../misc/constant.dart';
import '../../misc/error/message_error.dart';
import '../../misc/errorprovider/error_provider.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/parameter_link_helper.dart';
import '../../misc/parameterlink/parameter_link_input.dart';
import '../../misc/toast_helper.dart';
import '../widget/app_bar_icon_area.dart';
import '../widget/loaddataresultimplementer/load_data_result_implementer_directly.dart';
import '../widget/modified_svg_picture.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import '../widget/progress_indicator_bar.dart';
import 'getx_page.dart';

class WebViewerPage extends RestorableGetxPage<_WebViewerPageRestoration> {
  final String webViewerParameterLink;

  late final ControllerMember<WebViewerController> _webViewerController = ControllerMember<WebViewerController>().addToControllerManager(controllerManager);

  WebViewerPage({
    Key? key,
    required this.webViewerParameterLink
  }) : super(key: key, pageRestorationId: () => "web-viewer-page");

  @override
  void onSetController() {
    _webViewerController.controller = GetExtended.put<WebViewerController>(WebViewerController(controllerManager), tag: pageName);
  }

  @override
  _WebViewerPageRestoration createPageRestoration() => _WebViewerPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulWebViewerPage(webViewerParameterLink: webViewerParameterLink);
  }
}

class WebViewerPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  final String webViewerParameterLink;

  WebViewerPageGetPageBuilderAssistant({
    required this.webViewerParameterLink
  });

  @override
  GetPageBuilder get pageBuilder => (() => WebViewerPage(webViewerParameterLink: webViewerParameterLink));

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(WebViewerPage(webViewerParameterLink: webViewerParameterLink)));
}

class _WebViewerPageRestoration extends GetxPageRestoration  {
  @override
  void initState() {}

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {}

  @override
  void dispose() {}
}

mixin WebViewerPageRestorationMixin on MixableGetxPageRestoration {
  late WebViewerPageRestorableRouteFuture webViewerPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    webViewerPageRestorableRouteFuture = WebViewerPageRestorableRouteFuture(restorationId: restorationIdWithPageName('web-viewer-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    webViewerPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    webViewerPageRestorableRouteFuture.dispose();
  }
}

class WebViewerPageRestorableRouteFuture extends GetRestorableRouteFuture {
  final RouteCompletionCallback<bool?>? onComplete;

  late RestorableRouteFuture<bool?> _pageRoute;

  WebViewerPageRestorableRouteFuture({
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
    if (arguments is! String) {
      throw Exception("Arguments must be a string");
    }
    return GetExtended.toWithGetPageRouteReturnValue<bool?>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(WebViewerPageGetPageBuilderAssistant(webViewerParameterLink: arguments))
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

class _StatefulWebViewerPage extends StatefulWidget {
  final String webViewerParameterLink;

  const _StatefulWebViewerPage({
    required this.webViewerParameterLink
  });

  @override
  _StatefulWebViewerPageState createState() => _StatefulWebViewerPageState();
}

class _StatefulWebViewerPageState extends State<_StatefulWebViewerPage> {
  WebViewController? _webViewController;
  late ParameterLinkInput _webViewParameterLinkInput;
  late String _url = "";
  bool _isLoading = true;
  bool _canGoBack = false;
  bool _canGoForward = false;
  bool _canShare = false;
  int _progress = 0;
  FailedLoadDataResult<bool>? _webLoadingFailedLoadDataResult;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    _webViewParameterLinkInput = ParameterLinkHelper.toParameterLinkInput(widget.webViewerParameterLink);
    if (_webViewParameterLinkInput.otherParameter is Map<String, dynamic>) {
      Map<String, dynamic> otherParameterMap =  _webViewParameterLinkInput.otherParameter as Map<String, dynamic>;
      if (otherParameterMap.containsKey(Constant.textEncodedUrlKey)) {
        _url = utf8.decode(base64.decode(otherParameterMap[Constant.textEncodedUrlKey]));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModifiedAppBar(
        titleInterceptorWithAdditionalParameter: (context, title, titleInterceptorAdditionalParameter) {
          Size preferredSize = titleInterceptorAdditionalParameter.appBarPreferredSize;
          return Row(
            children: [
              Expanded(
                child: title ?? Container(),
              ),
              AppBarIconArea(
                onTap: () {
                  setState(() => _webLoadingFailedLoadDataResult = null);
                  _webViewController?.reload();
                },
                height: preferredSize.height,
                child: Icon(Icons.refresh, color: Theme.of(context).colorScheme.primary, size: 30)
              ),
              AppBarIconArea(
                onTap: _canGoBack ? () async {
                  if (_webViewController != null) {
                    if (await _webViewController!.canGoBack()) {
                      await _webViewController!.goBack();
                    }
                  }
                } : null,
                height: preferredSize.height,
                child: Icon(Icons.chevron_left, color: Theme.of(context).colorScheme.primary, size: 30)
              ),
              AppBarIconArea(
                onTap: _canGoForward ? () async {
                  if (_webViewController != null) {
                    if (await _webViewController!.canGoForward()) {
                      await _webViewController!.goForward();
                    }
                  }
                } : null,
                height: preferredSize.height,
                child: Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.primary, size: 30)
              ),
              AppBarIconArea(
                onTap: _canShare ? () => Share.share(_url) : null,
                height: preferredSize.height,
                child: ModifiedSvgPicture.asset(
                  Constant.vectorShare,
                  color: Theme.of(context).colorScheme.primary,
                  height: 30
                )
              )
            ],
          );
        },
      ),
      body: LoadDataResultImplementerDirectlyWithDefault<bool>(
        loadDataResult: _webLoadingFailedLoadDataResult ?? NoLoadDataResult<bool>(),
        errorProvider: Injector.locator<ErrorProvider>(),
        onImplementLoadDataResultDirectlyWithDefault: (loadDataResult, errorProvider, defaultLoadDataResultWidget) {
          if (loadDataResult is FailedLoadDataResult<bool>) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultLoadDataResultWidget.failedLoadDataResultWidget(context, loadDataResult, errorProvider)
                ]
              ),
            );
          }
          return Column(
            children: [
              if (_isLoading)
                ProgressIndicatorBar(
                  barColor: Theme.of(context).colorScheme.primary,
                  barBackgroundColor: Colors.grey.shade200,
                  barValue: _progress / 100,
                  height: 3.0,
                  barBackgroundRadius: Radius.zero,
                  barRadius: Radius.zero,
                ),
              Expanded(
                child: WebView(
                  gestureNavigationEnabled: true,
                  initialUrl: _url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _webViewController = webViewController;
                  },
                  onProgress: (int progress) async {
                    _progress = progress;
                    setState(() {});
                    if (_isLoading && _progress == 100) {
                      await _onPageFinishedLoading();
                    } else if (!_isLoading) {
                      _onPageStartedLoading();
                    }
                  },
                  javascriptChannels: <JavascriptChannel>{_toasterJavascriptChannel(context)},
                  navigationDelegate: (NavigationRequest request) {
                    return NavigationDecision.navigate;
                  },
                  onPageStarted: (String url) => _onPageStartedLoading(),
                  onPageFinished: (String url) async => await _onPageFinishedLoading(),
                  onWebResourceError: (onWebResourceError) {
                    setState(() {
                      _webLoadingFailedLoadDataResult = FailedLoadDataResult.throwException<bool>(
                        () => throw MessageError(
                          title: "Web Cannot Be Loaded".tr,
                          message: onWebResourceError.description
                        )
                      );
                    });
                  },
                ),
              )
            ]
          );
        },
      )
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        ToastHelper.showToast(message.message);
      }
    );
  }

  Future<void> _onPageFinishedLoading() async {
    await _checkCanGoBackAndForwardEnabled();
    setState(() => _isLoading = false);
    _webViewController?.scrollTo(0, 0);
  }

  void _onPageStartedLoading() {
    _resetCanGoBackAndForwardEnabled();
    setState(() => _isLoading = true);
  }

  void _resetCanGoBackAndForwardEnabled() {
    _canGoBack = false;
    _canGoForward = false;
    _canShare = false;
    _webLoadingFailedLoadDataResult = null;
    setState(() {});
  }

  Future<void> _checkCanGoBackAndForwardEnabled() async {
    if (_webViewController != null) {
      _canGoBack = await _webViewController!.canGoBack();
      _canGoForward = await _webViewController!.canGoForward();
      _canShare = true;
    }
    setState(() {});
  }
}