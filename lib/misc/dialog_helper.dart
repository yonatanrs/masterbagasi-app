import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masterbagasi/misc/ext/get_ext.dart';
import 'package:sizer/sizer.dart';

import '../controller/crop_picture_controller.dart';
import '../domain/entity/address/address.dart';
import '../presentation/page/getx_page.dart';
import '../presentation/page/modaldialogpage/add_host_cart_modal_dialog_page.dart';
import '../presentation/page/modaldialogpage/modal_dialog_page.dart';
import '../presentation/page/modaldialogpage/take_friend_cart_modal_dialog_page.dart';
import '../presentation/widget/button/custombutton/sized_outline_gradient_button.dart';
import '../presentation/widget/modified_divider.dart';
import '../presentation/widget/modified_loading_indicator.dart';
import '../presentation/widget/modified_svg_picture.dart';
import '../presentation/widget/modifiedappbar/modified_app_bar.dart';
import '../presentation/widget/profile_menu_item.dart';
import 'constant.dart';
import 'errorprovider/error_provider.dart';
import 'page_restoration_helper.dart';
import 'typedef.dart';
import 'widget_helper.dart';

typedef WidgetBuilderWithPromptCallback = Widget Function(BuildContext context, VoidCallbackWithBuildContextParameter? callback);

typedef ModalDialogPageBuilder<T extends ModalDialogPage, P> = T Function(
  BuildContext context,
  P? parameter
);

class _DialogHelperImpl {
  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            child: SizedBox(
              width: 100.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Loading..."),
                    SizedBox(
                      height: 12.0,
                    ),
                    ModifiedLoadingIndicator()
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void showPromptYesNoDialog({
    required BuildContext context,
    required WidgetBuilder prompt,
    WidgetBuilderWithPromptCallback? yesPromptButton,
    WidgetBuilderWithPromptCallback? noPromptButton,
    VoidCallbackWithBuildContextParameter? onYesPromptButtonTap,
    VoidCallbackWithBuildContextParameter? onNoPromptButtonTap,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: Dialog(
            insetPadding: const EdgeInsets.all(16.0),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    prompt(context),
                    const SizedBox(height: 12.0),
                    Builder(
                      builder: (BuildContext context) {
                        Widget buildDefaultYesPromptButtonWidget(Widget textWidget) {
                          return SizedBox(
                            child: TextButton(
                              onPressed: onYesPromptButtonTap != null ? () => onYesPromptButtonTap(context) : null,
                              child: textWidget,
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                foregroundColor: Colors.white,
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap
                              ),
                            )
                          );
                        }
                        Widget buildDefaultNoPromptButtonWidget(Widget textWidget) {
                          return SizedBox(
                            child: TextButton(
                              onPressed: onNoPromptButtonTap != null ? () => onNoPromptButtonTap(context) : null,
                              child: textWidget,
                              style:
                              TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5)
                                ),
                                foregroundColor: Theme.of(context).colorScheme.primary,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            )
                          );
                        }
                        Widget? yesPromptButtonWidget = yesPromptButton != null ? yesPromptButton(context, onYesPromptButtonTap) : null;
                        Widget? noPromptButtonWidget = noPromptButton != null ? noPromptButton(context, onNoPromptButtonTap) : null;
                        if (yesPromptButtonWidget is Text) {
                          yesPromptButtonWidget = buildDefaultYesPromptButtonWidget(yesPromptButtonWidget);
                        } else {
                          yesPromptButtonWidget = buildDefaultYesPromptButtonWidget(Text("Yes".tr));
                        }
                        if (noPromptButtonWidget is Text) {
                          noPromptButtonWidget = buildDefaultNoPromptButtonWidget(noPromptButtonWidget);
                        } else {
                          noPromptButtonWidget = buildDefaultNoPromptButtonWidget(Text("No".tr));
                        }
                        return Row(
                          children: [
                            Expanded(child: noPromptButtonWidget),
                            SizedBox(width: 2.w),
                            Expanded(child: yesPromptButtonWidget),
                          ]
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void showPromptOkDialog({
    required BuildContext context,
    required WidgetBuilder prompt,
    WidgetBuilderWithPromptCallback? okPromptButton,
    VoidCallbackWithBuildContextParameter? onOkPromptButtonTap,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: Dialog(
            insetPadding: const EdgeInsets.all(16.0),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    prompt(context),
                    const SizedBox(height: 12.0),
                    Builder(
                      builder: (BuildContext context) {
                        Widget buildDefaultYesPromptButtonWidget(Widget textWidget) {
                          return SizedBox(
                            child: TextButton(
                              onPressed: onOkPromptButtonTap != null ? () => onOkPromptButtonTap(context) : null,
                              child: textWidget,
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                foregroundColor: Colors.white,
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap
                              ),
                            )
                          );
                        }
                        Widget? yesPromptButtonWidget = okPromptButton != null ? okPromptButton(context, onOkPromptButtonTap) : null;
                        if (yesPromptButtonWidget is Text) {
                          yesPromptButtonWidget = buildDefaultYesPromptButtonWidget(yesPromptButtonWidget);
                        } else {
                          yesPromptButtonWidget = buildDefaultYesPromptButtonWidget(Text("OK".tr));
                        }
                        return Row(
                          children: [
                            Expanded(child: yesPromptButtonWidget),
                          ]
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void showSharedCartOptionsPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => true,
          child: Dialog(
            insetPadding: const EdgeInsets.all(16.0),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              ModifiedSvgPicture.asset(
                                height: 100,
                                Constant.vectorBag,
                                overrideDefaultColorWithSingleColor: false
                              ),
                              const SizedBox(height: 10),
                              SizedOutlineGradientButton(
                                onPressed: () async {
                                  dynamic result = await DialogHelper.showModalDialogPage<bool, String>(
                                    context: context,
                                    modalDialogPageBuilder: (context, parameter) => AddHostCartModalDialogPage(),
                                  );
                                  if (result != null) {
                                    if (result) {
                                      Navigator.of(context).pop();
                                    }
                                  }
                                },
                                text: "Be Host".tr,
                                outlineGradientButtonType: OutlineGradientButtonType.outline,
                                outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                              )
                            ]
                          )
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            children: [
                              ModifiedSvgPicture.asset(
                                height: 100,
                                Constant.vectorBagBlack,
                                overrideDefaultColorWithSingleColor: false
                              ),
                              const SizedBox(height: 10),
                              SizedOutlineGradientButton(
                                onPressed: () async {
                                  dynamic result = await DialogHelper.showModalDialogPage<bool, String>(
                                    context: context,
                                    modalDialogPageBuilder: (context, parameter) => TakeFriendCartModalDialogPage(),
                                  );
                                  if (result != null) {
                                    if (result) {
                                      Navigator.of(context).pop();
                                      PageRestorationHelper.toTakeFriendCartPage(context);
                                    }
                                  }
                                },
                                text: "Take Shopping".tr,
                                outlineGradientButtonType: OutlineGradientButtonType.solid,
                                outlineGradientButtonVariation: OutlineGradientButtonVariation.variation2,
                              )
                            ]
                          )
                        ),
                      ]
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void showPromptUnderConstruction(BuildContext context) {
    DialogHelper.showPromptOkDialog(
      context: context,
      prompt: (context) => Column(
        children: [
          Text("Feature Coming Soon".tr, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 4),
          Text("${"We apologize for the inconvenience caused".tr}.\r\n${"We're almost done".tr}.", textAlign: TextAlign.center),
          const SizedBox(height: 4),
        ]
      ),
      onOkPromptButtonTap: (_) async {
        Get.back();
      },
    );
  }

  void showSelectingImageDialog(BuildContext context, {dynamic parameter, double? cropAspectRatio, void Function(String)? onImageSelectedWithoutCropping, void Function()? onRemoveImage}) {
    showDialog(
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => true,
          child: Dialog(
            insetPadding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Text("Select Image With".tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ),
                ProfileMenuItem(
                  onTap: () async {
                    Get.back();
                    DialogHelper.showLoadingDialog(context);
                    ImagePicker imagePicker = ImagePicker();
                    XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      if (onImageSelectedWithoutCropping != null) {
                        onImageSelectedWithoutCropping(pickedImage.path);
                        Get.back();
                      } else {
                        CropPictureParameter cropPictureParameter = CropPictureParameter(
                          parameter: parameter,
                          picturePath: pickedImage.path,
                          cropAspectRatio: cropAspectRatio,
                        );
                        // ignore: use_build_context_synchronously
                        PageRestorationHelper.toCropPicturePage(context, cropPictureParameter);
                      }
                    } else {
                      Get.back();
                    }
                  },
                  icon: (BuildContext context) => const Icon(Icons.image),
                  title: 'Gallery'.tr,
                ),
                ProfileMenuItem(
                  onTap: () async {
                    Get.back();
                    DialogHelper.showLoadingDialog(context);
                    ImagePicker imagePicker = ImagePicker();
                    XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
                    if (pickedImage != null) {
                      if (onImageSelectedWithoutCropping != null) {
                        onImageSelectedWithoutCropping(pickedImage.path);
                        Get.back();
                      } else {
                        CropPictureParameter cropPictureParameter = CropPictureParameter(
                          parameter: parameter,
                          picturePath: pickedImage.path,
                          cropAspectRatio: cropAspectRatio,
                        );
                        // ignore: use_build_context_synchronously
                        PageRestorationHelper.toCropPicturePage(context, cropPictureParameter);
                      }
                    } else {
                      Get.back();
                    }
                  },
                  icon: (BuildContext context) => const Icon(Icons.camera),
                  title: 'Camera'.tr,
                ),
                if (onRemoveImage != null)
                  ProfileMenuItem(
                    onTap: () {
                      onRemoveImage();
                      Get.back();
                    },
                    icon: (BuildContext context) => const Icon(Icons.delete),
                    title: 'Remove Image'.tr,
                  )
              ],
            ),
          ),
        );
      }
    );
  }

  void showAddressOtherMenu({
    required BuildContext context,
    required Address address,
    required void Function(Address) onChangeAddress,
    required void Function(Address) onRemoveAddress
  }) {
    showModalBottomSheetPage(
      context: context,
      backgroundColor: Theme.of(context).canvasColor,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ModifiedAppBar(
            primary: false,
            title: Text("Other Choice".tr)
          ),
          SafeArea(
            top: false,
            child: Column(
              children: [
                ProfileMenuItem(
                  onTap: () async {
                    Get.back();
                    onChangeAddress(address);
                  },
                  title: 'Change Address'.tr,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
                  child: const ModifiedDivider()
                ),
                ProfileMenuItem(
                  onTap: () async {
                    Get.back();
                    DialogHelper.showPromptYesNoDialog(
                      context: context,
                      prompt: (context) => Column(
                        children: [
                          Text("Remove Address".tr, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 5),
                          Text("${"Are you sure remove address".tr}?"),
                          const SizedBox(height: 5),
                        ]
                      ),
                      onYesPromptButtonTap: (_) {
                        Get.back();
                        onRemoveAddress(address);
                      },
                      onNoPromptButtonTap: (context) => Get.back(),
                    );
                  },
                  title: 'Remove Address'.tr,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
                  child: const ModifiedDivider()
                ),
                SizedBox(height: Constant.paddingListItem)
              ]
            )
          )
        ]
      )
    );
  }

  Future<T?> showModalBottomSheetPage<T>({
    required BuildContext context,
    Color? backgroundColor = Colors.transparent,
    required WidgetBuilder builder,
    bool enableDrag = false
  }) async {
    return Get.bottomSheetOriginalMethod<T>(
      context,
      builder(context),
      ignoreSafeArea: false,
      isScrollControlled: true,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
    );
  }

  _showRawPromptModalBottomDialog({
    required BuildContext context,
    required WidgetBuilder builder
  }) {
    return showModalBottomSheetPage(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => Padding(
        padding: EdgeInsets.all(4.w),
        child: builder(context)
      )
    );
  }

  Future<T?> showModalBottomDialogPage<T, P>({
    required BuildContext context,
    required ModalDialogPageBuilder<dynamic, P> modalDialogPageBuilder,
    P? parameter,
    bool enableDrag = false
  }) async {
    dynamic result = await showModalBottomSheetPage(
      context: context,
      backgroundColor: Theme.of(context).canvasColor,
      builder: (context) => GetxPageBuilder.buildDefaultGetxPage(modalDialogPageBuilder(context, parameter)),
      enableDrag: enableDrag
    );
    return result is T ? result : null;
  }

  Future<T?> showDialogPage<T>({
    required BuildContext context,
    Color? backgroundColor = Colors.transparent,
    required WidgetBuilder builder,
    bool enableDrag = false
  }) async {
    return Get.dialogOriginalMethod<T>(
      context,
      builder(context),
    );
  }

  Future<T?> showModalDialogPage<T, P>({
    required BuildContext context,
    required ModalDialogPageBuilder<dynamic, P> modalDialogPageBuilder,
    P? parameter,
    bool enableDrag = false
  }) async {
    dynamic result = await showDialogPage(
      context: context,
      backgroundColor: Theme.of(context).canvasColor,
      builder: (context) => GetxPageBuilder.buildDefaultGetxPage(modalDialogPageBuilder(context, parameter)),
      enableDrag: enableDrag
    );
    return result is T ? result : null;
  }

  showFailedModalBottomDialog({
    required BuildContext context,
    String? buttonText,
    Image? image,
    String? promptTitleText = "Success",
    String? promptText = "This process has been success...",
    void Function()? onPressed
  }) {
    return _showRawPromptModalBottomDialog(
      context: context,
      builder: (context) => WidgetHelper.buildFailedPromptIndicator(
        context: context,
        image: image,
        promptText: promptText,
        buttonText: buttonText,
        onPressed: onPressed ?? () => Get.back(result: true)
      )
    );
  }

  showFailedModalBottomDialogFromErrorProvider({
    required BuildContext context,
    required ErrorProvider errorProvider,
    required dynamic e,
    String? buttonText,
    void Function()? onPressed
  }) {
    return _showRawPromptModalBottomDialog(
      context: context,
      builder: (context) => WidgetHelper.buildFailedPromptIndicatorFromErrorProvider(
        context: context,
        errorProvider: errorProvider,
        e: e,
        buttonText: buttonText,
        onPressed: onPressed ?? () => Get.back(result: true)
      )
    );
  }

  Future<FilePickerResult?> showChooseFileOrTakePhoto({bool allowMultipleSelectFiles = false}) async {
    return await FilePicker.platform.pickFiles(
      allowMultiple: allowMultipleSelectFiles
    );
  }
}

// ignore: non_constant_identifier_names
final _DialogHelperImpl DialogHelper = _DialogHelperImpl();