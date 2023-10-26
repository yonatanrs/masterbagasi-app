import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/number_ext.dart';

import '../../domain/entity/additionalitem/additional_item.dart';

class AdditionalItemSummaryWidget extends StatelessWidget {
  final List<AdditionalItem> additionalItemList;
  final int? no;

  const AdditionalItemSummaryWidget({
    super.key,
    required this.additionalItemList,
    this.no
  });

  @override
  Widget build(BuildContext context) {
    double totalEstimationPrice = 0.0;
    double totalEstimationWeight = 0.0;
    int i = 0;
    while (i < additionalItemList.length) {
      AdditionalItem additionalItem = additionalItemList[i];
      totalEstimationPrice += additionalItem.estimationPrice;
      totalEstimationWeight += additionalItem.estimationWeight;
      i++;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Text("Summary".tr),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Estimation Price of Additional Items".tr, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  const SizedBox(width: 10),
                  Text(totalEstimationPrice.toRupiah(), style: const TextStyle(fontSize: 11))
                ]
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Estimation Weight of Additional Items".tr, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  const SizedBox(width: 10),
                  Text("$totalEstimationWeight Kg", style: const TextStyle(fontSize: 11))
                ]
              )
            ]
          ),
        )
      ]
    );
  }
}