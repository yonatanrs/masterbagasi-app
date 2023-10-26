import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entity/address/country.dart';
import '../../misc/constant.dart';
import '../../misc/dialog_helper.dart';
import '../page/modaldialogpage/select_countries_modal_dialog_page.dart';
import 'button/custombutton/sized_outline_gradient_button.dart';

class SelectCountryIndicator extends StatelessWidget {
  final Country? selectedCountry;
  final void Function(Country)? onSelectCountry;

  const SelectCountryIndicator({
    super.key,
    required this.selectedCountry,
    this.onSelectCountry
  });

  @override
  Widget build(BuildContext context) {
    TextStyle getDefaultTextStyle() {
      return TextStyle(
        color: Constant.colorDarkBlue,
        fontWeight: FontWeight.bold
      );
    }
    return SizedBox(
      width: double.infinity,
      child: SizedOutlineGradientButton(
        onPressed: () async {
          dynamic result = await DialogHelper.showModalDialogPage<Country, Country>(
            context: context,
            modalDialogPageBuilder: (context, parameter) => SelectCountriesModalDialogPage(
              selectedCountry: parameter,
            ),
            parameter: selectedCountry,
          );
          if (result is Country) {
            if (onSelectCountry != null) {
              onSelectCountry!(result);
            }
          }
        },
        child: selectedCountry == null ? Text(
          "(${"Not Selected".tr})",
          style: getDefaultTextStyle()
        ) : Row(
          children: [
            SizedBox(
              width: 16,
              height: 12,
              child: Flag.fromString(selectedCountry!.code),
            ),
            const SizedBox(width: 10),
            Text(
              selectedCountry!.name,
              style: getDefaultTextStyle()
            )
          ]
        ),
        text: "",
        outlineGradientButtonType: OutlineGradientButtonType.outline,
        outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
        customGradientButtonVariation: (outlineGradientButtonType) {
          return CustomGradientButtonVariation(
            outlineGradientButtonType: outlineGradientButtonType,
            gradient: Constant.buttonGradient2,
            backgroundColor: Colors.white,
            textStyle: getDefaultTextStyle()
          );
        },
        customPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
      ),
    );
  }
}