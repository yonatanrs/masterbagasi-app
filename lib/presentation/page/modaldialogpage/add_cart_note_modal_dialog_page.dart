import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/misc/ext/validation_result_ext.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/modaldialogcontroller/add_cart_note_modal_dialog_controller.dart';
import '../../../misc/inputdecoration/default_input_decoration.dart';
import '../../../misc/validation/validator/validator.dart';
import '../../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../../widget/field.dart';
import '../../widget/modified_text_field.dart';
import '../../widget/rx_consumer.dart';
import 'modal_dialog_page.dart';

class AddCartNoteModalDialogPage extends ModalDialogPage<AddCartNoteModalDialogController> {
  final String? notes;

  AddCartNoteModalDialogController get addCartNoteModalDialogController => modalDialogController.controller;

  AddCartNoteModalDialogPage({
    Key? key,
    this.notes
  }) : super(key: key);

  @override
  AddCartNoteModalDialogController onCreateModalDialogController() {
    return AddCartNoteModalDialogController(controllerManager);
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulAddCartNoteControllerMediatorWidget(
      addCartNoteModalDialogController: addCartNoteModalDialogController,
      notes: notes
    );
  }
}

class _StatefulAddCartNoteControllerMediatorWidget extends StatefulWidget {
  final AddCartNoteModalDialogController addCartNoteModalDialogController;
  final String? notes;

  const _StatefulAddCartNoteControllerMediatorWidget({
    required this.addCartNoteModalDialogController,
    required this.notes
  });

  @override
  State<_StatefulAddCartNoteControllerMediatorWidget> createState() => _StatefulAddCartNoteControllerMediatorWidgetState();
}

class _StatefulAddCartNoteControllerMediatorWidgetState extends State<_StatefulAddCartNoteControllerMediatorWidget> {
  final TextEditingController _addCartTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addCartTextEditingController.text = widget.notes.toEmptyStringNonNull;
  }

  @override
  Widget build(BuildContext context) {
    widget.addCartNoteModalDialogController.setAddCartNoteModalDialogDelegate(
      AddCartNoteModalDialogDelegate(
        onUnfocusAllWidget: () => FocusScope.of(context).unfocus(),
        onGetNotesInput: () => _addCartTextEditingController.text,
        onAddCartNoteBack: () => Get.back(),
        onAddCartNoteRequestProcessSuccessCallback: (note) async => Get.back(result: note)
      )
    );
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IgnorePointer(
              child: ExcludeFocus(
                child: SizedOutlineGradientButton(
                  onPressed: () {},
                  text: widget.notes.isEmptyString ? "Add Cart Note".tr : "Change Cart Note".tr,
                  outlineGradientButtonType: OutlineGradientButtonType.outline,
                  outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                  customGradientButtonVariation: (outlineGradientButtonType) {
                    return CustomGradientButtonVariation(
                      outlineGradientButtonType: outlineGradientButtonType,
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold
                      )
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Note".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.addCartNoteModalDialogController.noteValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => ModifiedTextField(
                  isError: validationResult.isFailed,
                  controller: _addCartTextEditingController,
                  decoration: DefaultInputDecoration(hintText: "Enter Note".tr),
                  onChanged: (value) => validator?.validate(),
                  textInputAction: TextInputAction.next,
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            SizedOutlineGradientButton(
              onPressed: widget.addCartNoteModalDialogController.addCartNote,
              text: "Submit".tr,
              outlineGradientButtonType: OutlineGradientButtonType.solid,
              outlineGradientButtonVariation: OutlineGradientButtonVariation.variation2,
            ),
          ]
        )
      ),
    );
  }
}