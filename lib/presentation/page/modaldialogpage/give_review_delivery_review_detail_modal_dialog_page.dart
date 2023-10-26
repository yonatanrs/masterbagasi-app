import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/deliveryreviewcontroller/givedeliveryreviewcontainercontroller/five_rating_give_delivery_review_container_controller.dart';
import '../../../controller/deliveryreviewcontroller/givedeliveryreviewcontainercontroller/four_rating_give_delivery_review_container_controller.dart';
import '../../../controller/deliveryreviewcontroller/givedeliveryreviewcontainercontroller/one_rating_give_delivery_review_container_controller.dart';
import '../../../controller/deliveryreviewcontroller/givedeliveryreviewcontainercontroller/three_rating_give_delivery_review_container_controller.dart';
import '../../../controller/deliveryreviewcontroller/givedeliveryreviewcontainercontroller/two_rating_give_delivery_review_container_controller.dart';
import '../../../controller/modaldialogcontroller/give_review_delivery_review_detail_modal_dialog_controller.dart';
import '../../../domain/entity/delivery/delivery_review.dart';
import '../../../domain/entity/delivery/givedeliveryreviewvalue/give_delivery_review_value.dart';
import '../../../domain/usecase/give_review_delivery_review_detail_use_case.dart';
import '../../../misc/dialog_helper.dart';
import '../../../misc/errorprovider/error_provider.dart';
import '../../../misc/injector.dart';
import '../../../misc/manager/controller_manager.dart';
import '../../../misc/toast_helper.dart';
import '../../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../../widget/deliveryreview/givedeliveryreviewcontainer/five_rating_give_delivery_review_container.dart';
import '../../widget/deliveryreview/givedeliveryreviewcontainer/four_rating_give_delivery_review_container.dart';
import '../../widget/deliveryreview/givedeliveryreviewcontainer/one_rating_give_delivery_review_container.dart';
import '../../widget/deliveryreview/givedeliveryreviewcontainer/three_rating_give_delivery_review_container.dart';
import '../../widget/deliveryreview/givedeliveryreviewcontainer/two_rating_give_delivery_review_container.dart';
import '../../widget/modifiedcachednetworkimage/product_modified_cached_network_image.dart';
import '../../widget/rating_indicator.dart';
import 'modal_dialog_page.dart';

class GiveReviewDeliveryReviewDetailModalDialogPage extends ModalDialogPage<GiveReviewDeliveryReviewDetailModalDialogController> {
  GiveReviewDeliveryReviewDetailModalDialogController get giveReviewDeliveryReviewDetailModalDialogController => modalDialogController.controller;

  late final List<List<dynamic>> _giveReviewDeliveryReviewSubControllerList;

  final int selectedRating;
  final DeliveryReview deliveryReview;

  GiveReviewDeliveryReviewDetailModalDialogPage({
    super.key,
    required this.selectedRating,
    required this.deliveryReview
  }) {
    _giveReviewDeliveryReviewSubControllerList = [
      [
        null,
        () => ControllerMember<OneRatingGiveDeliveryReviewContainerController>().addToControllerManager(controllerManager),
        null
      ],
      [
        null,
        () => ControllerMember<TwoRatingGiveDeliveryReviewContainerController>().addToControllerManager(controllerManager),
        null
      ],
      [
        null,
        () => ControllerMember<ThreeRatingGiveDeliveryReviewContainerController>().addToControllerManager(controllerManager),
        null
      ],
      [
        null,
        () => ControllerMember<FourRatingGiveDeliveryReviewContainerController>().addToControllerManager(controllerManager),
        null
      ],
      [
        null,
        () => ControllerMember<FiveRatingGiveDeliveryReviewContainerController>().addToControllerManager(controllerManager),
        null
      ]
    ];
    _giveReviewDeliveryReviewSubControllerList[0][2] = () {
      if (_giveReviewDeliveryReviewSubControllerList[0][0] == null) {
        _giveReviewDeliveryReviewSubControllerList[0][0] = _giveReviewDeliveryReviewSubControllerList[0][1]();
      }
      return _giveReviewDeliveryReviewSubControllerList[0][0];
    };
    _giveReviewDeliveryReviewSubControllerList[1][2] = () {
      if (_giveReviewDeliveryReviewSubControllerList[1][0] == null) {
        _giveReviewDeliveryReviewSubControllerList[1][0] = _giveReviewDeliveryReviewSubControllerList[1][1]();
      }
      return _giveReviewDeliveryReviewSubControllerList[1][0];
    };
    _giveReviewDeliveryReviewSubControllerList[2][2] = () {
      if (_giveReviewDeliveryReviewSubControllerList[2][0] == null) {
        _giveReviewDeliveryReviewSubControllerList[2][0] = _giveReviewDeliveryReviewSubControllerList[2][1]();
      }
      return _giveReviewDeliveryReviewSubControllerList[2][0];
    };
    _giveReviewDeliveryReviewSubControllerList[3][2] = () {
      if (_giveReviewDeliveryReviewSubControllerList[3][0] == null) {
        _giveReviewDeliveryReviewSubControllerList[3][0] = _giveReviewDeliveryReviewSubControllerList[3][1]();
      }
      return _giveReviewDeliveryReviewSubControllerList[3][0];
    };
    _giveReviewDeliveryReviewSubControllerList[4][2] = () {
      if (_giveReviewDeliveryReviewSubControllerList[4][0] == null) {
        _giveReviewDeliveryReviewSubControllerList[4][0] = _giveReviewDeliveryReviewSubControllerList[4][1]();
      }
      return _giveReviewDeliveryReviewSubControllerList[4][0];
    };
  }

  @override
  GiveReviewDeliveryReviewDetailModalDialogController onCreateModalDialogController() {
    return GiveReviewDeliveryReviewDetailModalDialogController(
      controllerManager,
      Injector.locator<GiveReviewDeliveryReviewDetailUseCase>()
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulGiveReviewDeliveryReviewDetailControllerMediatorWidget(
      giveReviewDeliveryReviewDetailModalDialogController: giveReviewDeliveryReviewDetailModalDialogController,
      giveReviewDeliveryReviewSubControllerList: _giveReviewDeliveryReviewSubControllerList,
      selectedRating: selectedRating,
      deliveryReview: deliveryReview
    );
  }
}

class _StatefulGiveReviewDeliveryReviewDetailControllerMediatorWidget extends StatefulWidget {
  final GiveReviewDeliveryReviewDetailModalDialogController giveReviewDeliveryReviewDetailModalDialogController;
  final List<List<dynamic>> giveReviewDeliveryReviewSubControllerList;
  final int selectedRating;
  final DeliveryReview deliveryReview;

  const _StatefulGiveReviewDeliveryReviewDetailControllerMediatorWidget({
    required this.giveReviewDeliveryReviewDetailModalDialogController,
    required this.giveReviewDeliveryReviewSubControllerList,
    required this.selectedRating,
    required this.deliveryReview
  });

  @override
  State<_StatefulGiveReviewDeliveryReviewDetailControllerMediatorWidget> createState() => _StatefulGiveReviewDeliveryReviewDetailControllerMediatorWidgetState();
}

class _StatefulGiveReviewDeliveryReviewDetailControllerMediatorWidgetState extends State<_StatefulGiveReviewDeliveryReviewDetailControllerMediatorWidget> {
  late void Function(GiveDeliveryReviewValue?) _giveDeliveryReviewValueCallback;
  GiveDeliveryReviewValue? _giveDeliveryReviewValue;
  late int _selectedRating;

  final OneRatingGiveDeliveryReviewContainerData _oneRatingGiveDeliveryReviewContainerData = OneRatingGiveDeliveryReviewContainerData();
  final TwoRatingGiveDeliveryReviewContainerData _twoRatingGiveDeliveryReviewContainerData = TwoRatingGiveDeliveryReviewContainerData();
  final ThreeRatingGiveDeliveryReviewContainerData _threeRatingGiveDeliveryReviewContainerData = ThreeRatingGiveDeliveryReviewContainerData();
  final FourRatingGiveDeliveryReviewContainerData _fourRatingGiveDeliveryReviewContainerData = FourRatingGiveDeliveryReviewContainerData();
  final FiveRatingGiveDeliveryReviewContainerData _fiveRatingGiveDeliveryReviewContainerData = FiveRatingGiveDeliveryReviewContainerData();

  final OneRatingGiveDeliveryReviewContainerSubmitCallback _oneRatingGiveDeliveryReviewContainerSubmitCallback = OneRatingGiveDeliveryReviewContainerSubmitCallback();
  final TwoRatingGiveDeliveryReviewContainerSubmitCallback _twoRatingGiveDeliveryReviewContainerSubmitCallback = TwoRatingGiveDeliveryReviewContainerSubmitCallback();
  final ThreeRatingGiveDeliveryReviewContainerSubmitCallback _threeRatingGiveDeliveryReviewContainerSubmitCallback = ThreeRatingGiveDeliveryReviewContainerSubmitCallback();
  final FourRatingGiveDeliveryReviewContainerSubmitCallback _fourRatingGiveDeliveryReviewContainerSubmitCallback = FourRatingGiveDeliveryReviewContainerSubmitCallback();
  final FiveRatingGiveDeliveryReviewContainerSubmitCallback _fiveRatingGiveDeliveryReviewContainerSubmitCallback = FiveRatingGiveDeliveryReviewContainerSubmitCallback();

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.selectedRating;
    _giveDeliveryReviewValueCallback = (giveDeliveryReviewValue) {
      _giveDeliveryReviewValue = giveDeliveryReviewValue;
      if (giveDeliveryReviewValue != null) {
        widget.giveReviewDeliveryReviewDetailModalDialogController.giveDeliveryReview();
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    String pageName = "give_review_delivery_review_detail";
    widget.giveReviewDeliveryReviewDetailModalDialogController.setGiveReviewDeliveryReviewDetailModalDialogDelegate(
      GiveReviewDeliveryReviewDetailModalDialogDelegate(
        onUnfocusAllWidget: () => FocusScope.of(context).unfocus(),
        onGetGiveDeliveryReviewValue: () => _giveDeliveryReviewValue!,
        onGiveReviewDeliveryBack: () => Get.back(),
        onShowGiveReviewDeliveryRequestProcessLoadingCallback: () async => DialogHelper.showLoadingDialog(context),
        onShowGiveReviewDeliveryRequestProcessFailedCallback: (e) async => DialogHelper.showFailedModalBottomDialogFromErrorProvider(
          context: context,
          errorProvider: Injector.locator<ErrorProvider>(),
          e: e
        ),
        onGiveReviewDeliveryRequestProcessSuccessCallback: () async => Get.back(result: true)
      )
    );
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 70,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: ClipRRect(
                        child: ProductModifiedCachedNetworkImage(
                          imageUrl: widget.deliveryReview.productImageUrl.toEmptyStringNonNull,
                        )
                      )
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.deliveryReview.productName.toStringNonNull, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: RatingIndicator(
                  rating: _selectedRating.toDouble(),
                  ratingSize: 40,
                  onTapRating: (rating) {
                    _giveDeliveryReviewValueCallback(null);
                    setState(() => _selectedRating = rating);
                  },
                ),
              ),
              const SizedBox(height: 15),
              Builder(
                builder: (context) {
                  if (_selectedRating == 1) {
                    return OneRatingGiveDeliveryReviewContainer(
                      oneRatingGiveDeliveryReviewContainerData: _oneRatingGiveDeliveryReviewContainerData,
                      oneRatingGiveDeliveryReviewContainerSubmitCallback: _oneRatingGiveDeliveryReviewContainerSubmitCallback,
                      ancestorPageName: pageName,
                      giveDeliveryReviewValueCallback: _giveDeliveryReviewValueCallback,
                      onAddControllerMember: () => widget.giveReviewDeliveryReviewSubControllerList[0][2]() as ControllerMember<OneRatingGiveDeliveryReviewContainerController>,
                    );
                  } else if (_selectedRating == 2) {
                    return TwoRatingGiveDeliveryReviewContainer(
                      twoRatingGiveDeliveryReviewContainerData: _twoRatingGiveDeliveryReviewContainerData,
                      twoRatingGiveDeliveryReviewContainerSubmitCallback: _twoRatingGiveDeliveryReviewContainerSubmitCallback,
                      ancestorPageName: pageName,
                      giveDeliveryReviewValueCallback: _giveDeliveryReviewValueCallback,
                      onAddControllerMember: () => widget.giveReviewDeliveryReviewSubControllerList[1][2]() as ControllerMember<TwoRatingGiveDeliveryReviewContainerController>,
                    );
                  } else if (_selectedRating == 3) {
                    return ThreeRatingGiveDeliveryReviewContainer(
                      threeRatingGiveDeliveryReviewContainerData: _threeRatingGiveDeliveryReviewContainerData,
                      threeRatingGiveDeliveryReviewContainerSubmitCallback: _threeRatingGiveDeliveryReviewContainerSubmitCallback,
                      ancestorPageName: pageName,
                      giveDeliveryReviewValueCallback: _giveDeliveryReviewValueCallback,
                      onAddControllerMember: () => widget.giveReviewDeliveryReviewSubControllerList[2][2]() as ControllerMember<ThreeRatingGiveDeliveryReviewContainerController>,
                    );
                  } else if (_selectedRating == 4) {
                    return FourRatingGiveDeliveryReviewContainer(
                      fourRatingGiveDeliveryReviewContainerData: _fourRatingGiveDeliveryReviewContainerData,
                      fourRatingGiveDeliveryReviewContainerSubmitCallback: _fourRatingGiveDeliveryReviewContainerSubmitCallback,
                      ancestorPageName: pageName,
                      giveDeliveryReviewValueCallback: _giveDeliveryReviewValueCallback,
                      onAddControllerMember: () => widget.giveReviewDeliveryReviewSubControllerList[3][2]() as ControllerMember<FourRatingGiveDeliveryReviewContainerController>,
                    );
                  } else if (_selectedRating == 5) {
                    return FiveRatingGiveDeliveryReviewContainer(
                      fiveRatingGiveDeliveryReviewContainerData: _fiveRatingGiveDeliveryReviewContainerData,
                      fiveRatingGiveDeliveryReviewContainerSubmitCallback: _fiveRatingGiveDeliveryReviewContainerSubmitCallback,
                      ancestorPageName: pageName,
                      giveDeliveryReviewValueCallback: _giveDeliveryReviewValueCallback,
                      onAddControllerMember: () => widget.giveReviewDeliveryReviewSubControllerList[4][2]() as ControllerMember<FiveRatingGiveDeliveryReviewContainerController>,
                    );
                  } else {
                    return Container();
                  }
                }
              ),
              const SizedBox(height: 10),
              SizedOutlineGradientButton(
                onPressed: () {
                  if (_selectedRating == 1) {
                    _oneRatingGiveDeliveryReviewContainerSubmitCallback.onSubmit();
                  } else if (_selectedRating == 2) {
                    _twoRatingGiveDeliveryReviewContainerSubmitCallback.onSubmit();
                  } else if (_selectedRating == 3) {
                    _threeRatingGiveDeliveryReviewContainerSubmitCallback.onSubmit();
                  } else if (_selectedRating == 4) {
                    _fourRatingGiveDeliveryReviewContainerSubmitCallback.onSubmit();
                  } else if (_selectedRating == 5) {
                    _fiveRatingGiveDeliveryReviewContainerSubmitCallback.onSubmit();
                  }
                },
                text: "Give Review".tr,
                outlineGradientButtonType: OutlineGradientButtonType.solid,
                outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                customPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
              ),
            ]
          )
        ),
      ),
    );
  }
}

class GiveReviewDeliveryReviewDetailModalDialogPageParameter {
  final int selectedRating;
  final DeliveryReview deliveryReview;

  const GiveReviewDeliveryReviewDetailModalDialogPageParameter({
    required this.selectedRating,
    required this.deliveryReview
  });
}