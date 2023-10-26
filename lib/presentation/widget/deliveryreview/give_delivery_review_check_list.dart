import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../border_check_list_item.dart';

class GiveDeliveryReviewCheckList extends StatelessWidget {
  final bool hasServiceQuality;
  final void Function(bool?)? onHasServiceQualityChanged;
  final bool hasPackagingQuality;
  final void Function(bool?)? onHasPackagingQualityChanged;
  final bool hasPriceQuality;
  final void Function(bool?)? onHasPriceQualityChanged;
  final bool hasItemQuality;
  final void Function(bool?)? onHasItemQualityChanged;
  final bool hasDeliveryQuality;
  final void Function(bool?)? onHasDeliveryQualityChanged;

  const GiveDeliveryReviewCheckList({
    super.key,
    required this.hasServiceQuality,
    this.onHasServiceQualityChanged,
    required this.hasPackagingQuality,
    this.onHasPackagingQualityChanged,
    required this.hasPriceQuality,
    this.onHasPriceQualityChanged,
    required this.hasItemQuality,
    this.onHasItemQualityChanged,
    required this.hasDeliveryQuality,
    this.onHasDeliveryQualityChanged
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 12);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: BorderCheckListItem(
                value: hasServiceQuality,
                showCheck: true,
                title: Text("Service Quality".tr, style: textStyle, overflow: TextOverflow.ellipsis),
                onChanged: onHasServiceQualityChanged,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: BorderCheckListItem(
                value: hasItemQuality,
                showCheck: true,
                title: Text("Item Quality".tr, style: textStyle, overflow: TextOverflow.ellipsis),
                onChanged: onHasItemQualityChanged
              ),
            ),
          ]
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: BorderCheckListItem(
                value: hasPackagingQuality,
                showCheck: true,
                title: Text("Packaging Quality".tr, style: textStyle, overflow: TextOverflow.ellipsis),
                onChanged: onHasPackagingQualityChanged,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: BorderCheckListItem(
                value: hasDeliveryQuality,
                showCheck: true,
                title: Text("Delivery Quality".tr, style: textStyle, overflow: TextOverflow.ellipsis),
                onChanged: onHasDeliveryQualityChanged,
              ),
            ),
          ]
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: BorderCheckListItem(
                value: hasPriceQuality,
                showCheck: true,
                title: Text("Price Quality".tr, style: textStyle, overflow: TextOverflow.ellipsis),
                onChanged: onHasPriceQualityChanged,
              ),
            ),
            const SizedBox(width: 10),
            const Spacer()
          ]
        )
      ],
    );
  }
}