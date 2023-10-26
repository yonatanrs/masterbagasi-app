import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../../../domain/entity/address/country.dart';
import '../../../misc/constant.dart';
import '../../../misc/dialog_helper.dart';
import '../../page/modaldialogpage/select_countries_modal_dialog_page.dart';
import '../button/custombutton/sized_outline_gradient_button.dart';
import '../modified_svg_picture.dart';

class CountryDeliveryReviewSelectCountryItem extends StatelessWidget {
  final Country? selectedCountry;
  final void Function(Country)? onSelectCountry;

  const CountryDeliveryReviewSelectCountryItem({
    super.key,
    required this.selectedCountry,
    this.onSelectCountry
  });

  @override
  Widget build(BuildContext context) {
    TextStyle getDefaultTextStyle() {
      return TextStyle(
        color: Constant.colorGrey7,
        fontSize: 12,
        fontWeight: FontWeight.w500
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedOutlineGradientButton(
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
          child: Row(
            children: [
              Text(
                "Select More Country Reviews".tr,
                style: getDefaultTextStyle()
              ),
              const SizedBox(width: 10),
              Transform.rotate(
                angle: math.pi / 2,
                child: ModifiedSvgPicture.asset(
                  Constant.vectorArrow,
                  height: 10,
                  color: Constant.colorGrey7,
                )
              ),
            ]
          ),
          text: "",
          outlineGradientButtonType: OutlineGradientButtonType.outline,
          outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
          customGradientButtonVariation: (outlineGradientButtonType) {
            return CustomGradientButtonVariation(
              outlineGradientButtonType: outlineGradientButtonType,
              gradient: Constant.buttonGradient3,
              backgroundColor: Colors.white,
              textStyle: getDefaultTextStyle()
            );
          },
          customPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        ),
      ],
    );
  }
}