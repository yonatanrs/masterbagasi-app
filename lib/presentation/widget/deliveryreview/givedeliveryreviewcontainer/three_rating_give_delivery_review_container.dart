import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/misc/ext/validation_result_ext.dart';

import '../../../../controller/deliveryreviewcontroller/givedeliveryreviewcontainercontroller/three_rating_give_delivery_review_container_controller.dart';
import '../../../../domain/entity/delivery/givedeliveryreviewvalue/give_delivery_review_value.dart';
import '../../../../domain/entity/delivery/givedeliveryreviewvalue/three_rating_give_delivery_review_value.dart';
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

class ThreeRatingGiveDeliveryReviewContainer extends DefaultGetxPage {
  late final ControllerMember<ThreeRatingGiveDeliveryReviewContainerController> _threeRatingGiveDeliveryReviewContainerController;
  final String ancestorPageName;
  final ThreeRatingGiveDeliveryReviewContainerData threeRatingGiveDeliveryReviewContainerData;
  final ThreeRatingGiveDeliveryReviewContainerSubmitCallback threeRatingGiveDeliveryReviewContainerSubmitCallback;
  final void Function(GiveDeliveryReviewValue?) giveDeliveryReviewValueCallback;
  final ControllerMember<ThreeRatingGiveDeliveryReviewContainerController> Function() onAddControllerMember;

  ThreeRatingGiveDeliveryReviewContainer({
    super.key,
    required this.ancestorPageName,
    required this.threeRatingGiveDeliveryReviewContainerData,
    required this.threeRatingGiveDeliveryReviewContainerSubmitCallback,
    required this.giveDeliveryReviewValueCallback,
    required this.onAddControllerMember
  }) {
    _threeRatingGiveDeliveryReviewContainerController = onAddControllerMember();
  }

  @override
  void onSetController() {
    _threeRatingGiveDeliveryReviewContainerController.controller = GetExtended.put<ThreeRatingGiveDeliveryReviewContainerController>(
      ThreeRatingGiveDeliveryReviewContainerController(
        controllerManager
      ),
      tag: ancestorPageName
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulThreeRatingGiveDeliveryReviewContainerControllerMediatorWidget(
      threeRatingGiveDeliveryReviewContainerController: _threeRatingGiveDeliveryReviewContainerController.controller,
      threeRatingGiveDeliveryReviewContainerData: threeRatingGiveDeliveryReviewContainerData,
      threeRatingGiveDeliveryReviewContainerSubmitCallback: threeRatingGiveDeliveryReviewContainerSubmitCallback,
      giveDeliveryReviewValueCallback: giveDeliveryReviewValueCallback,
    );
  }
}

class _StatefulThreeRatingGiveDeliveryReviewContainerControllerMediatorWidget extends StatefulWidget {
  final ThreeRatingGiveDeliveryReviewContainerController threeRatingGiveDeliveryReviewContainerController;
  final ThreeRatingGiveDeliveryReviewContainerData threeRatingGiveDeliveryReviewContainerData;
  final ThreeRatingGiveDeliveryReviewContainerSubmitCallback threeRatingGiveDeliveryReviewContainerSubmitCallback;
  final void Function(GiveDeliveryReviewValue?) giveDeliveryReviewValueCallback;

  const _StatefulThreeRatingGiveDeliveryReviewContainerControllerMediatorWidget({
    super.key,
    required this.threeRatingGiveDeliveryReviewContainerController,
    required this.threeRatingGiveDeliveryReviewContainerData,
    required this.threeRatingGiveDeliveryReviewContainerSubmitCallback,
    required this.giveDeliveryReviewValueCallback
  });

  @override
  State<_StatefulThreeRatingGiveDeliveryReviewContainerControllerMediatorWidget> createState() => _StatefulThreeRatingGiveDeliveryReviewContainerControllerMediatorWidgetState();
}

class _StatefulThreeRatingGiveDeliveryReviewContainerControllerMediatorWidgetState extends State<_StatefulThreeRatingGiveDeliveryReviewContainerControllerMediatorWidget> {
  late TextEditingController _feedbackTextEditingController;

  @override
  void initState() {
    super.initState();
    _feedbackTextEditingController = widget.threeRatingGiveDeliveryReviewContainerData._feedbackTextEditingController;
    widget.threeRatingGiveDeliveryReviewContainerSubmitCallback._onSubmit = () => widget.threeRatingGiveDeliveryReviewContainerController.submit();
  }

  @override
  Widget build(BuildContext context) {
    widget.threeRatingGiveDeliveryReviewContainerController.setThreeRatingGiveDeliveryReviewContainerDelegate(
      ThreeRatingGiveDeliveryReviewContainerDelegate(
        onUnfocusAllWidget: () => FocusScope.of(context).unfocus(),
        onGetUnsatisfiedFeedbackInput: () => _feedbackTextEditingController.text,
        onSubmit: () => widget.giveDeliveryReviewValueCallback(
          ThreeRatingGiveDeliveryReviewValue(
            unsatisfiedFeedback: _feedbackTextEditingController.text
          )
        )
      )
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MultiLanguageString({
            Constant.textEnUsLanguageKey: "What makes you unsatisfied?",
            Constant.textInIdLanguageKey: "Apa yang bikin kamu kurang puas?"
          }).toEmptyStringNonNull,
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 10),
        RxConsumer<Validator>(
          rxValue: widget.threeRatingGiveDeliveryReviewContainerController.unsatisfiedFeedbackValidatorRx,
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
      ]
    );
  }
}

class ThreeRatingGiveDeliveryReviewContainerData {
  final TextEditingController _feedbackTextEditingController = TextEditingController();
}

class ThreeRatingGiveDeliveryReviewContainerSubmitCallback extends GiveDeliveryReviewContainerSubmitCallback {
  void Function()? _onSubmit;

  @override
  void Function() get onSubmit => _onSubmit ?? (throw UnimplementedError());
}