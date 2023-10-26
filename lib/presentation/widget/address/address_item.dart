import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../domain/entity/address/address.dart';
import '../../../misc/constant.dart';
import '../../../misc/dialog_helper.dart';
import '../../../misc/page_restoration_helper.dart';
import '../../page/modify_address_page.dart';
import '../button/custombutton/sized_outline_gradient_button.dart';
import '../modified_svg_picture.dart';
import '../tap_area.dart';

typedef OnSelectAddress = void Function(Address);
typedef OnRemoveAddress = void Function(Address);

abstract class AddressItem extends StatelessWidget {
  @protected
  double? get itemWidth;

  @protected
  bool get hasSingleLines => false;

  final Address address;
  final OnSelectAddress? onSelectAddress;
  final OnRemoveAddress? onRemoveAddress;
  final bool canBeModified;

  const AddressItem({
    super.key,
    required this.address,
    this.onSelectAddress,
    this.onRemoveAddress,
    this.canBeModified = true
  });

  @override
  Widget build(BuildContext context) {
    TextOverflow? textOverflow = hasSingleLines ? TextOverflow.ellipsis : null;
    int? maxLines = hasSingleLines ? 1 : null;
    return SizedBox(
      width: itemWidth,
      child: Material(
        color: address.isPrimary == 0 ? Colors.transparent : Constant.colorLightOrange,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: address.isPrimary == 0 ? Colors.grey : Constant.colorMain,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: onSelectAddress != null ? () => onSelectAddress!(address) : null,
          borderRadius: BorderRadius.circular(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    overflow: textOverflow,
                  ),
                  maxLines: maxLines,
                ),
                const SizedBox(height: 15),
                Text(
                  address.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: textOverflow,
                  ),
                  maxLines: maxLines
                ),
                const SizedBox(height: 4),
                Text(
                  address.phoneNumber,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: textOverflow
                  ),
                  maxLines: maxLines
                ),
                const SizedBox(height: 15),
                Text(
                  address.address,
                  style: TextStyle(
                    overflow: textOverflow
                  ),
                  maxLines: maxLines
                ),
                if (canBeModified)
                  ...[
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 34,
                      child: SizedOutlineGradientButton(
                        onPressed: () => PageRestorationHelper.toModifyAddressPage(
                          context,
                          ModifyAddressPageParameter(
                            modifyAddressPageParameterValue: address.toModifyAddressPageParameterValue()
                          )
                        ),
                        text: "Change Address".tr,
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                "Change Address".tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 50,
                                height: double.infinity,
                                child: TapArea(
                                  onTap: () {
                                    DialogHelper.showAddressOtherMenu(
                                      context: context,
                                      address: address,
                                      onChangeAddress: (address) {
                                        PageRestorationHelper.toModifyAddressPage(
                                          context,
                                          ModifyAddressPageParameter(
                                            modifyAddressPageParameterValue: address.toModifyAddressPageParameterValue()
                                          )
                                        );
                                      },
                                      onRemoveAddress: (address) {
                                        if (onRemoveAddress != null) {
                                          onRemoveAddress!(address);
                                        }
                                      }
                                    );
                                  },
                                  child: Center(
                                    child: ModifiedSvgPicture.asset(
                                      Constant.vectorTripleLines,
                                      color: Colors.black
                                    ),
                                  )
                                )
                              ),
                            )
                          ]
                        ),
                        outlineGradientButtonType: OutlineGradientButtonType.outline,
                        outlineGradientButtonVariation: OutlineGradientButtonVariation.variation3,
                        customPadding: const EdgeInsets.all(0),
                        customGradientButtonVariation: (outlineGradientButtonType) {
                          return CustomGradientButtonVariation(
                            outlineGradientButtonType: outlineGradientButtonType,
                            showDefaultGradientButtonVariationIfNotConfigured: true,
                            backgroundColor: Colors.white
                          );
                        },
                      ),
                    ),
                  ]
                ],
            )
          ),
        ),
      ),
    );
  }
}