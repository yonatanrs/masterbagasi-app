import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/misc/ext/validation_result_ext.dart';

import '../../../../controller/deliveryreviewcontroller/givedeliveryreviewcontainercontroller/four_rating_give_delivery_review_container_controller.dart';
import '../../../../domain/entity/delivery/givedeliveryreviewvalue/four_rating_give_delivery_review_value.dart';
import '../../../../domain/entity/delivery/givedeliveryreviewvalue/give_delivery_review_value.dart';
import '../../../../misc/constant.dart';
import '../../../../misc/getextended/get_extended.dart';
import '../../../../misc/give_delivery_review_container_submit_callback.dart';
import '../../../../misc/inputdecoration/default_input_decoration.dart';
import '../../../../misc/manager/controller_manager.dart';
import '../../../../misc/multi_language_string.dart';
import '../../../../misc/validation/validator/validator.dart';
import '../../../page/getx_page.dart';
import '../../field.dart';
import '../../modified_svg_picture.dart';
import '../../modified_text_field.dart';
import '../../rx_consumer.dart';
import '../give_delivery_review_check_list.dart';

class FourRatingGiveDeliveryReviewContainer extends DefaultGetxPage {
  late final ControllerMember<FourRatingGiveDeliveryReviewContainerController> _fourRatingGiveDeliveryReviewContainerController;
  final String ancestorPageName;
  final FourRatingGiveDeliveryReviewContainerData fourRatingGiveDeliveryReviewContainerData;
  final FourRatingGiveDeliveryReviewContainerSubmitCallback fourRatingGiveDeliveryReviewContainerSubmitCallback;
  final void Function(GiveDeliveryReviewValue?) giveDeliveryReviewValueCallback;
  final ControllerMember<FourRatingGiveDeliveryReviewContainerController> Function() onAddControllerMember;

  FourRatingGiveDeliveryReviewContainer({
    super.key,
    required this.ancestorPageName,
    required this.fourRatingGiveDeliveryReviewContainerData,
    required this.fourRatingGiveDeliveryReviewContainerSubmitCallback,
    required this.giveDeliveryReviewValueCallback,
    required this.onAddControllerMember
  }) {
    _fourRatingGiveDeliveryReviewContainerController = onAddControllerMember();
  }

  @override
  void onSetController() {
    _fourRatingGiveDeliveryReviewContainerController.controller = GetExtended.put<FourRatingGiveDeliveryReviewContainerController>(
      FourRatingGiveDeliveryReviewContainerController(
        controllerManager
      ),
      tag: ancestorPageName
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulFourRatingGiveDeliveryReviewContainerControllerMediatorWidget(
      fourRatingGiveDeliveryReviewContainerController: _fourRatingGiveDeliveryReviewContainerController.controller,
      fourRatingGiveDeliveryReviewContainerData: fourRatingGiveDeliveryReviewContainerData,
      fourRatingGiveDeliveryReviewContainerSubmitCallback: fourRatingGiveDeliveryReviewContainerSubmitCallback,
      giveDeliveryReviewValueCallback: giveDeliveryReviewValueCallback,
    );
  }
}

class _StatefulFourRatingGiveDeliveryReviewContainerControllerMediatorWidget extends StatefulWidget {
  final FourRatingGiveDeliveryReviewContainerController fourRatingGiveDeliveryReviewContainerController;
  final FourRatingGiveDeliveryReviewContainerData fourRatingGiveDeliveryReviewContainerData;
  final FourRatingGiveDeliveryReviewContainerSubmitCallback fourRatingGiveDeliveryReviewContainerSubmitCallback;
  final void Function(GiveDeliveryReviewValue?) giveDeliveryReviewValueCallback;

  const _StatefulFourRatingGiveDeliveryReviewContainerControllerMediatorWidget({
    super.key,
    required this.fourRatingGiveDeliveryReviewContainerController,
    required this.fourRatingGiveDeliveryReviewContainerData,
    required this.fourRatingGiveDeliveryReviewContainerSubmitCallback,
    required this.giveDeliveryReviewValueCallback
  });

  @override
  State<_StatefulFourRatingGiveDeliveryReviewContainerControllerMediatorWidget> createState() => _StatefulFourRatingGiveDeliveryReviewContainerControllerMediatorWidgetState();
}

class _StatefulFourRatingGiveDeliveryReviewContainerControllerMediatorWidgetState extends State<_StatefulFourRatingGiveDeliveryReviewContainerControllerMediatorWidget> {
  late TextEditingController _feedbackTextEditingController;

  @override
  void initState() {
    super.initState();
    _feedbackTextEditingController = widget.fourRatingGiveDeliveryReviewContainerData._feedbackTextEditingController;
    widget.fourRatingGiveDeliveryReviewContainerSubmitCallback._onSubmit = () => widget.fourRatingGiveDeliveryReviewContainerController.submit();
  }

  @override
  Widget build(BuildContext context) {
    widget.fourRatingGiveDeliveryReviewContainerController.setFourRatingGiveDeliveryReviewContainerDelegate(
      FourRatingGiveDeliveryReviewContainerDelegate(
        onUnfocusAllWidget: () => FocusScope.of(context).unfocus(),
        onGetSatisfiedFeedbackInput: () => _feedbackTextEditingController.text,
        onSubmit: () => widget.giveDeliveryReviewValueCallback(
          FourRatingGiveDeliveryReviewValue(
            satisfiedFeedback: _feedbackTextEditingController.text,
            hasServiceQuality: widget.fourRatingGiveDeliveryReviewContainerData._hasServiceQuality,
            hasPackagingQuality: widget.fourRatingGiveDeliveryReviewContainerData._hasPackagingQuality,
            hasPriceQuality: widget.fourRatingGiveDeliveryReviewContainerData._hasPriceQuality,
            hasItemQuality: widget.fourRatingGiveDeliveryReviewContainerData._hasItemQuality,
            hasDeliveryQuality: widget.fourRatingGiveDeliveryReviewContainerData._hasDeliveryQuality
          )
        )
      )
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MultiLanguageString({
            Constant.textEnUsLanguageKey: "What makes you satisfied?",
            Constant.textInIdLanguageKey: "Apa yang bikin kamu puas?"
          }).toEmptyStringNonNull,
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 10),
        RxConsumer<Validator>(
          rxValue: widget.fourRatingGiveDeliveryReviewContainerController.satisfiedFeedbackValidatorRx,
          onConsumeValue: (context, value) => Field(
            child: (context, validationResult, validator) => ModifiedTextField(
              isError: validationResult.isFailed,
              controller: _feedbackTextEditingController,
              decoration: DefaultInputDecoration(
                hintText: "Come on, tell me your satisfaction about the quality of goods and our service".tr
              ),
              onChanged: (value) => validator?.validate(),
              textInputAction: TextInputAction.next,
              maxLines: 4,
            ),
            validator: value,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ModifiedSvgPicture.asset(
                  Constant.vectorCameraOutline,
                  overrideDefaultColorWithSingleColor: false
                ),
                const SizedBox(width: 10),
                Text(
                  "Love to see a photo or video of the item".tr,
                  style: const TextStyle(fontWeight: FontWeight.bold)
                ),
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.grey.shade400
          ),
        ),
        const SizedBox(height: 10),
        GiveDeliveryReviewCheckList(
          hasServiceQuality: widget.fourRatingGiveDeliveryReviewContainerData._hasServiceQuality,
          onHasServiceQualityChanged: (value) {
            if (value != null) {
              setState(() {
                widget.fourRatingGiveDeliveryReviewContainerData._hasServiceQuality = value;
              });
            }
          },
          hasPackagingQuality: widget.fourRatingGiveDeliveryReviewContainerData._hasPackagingQuality,
          onHasPackagingQualityChanged: (value) {
            if (value != null) {
              setState(() {
                widget.fourRatingGiveDeliveryReviewContainerData._hasPackagingQuality = value;
              });
            }
          },
          hasPriceQuality: widget.fourRatingGiveDeliveryReviewContainerData._hasPriceQuality,
          onHasPriceQualityChanged: (value) {
            if (value != null) {
              setState(() {
                widget.fourRatingGiveDeliveryReviewContainerData._hasPriceQuality = value;
              });
            }
          },
          hasItemQuality: widget.fourRatingGiveDeliveryReviewContainerData._hasItemQuality,
          onHasItemQualityChanged: (value) {
            if (value != null) {
              setState(() {
                widget.fourRatingGiveDeliveryReviewContainerData._hasItemQuality = value;
              });
            }
          },
          hasDeliveryQuality: widget.fourRatingGiveDeliveryReviewContainerData._hasDeliveryQuality,
          onHasDeliveryQualityChanged: (value) {
            if (value != null) {
              setState(() {
                widget.fourRatingGiveDeliveryReviewContainerData._hasDeliveryQuality = value;
              });
            }
          },
        )
      ]
    );
  }
}

class FourRatingGiveDeliveryReviewContainerData {
  final TextEditingController _feedbackTextEditingController = TextEditingController();
  bool _hasServiceQuality = false;
  bool _hasPackagingQuality = false;
  bool _hasPriceQuality = false;
  bool _hasItemQuality = false;
  bool _hasDeliveryQuality = false;
}

class FourRatingGiveDeliveryReviewContainerSubmitCallback extends GiveDeliveryReviewContainerSubmitCallback {
  void Function()? _onSubmit;

  @override
  void Function() get onSubmit => _onSubmit ?? (throw UnimplementedError());
}