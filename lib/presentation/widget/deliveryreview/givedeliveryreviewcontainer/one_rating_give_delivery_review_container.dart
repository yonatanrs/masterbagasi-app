import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/misc/ext/validation_result_ext.dart';

import '../../../../controller/deliveryreviewcontroller/givedeliveryreviewcontainercontroller/one_rating_give_delivery_review_container_controller.dart';
import '../../../../domain/entity/delivery/givedeliveryreviewvalue/give_delivery_review_value.dart';
import '../../../../domain/entity/delivery/givedeliveryreviewvalue/one_rating_give_delivery_review_value.dart';
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

class OneRatingGiveDeliveryReviewContainer extends DefaultGetxPage {
  late final ControllerMember<OneRatingGiveDeliveryReviewContainerController> _oneRatingGiveDeliveryReviewContainerController;
  final OneRatingGiveDeliveryReviewContainerData oneRatingGiveDeliveryReviewContainerData;
  final OneRatingGiveDeliveryReviewContainerSubmitCallback oneRatingGiveDeliveryReviewContainerSubmitCallback;
  final String ancestorPageName;
  final void Function(GiveDeliveryReviewValue?) giveDeliveryReviewValueCallback;
  final ControllerMember<OneRatingGiveDeliveryReviewContainerController> Function() onAddControllerMember;

  OneRatingGiveDeliveryReviewContainer({
    super.key,
    required this.oneRatingGiveDeliveryReviewContainerData,
    required this.oneRatingGiveDeliveryReviewContainerSubmitCallback,
    required this.ancestorPageName,
    required this.giveDeliveryReviewValueCallback,
    required this.onAddControllerMember
  }) {
    _oneRatingGiveDeliveryReviewContainerController = onAddControllerMember();
  }

  @override
  void onSetController() {
    _oneRatingGiveDeliveryReviewContainerController.controller = GetExtended.put<OneRatingGiveDeliveryReviewContainerController>(
      OneRatingGiveDeliveryReviewContainerController(
        controllerManager
      ),
      tag: ancestorPageName
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulOneRatingGiveDeliveryReviewContainerControllerMediatorWidget(
      oneRatingGiveDeliveryReviewContainerController: _oneRatingGiveDeliveryReviewContainerController.controller,
      oneRatingGiveDeliveryReviewContainerSubmitCallback: oneRatingGiveDeliveryReviewContainerSubmitCallback,
      oneRatingGiveDeliveryReviewContainerData: oneRatingGiveDeliveryReviewContainerData,
      giveDeliveryReviewValueCallback: giveDeliveryReviewValueCallback,
    );
  }
}

class _StatefulOneRatingGiveDeliveryReviewContainerControllerMediatorWidget extends StatefulWidget {
  final OneRatingGiveDeliveryReviewContainerController oneRatingGiveDeliveryReviewContainerController;
  final OneRatingGiveDeliveryReviewContainerData oneRatingGiveDeliveryReviewContainerData;
  final OneRatingGiveDeliveryReviewContainerSubmitCallback oneRatingGiveDeliveryReviewContainerSubmitCallback;
  final void Function(GiveDeliveryReviewValue?) giveDeliveryReviewValueCallback;

  const _StatefulOneRatingGiveDeliveryReviewContainerControllerMediatorWidget({
    super.key,
    required this.oneRatingGiveDeliveryReviewContainerController,
    required this.oneRatingGiveDeliveryReviewContainerData,
    required this.oneRatingGiveDeliveryReviewContainerSubmitCallback,
    required this.giveDeliveryReviewValueCallback
  });

  @override
  State<_StatefulOneRatingGiveDeliveryReviewContainerControllerMediatorWidget> createState() => _StatefulOneRatingGiveDeliveryReviewContainerControllerMediatorWidgetState();
}

class _StatefulOneRatingGiveDeliveryReviewContainerControllerMediatorWidgetState extends State<_StatefulOneRatingGiveDeliveryReviewContainerControllerMediatorWidget> {
  late TextEditingController _feedbackTextEditingController;

  @override
  void initState() {
    super.initState();
    _feedbackTextEditingController = widget.oneRatingGiveDeliveryReviewContainerData._feedbackTextEditingController;
    widget.oneRatingGiveDeliveryReviewContainerSubmitCallback._onSubmit = () => widget.oneRatingGiveDeliveryReviewContainerController.submit();
  }

  @override
  Widget build(BuildContext context) {
    widget.oneRatingGiveDeliveryReviewContainerController.setOneRatingGiveDeliveryReviewContainerDelegate(
      OneRatingGiveDeliveryReviewContainerDelegate(
        onUnfocusAllWidget: () => FocusScope.of(context).unfocus(),
        onGetDisappointedFeedbackInput: () => _feedbackTextEditingController.text,
        onSubmit: () => widget.giveDeliveryReviewValueCallback(
          OneRatingGiveDeliveryReviewValue(
            disappointedFeedback: _feedbackTextEditingController.text
          )
        )
      )
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MultiLanguageString({
            Constant.textEnUsLanguageKey: "What makes you disappointed?",
            Constant.textInIdLanguageKey: "Apa yang bikin kamu kecewa?"
          }).toEmptyStringNonNull,
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 10),
        RxConsumer<Validator>(
          rxValue: widget.oneRatingGiveDeliveryReviewContainerController.disappointedFeedbackValidatorRx,
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

class OneRatingGiveDeliveryReviewContainerData {
  final TextEditingController _feedbackTextEditingController = TextEditingController();
}

class OneRatingGiveDeliveryReviewContainerSubmitCallback extends GiveDeliveryReviewContainerSubmitCallback {
  void Function()? _onSubmit;

  @override
  void Function() get onSubmit => _onSubmit ?? (throw UnimplementedError());
}