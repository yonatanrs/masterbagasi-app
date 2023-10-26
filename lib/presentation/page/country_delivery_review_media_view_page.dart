import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

import '../../controller/country_delivery_review_media_view_controller.dart';
import '../../domain/entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media.dart';
import '../../domain/entity/delivery/countrydeliveryreviewmedia/other_country_delivery_review_media.dart';
import '../../domain/entity/delivery/countrydeliveryreviewmedia/photo_country_delivery_review_media.dart';
import '../../domain/entity/delivery/countrydeliveryreviewmedia/video_country_delivery_review_media.dart';
import '../../misc/error/message_error.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/string_util.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import 'getx_page.dart';

class CountryDeliveryReviewMediaViewPage extends RestorableGetxPage<_CountryDeliveryReviewMediaViewPageRestoration> {
  final CountryDeliveryReviewMediaViewPageParameter countryDeliveryReviewMediaViewPageParameter;

  late final ControllerMember<CountryDeliveryReviewMediaViewController> _countryDeliveryReviewMediaViewController = ControllerMember<CountryDeliveryReviewMediaViewController>().addToControllerManager(controllerManager);

  CountryDeliveryReviewMediaViewPage({
    Key? key,
    required this.countryDeliveryReviewMediaViewPageParameter
  }) : super(
    key: key,
    pageRestorationId: () => "country-delivery-review-media-view=-page"
  );

  @override
  void onSetController() {
    _countryDeliveryReviewMediaViewController.controller = GetExtended.put<CountryDeliveryReviewMediaViewController>(
      CountryDeliveryReviewMediaViewController(controllerManager),
      tag: pageName
    );
  }

  @override
  _CountryDeliveryReviewMediaViewPageRestoration createPageRestoration() => _CountryDeliveryReviewMediaViewPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulCountryDeliveryReviewMediaViewControllerMediatorWidget(
      countryDeliveryReviewMediaViewController: _countryDeliveryReviewMediaViewController.controller,
      countryDeliveryReviewMediaViewPageParameter: countryDeliveryReviewMediaViewPageParameter,
    );
  }
}

class _CountryDeliveryReviewMediaViewPageRestoration extends MixableGetxPageRestoration with CountryDeliveryReviewMediaViewPageRestorationMixin {
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

class CountryDeliveryReviewMediaViewPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  final CountryDeliveryReviewMediaViewPageParameter countryDeliveryReviewMediaViewPageParameter;

  CountryDeliveryReviewMediaViewPageGetPageBuilderAssistant({
    required this.countryDeliveryReviewMediaViewPageParameter
  });

  @override
  GetPageBuilder get pageBuilder => (() => CountryDeliveryReviewMediaViewPage(
    countryDeliveryReviewMediaViewPageParameter: countryDeliveryReviewMediaViewPageParameter
  ));

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(
    CountryDeliveryReviewMediaViewPage(
      countryDeliveryReviewMediaViewPageParameter: countryDeliveryReviewMediaViewPageParameter
    )
  ));
}

mixin CountryDeliveryReviewMediaViewPageRestorationMixin on MixableGetxPageRestoration {
  late CountryDeliveryReviewMediaViewPageRestorableRouteFuture countryDeliveryReviewMediaViewPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    countryDeliveryReviewMediaViewPageRestorableRouteFuture = CountryDeliveryReviewMediaViewPageRestorableRouteFuture(
      restorationId: restorationIdWithPageName('country-delivery-review-route')
    );
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    countryDeliveryReviewMediaViewPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    countryDeliveryReviewMediaViewPageRestorableRouteFuture.dispose();
  }
}

class CountryDeliveryReviewMediaViewPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  CountryDeliveryReviewMediaViewPageRestorableRouteFuture({
    required String restorationId
  }) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      }
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    if (arguments is! String) {
      throw MessageError(message: "Arguments must be a String");
    }
    CountryDeliveryReviewMediaViewPageParameter countryDeliveryReviewMediaViewPageParameter = arguments.toCountryDeliveryReviewMediaViewPageParameter();
    return GetExtended.toWithGetPageRouteReturnValue<String?>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(
        CountryDeliveryReviewMediaViewPageGetPageBuilderAssistant(
          countryDeliveryReviewMediaViewPageParameter: countryDeliveryReviewMediaViewPageParameter,
        )
      ),
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

class _StatefulCountryDeliveryReviewMediaViewControllerMediatorWidget extends StatefulWidget {
  final CountryDeliveryReviewMediaViewController countryDeliveryReviewMediaViewController;
  final CountryDeliveryReviewMediaViewPageParameter countryDeliveryReviewMediaViewPageParameter;

  const _StatefulCountryDeliveryReviewMediaViewControllerMediatorWidget({
    required this.countryDeliveryReviewMediaViewController,
    required this.countryDeliveryReviewMediaViewPageParameter
  });

  @override
  State<_StatefulCountryDeliveryReviewMediaViewControllerMediatorWidget> createState() => _StatefulCountryDeliveryReviewMediaViewControllerMediatorWidgetState();
}

class _StatefulCountryDeliveryReviewMediaViewControllerMediatorWidgetState extends State<_StatefulCountryDeliveryReviewMediaViewControllerMediatorWidget> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  CountryDeliveryReviewMedia get _countryDeliveryReviewMedia {
    return widget.countryDeliveryReviewMediaViewPageParameter.countryDeliveryReviewMedia;
  }

  @override
  void initState() {
    super.initState();
    if (_countryDeliveryReviewMedia is VideoCountryDeliveryReviewMedia) {
      _videoPlayerController = VideoPlayerController.network(_countryDeliveryReviewMedia.thumbnailUrl.toEmptyStringNonNull);
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModifiedAppBar(
        titleInterceptor: (context, title) => Container(),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Builder(
                builder: (context) {
                  if (_countryDeliveryReviewMedia is PhotoCountryDeliveryReviewMedia) {
                    return PhotoView(
                      imageProvider: CachedNetworkImageProvider(
                        widget.countryDeliveryReviewMediaViewPageParameter.countryDeliveryReviewMedia.thumbnailUrl.toEmptyStringNonNull
                      ),
                    );
                  } else if (_countryDeliveryReviewMedia is VideoCountryDeliveryReviewMedia) {
                    return Chewie(
                      controller: _chewieController!,
                    );
                  }
                  return Container();
                }
              )
            )
          ]
        )
      )
    );
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}

class CountryDeliveryReviewMediaViewPageParameter {
  CountryDeliveryReviewMedia countryDeliveryReviewMedia;

  CountryDeliveryReviewMediaViewPageParameter({
    required this.countryDeliveryReviewMedia
  });
}

extension CountryDeliveryReviewMediaViewPageParameterExt on CountryDeliveryReviewMediaViewPageParameter {
  String toEncodeBase64String() {
    CountryDeliveryReviewMedia countryDeliveryReviewMedia = this.countryDeliveryReviewMedia;
    String type = "other";
    if (countryDeliveryReviewMedia is PhotoCountryDeliveryReviewMedia) {
      type = "photo";
    } else if (countryDeliveryReviewMedia is VideoCountryDeliveryReviewMedia) {
      type = "video";
    }
    return StringUtil.encodeBase64StringFromJson(
      <String, dynamic>{
        "country_delivery_review_media_view_page_parameter": <String, dynamic>{
          "type": type,
          "id": countryDeliveryReviewMedia.id,
          "shipping_review_id": countryDeliveryReviewMedia.shippingReviewId,
          "thumbnail_url": countryDeliveryReviewMedia.thumbnailUrl
        }
      }
    );
  }
}

extension CountryDeliveryReviewMediaViewPageParameterStringExt on String {
  CountryDeliveryReviewMediaViewPageParameter toCountryDeliveryReviewMediaViewPageParameter() {
    dynamic result = StringUtil.decodeBase64StringToJson(this)["country_delivery_review_media_view_page_parameter"];
    String type = result["type"];
    String id = result["id"];
    String? shippingReviewId = result["shipping_review_id"];
    String? thumbnailUrl = result["thumbnail_url"];
    late CountryDeliveryReviewMedia countryDeliveryReviewMedia;
    if (type == "photo") {
      countryDeliveryReviewMedia = PhotoCountryDeliveryReviewMedia(
        id: id,
        shippingReviewId: shippingReviewId,
        thumbnailUrl: thumbnailUrl
      );
    } else if (type == "video") {
      countryDeliveryReviewMedia = VideoCountryDeliveryReviewMedia(
        id: id,
        shippingReviewId: shippingReviewId,
        thumbnailUrl: thumbnailUrl
      );
    } else {
      countryDeliveryReviewMedia = OtherCountryDeliveryReviewMedia(
        id: id,
        shippingReviewId: shippingReviewId,
        thumbnailUrl: thumbnailUrl
      );
    }
    return CountryDeliveryReviewMediaViewPageParameter(
      countryDeliveryReviewMedia: countryDeliveryReviewMedia
    );
  }
}