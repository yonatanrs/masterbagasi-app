import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image/image.dart' as img;
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';

import '../../controller/crop_picture_controller.dart';
import '../../misc/constant.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/string_util.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import 'getx_page.dart';

class CropPicturePage extends RestorableGetxPage<_CropPicturePageRestoration> {
  late final ControllerMember<CropPictureController> _cropPictureController = ControllerMember<CropPictureController>().addToControllerManager(controllerManager);

  final String cropPictureSerializedJsonParameter;

  CropPicturePage({
    Key? key,
    required this.cropPictureSerializedJsonParameter
  }) : super(key: key, pageRestorationId: () => "crop-picture-page");

  @override
  void onSetController() {
    _cropPictureController.controller = GetExtended.put<CropPictureController>(CropPictureController(controllerManager), tag: pageName);
  }

  @override
  _CropPicturePageRestoration createPageRestoration() => _CropPicturePageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    CropPictureParameter cropPictureParameter = cropPictureSerializedJsonParameter.toCropPictureParameter();
    _StatefulCropPictureDelegate statefulCropPictureDelegate = _StatefulCropPictureDelegate();
    statefulCropPictureDelegate._onAfterCropPicture = (imagePath) => Get.back(
      result: CropPictureResponse(
        imagePath: imagePath,
        parameter: cropPictureParameter.parameter,
      ).toEncodeBase64String()
    );
    return Scaffold(
      appBar: ModifiedAppBar(
        title: Text("Crop Profile".tr),
        titleInterceptor: (context, title) => Row(
          children: [
            Expanded(
              child: title ?? Container()
            ),
            GestureDetector(
              onTap: () {
                if (statefulCropPictureDelegate._onCropPicture != null) {
                  statefulCropPictureDelegate._onCropPicture!();
                }
              },
              child: const Icon(Icons.check)
            )
          ],
        ),
      ),
      body: _StatefulCropPicturePage(
        imagePath: cropPictureParameter.picturePath,
        cropAspectRatio: cropPictureParameter.cropAspectRatio,
        statefulCropPictureDelegate: statefulCropPictureDelegate
      )
    );
  }
}

class _CropPicturePageRestoration extends GetxPageRestoration {
  @override
  void initState() {

  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {

  }

  @override
  void dispose() {

  }
}

class CropPicturePageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  final String cropPictureSerializedJsonParameter;

  CropPicturePageGetPageBuilderAssistant({
    required this.cropPictureSerializedJsonParameter
  });

  @override
  GetPageBuilder get pageBuilder => (() => CropPicturePage(cropPictureSerializedJsonParameter: cropPictureSerializedJsonParameter));

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(CropPicturePage(cropPictureSerializedJsonParameter: cropPictureSerializedJsonParameter)));
}

mixin CropPicturePageRestorationMixin on MixableGetxPageRestoration {
  RouteCompletionCallback<String?>? onCompleteSetProfilePicture;

  late CropPicturePageRestorableRouteFuture cropPicturePageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    cropPicturePageRestorableRouteFuture = CropPicturePageRestorableRouteFuture(
      restorationId: restorationIdWithPageName('crop-picture-route'),
      onComplete: onCompleteSetProfilePicture
    );
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    cropPicturePageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    cropPicturePageRestorableRouteFuture.dispose();
  }
}

class CropPicturePageRestorableRouteFuture extends GetRestorableRouteFuture {
  final RouteCompletionCallback<String?>? onComplete;

  late RestorableRouteFuture<String?> _pageRoute;

  CropPicturePageRestorableRouteFuture({
    required String restorationId,
    this.onComplete
  }) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<String?>(
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
      onComplete: onComplete
    );
  }

  static Route<String?>? _getRoute([Object? arguments]) {
    if (arguments is! String) {
      throw Exception("Arguments must be a string");
    }
    return GetExtended.toWithGetPageRouteReturnValue<String?>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(
        CropPicturePageGetPageBuilderAssistant(cropPictureSerializedJsonParameter: arguments)
      )
    );
  }

  @pragma('vm:entry-point')
  static Route<String?> _pageRouteBuilder(BuildContext context, Object? arguments) {
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

class _StatefulCropPictureDelegate {
  VoidCallback? _onCropPicture;
  void Function(String)? _onAfterCropPicture;

  _StatefulCropPictureDelegate({
    VoidCallback? onCropPicture,
    void Function(String)? onAfterCropPicture
  }) : _onCropPicture = onCropPicture, _onAfterCropPicture = onAfterCropPicture;
}

class _StatefulCropPicturePage extends StatefulWidget {
  final String imagePath;
  final double? cropAspectRatio;
  final _StatefulCropPictureDelegate statefulCropPictureDelegate;

  const _StatefulCropPicturePage({
    required this.imagePath,
    required this.cropAspectRatio,
    required this.statefulCropPictureDelegate
  });

  @override
  State<_StatefulCropPicturePage> createState() => _StatefulCropPicturePageState();
}

class _StatefulCropPicturePageState extends State<_StatefulCropPicturePage> {
  final GlobalKey<CropState> _cropStateKey = GlobalKey<CropState>();
  late File _imageFile;

  @override
  void initState() {
    super.initState();
    _imageFile = File(widget.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    widget.statefulCropPictureDelegate._onCropPicture = _cropImage;
    return Stack(
      children: [
        Container(color: Colors.black),
        Crop.file(
          _imageFile,
          key: _cropStateKey,
          aspectRatio: widget.cropAspectRatio ?? 1.0,
          alwaysShowGrid: true,
        )
      ]
    );
  }

  void _cropImage() async {
    double scale = _cropStateKey.currentState?.scale ?? 1.0;
    Rect? area = _cropStateKey.currentState?.area;
    if (area == null) {
      return;
    }
    final sample = await ImageCrop.sampleImage(
      file: _imageFile,
      preferredSize: (500 / scale).round(),
    );
    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );
    int finalResizedWidth = 0;
    int finalResizedHeight = 0;
    Size finalSize = ImageSizeGetter.getSize(FileInput(file));
    if (finalSize.width < 128 || finalSize.height < 128) {
      finalResizedWidth = 128;
      finalResizedHeight = 128;
    } else if (finalSize.width > 256 || finalSize.height > 256) {
      finalResizedWidth = 256;
      finalResizedHeight = 256;
    } else if (finalSize.width != finalSize.height) {
      if (finalSize.width > finalSize.height) {
        finalResizedWidth = finalSize.width;
        finalResizedHeight = finalSize.width;
      } else {
        finalResizedWidth = finalSize.height;
        finalResizedHeight = finalSize.height;
      }
    } else {
      finalResizedWidth = finalSize.width;
      finalResizedHeight = finalSize.height;
    }
    final cmd = img.Command()
      ..decodeImageFile(file.path)
      ..copyResize(width: finalResizedWidth, height: finalResizedHeight)
      ..writeToFile(file.path);
    await cmd.executeThread();
    if (widget.statefulCropPictureDelegate._onAfterCropPicture != null) {
      widget.statefulCropPictureDelegate._onAfterCropPicture!(file.path);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageFile.delete();
  }
}