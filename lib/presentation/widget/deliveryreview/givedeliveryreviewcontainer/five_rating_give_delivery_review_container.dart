import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/misc/ext/validation_result_ext.dart';

import '../../../../controller/deliveryreviewcontroller/givedeliveryreviewcontainercontroller/five_rating_give_delivery_review_container_controller.dart';
import '../../../../domain/entity/delivery/givedeliveryreviewvalue/five_rating_give_delivery_review_value.dart';
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

class FiveRatingGiveDeliveryReviewContainer extends DefaultGetxPage {
  late final ControllerMember<FiveRatingGiveDeliveryReviewContainerController> _fiveRatingGiveDeliveryReviewContainerController;
  final String ancestorPageName;
  final FiveRatingGiveDeliveryReviewContainerData fiveRatingGiveDeliveryReviewContainerData;
  final FiveRatingGiveDeliveryReviewContainerSubmitCallback fiveRatingGiveDeliveryReviewContainerSubmitCallback;
  final void Function(GiveDeliveryReviewValue?) giveDeliveryReviewValueCallback;
  final ControllerMember<FiveRatingGiveDeliveryReviewContainerController> Function() onAddControllerMember;

  FiveRatingGiveDeliveryReviewContainer({
    super.key,
    required this.ancestorPageName,
    required this.fiveRatingGiveDeliveryReviewContainerData,
    required this.fiveRatingGiveDeliveryReviewContainerSubmitCallback,
    required this.giveDeliveryReviewValueCallback,
    required this.onAddControllerMember
  }) {
    _fiveRatingGiveDeliveryReviewContainerController = onAddControllerMember();
  }

  @override
  void onSetController() {
    _fiveRatingGiveDeliveryReviewContainerController.controller = GetExtended.put<FiveRatingGiveDeliveryReviewContainerController>(
      FiveRatingGiveDeliveryReviewContainerController(
        controllerManager
      ),
      tag: ancestorPageName
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulFiveRatingGiveDeliveryReviewContainerControllerMediatorWidget(
      fiveRatingGiveDeliveryReviewContainerController: _fiveRatingGiveDeliveryReviewContainerController.controller,
      fiveRatingGiveDeliveryReviewContainerData: fiveRatingGiveDeliveryReviewContainerData,
      fiveRatingGiveDeliveryReviewContainerSubmitCallback: fiveRatingGiveDeliveryReviewContainerSubmitCallback,
      giveDeliveryReviewValueCallback: giveDeliveryReviewValueCallback,
    );
  }
}

class _StatefulFiveRatingGiveDeliveryReviewContainerControllerMediatorWidget extends StatefulWidget {
  final FiveRatingGiveDeliveryReviewContainerController fiveRatingGiveDeliveryReviewContainerController;
  final FiveRatingGiveDeliveryReviewContainerData fiveRatingGiveDeliveryReviewContainerData;
  final FiveRatingGiveDeliveryReviewContainerSubmitCallback fiveRatingGiveDeliveryReviewContainerSubmitCallback;
  final void Function(GiveDeliveryReviewValue?) giveDeliveryReviewValueCallback;

  const _StatefulFiveRatingGiveDeliveryReviewContainerControllerMediatorWidget({
    super.key,
    required this.fiveRatingGiveDeliveryReviewContainerController,
    required this.fiveRatingGiveDeliveryReviewContainerData,
    required this.fiveRatingGiveDeliveryReviewContainerSubmitCallback,
    required this.giveDeliveryReviewValueCallback
  });

  @override
  State<_StatefulFiveRatingGiveDeliveryReviewContainerControllerMediatorWidget> createState() => _StatefulFiveRatingGiveDeliveryReviewContainerControllerMediatorWidgetState();
}

class _StatefulFiveRatingGiveDeliveryReviewContainerControllerMediatorWidgetState extends State<_StatefulFiveRatingGiveDeliveryReviewContainerControllerMediatorWidget> {
  late TextEditingController _feedbackTextEditingController;

  @override
  void initState() {
    super.initState();
    _feedbackTextEditingController = widget.fiveRatingGiveDeliveryReviewContainerData._feedbackTextEditingController;
    widget.fiveRatingGiveDeliveryReviewContainerSubmitCallback._onSubmit = () => widget.fiveRatingGiveDeliveryReviewContainerController.submit();
  }

  @override
  Widget build(BuildContext context) {
    widget.fiveRatingGiveDeliveryReviewContainerController.setFiveRatingGiveDeliveryReviewContainerDelegate(
      FiveRatingGiveDeliveryReviewContainerDelegate(
        onUnfocusAllWidget: () => FocusScope.of(context).unfocus(),
        onGetVerySatisfiedFeedbackInput: () => _feedbackTextEditingController.text,
        onSubmit: () => widget.giveDeliveryReviewValueCallback(
          FiveRatingGiveDeliveryReviewValue(
            satisfiedFeedback: _feedbackTextEditingController.text,
            hasServiceQuality: widget.fiveRatingGiveDeliveryReviewContainerData._hasServiceQuality,
            hasPackagingQuality: widget.fiveRatingGiveDeliveryReviewContainerData._hasPackagingQuality,
            hasPriceQuality: widget.fiveRatingGiveDeliveryReviewContainerData._hasPriceQuality,
            hasItemQuality: widget.fiveRatingGiveDeliveryReviewContainerData._hasItemQuality,
            hasDeliveryQuality: widget.fiveRatingGiveDeliveryReviewContainerData._hasDeliveryQuality
          )
        )
      )
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MultiLanguageString({
            Constant.textEnUsLanguageKey: "What makes you very satisfied?",
            Constant.textInIdLanguageKey: "Apa yang bikin kamu sangat puas?"
          }).toEmptyStringNonNull,
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 10),
        RxConsumer<Validator>(
          rxValue: widget.fiveRatingGiveDeliveryReviewContainerController.verySatisfiedFeedbackValidatorRx,
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
          hasServiceQuality: widget.fiveRatingGiveDeliveryReviewContainerData._hasServiceQuality,
          onHasServiceQualityChanged: (value) {
            if (value != null) {
              setState(() {
                widget.fiveRatingGiveDeliveryReviewContainerData._hasServiceQuality = value;
              });
            }
          },
          hasPackagingQuality: widget.fiveRatingGiveDeliveryReviewContainerData._hasPackagingQuality,
          onHasPackagingQualityChanged: (value) {
            if (value != null) {
              setState(() {
                widget.fiveRatingGiveDeliveryReviewContainerData._hasPackagingQuality = value;
              });
            }
          },
          hasPriceQuality: widget.fiveRatingGiveDeliveryReviewContainerData._hasPriceQuality,
          onHasPriceQualityChanged: (value) {
            if (value != null) {
              setState(() {
                widget.fiveRatingGiveDeliveryReviewContainerData._hasPriceQuality = value;
              });
            }
          },
          hasItemQuality: widget.fiveRatingGiveDeliveryReviewContainerData._hasItemQuality,
          onHasItemQualityChanged: (value) {
            if (value != null) {
              setState(() {
                widget.fiveRatingGiveDeliveryReviewContainerData._hasItemQuality = value;
              });
            }
          },
          hasDeliveryQuality: widget.fiveRatingGiveDeliveryReviewContainerData._hasDeliveryQuality,
          onHasDeliveryQualityChanged: (value) {
            if (value != null) {
              setState(() {
                widget.fiveRatingGiveDeliveryReviewContainerData._hasDeliveryQuality = value;
              });
            }
          },
        )
      ]
    );
  }
}

class FiveRatingGiveDeliveryReviewContainerData {
  final TextEditingController _feedbackTextEditingController = TextEditingController();
  bool _hasServiceQuality = false;
  bool _hasPackagingQuality = false;
  bool _hasPriceQuality = false;
  bool _hasItemQuality = false;
  bool _hasDeliveryQuality = false;
}

class FiveRatingGiveDeliveryReviewContainerSubmitCallback extends GiveDeliveryReviewContainerSubmitCallback {
  void Function()? _onSubmit;

  @override
  void Function() get onSubmit => _onSubmit ?? (throw UnimplementedError());
}