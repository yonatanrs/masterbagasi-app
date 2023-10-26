import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/number_ext.dart';

import '../../domain/entity/additionalitem/additional_item.dart';

class AdditionalItemWidget extends StatelessWidget {
  final AdditionalItem additionalItem;
  final int? no;

  const AdditionalItemWidget({
    super.key,
    required this.additionalItem,
    this.no
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey.shade200,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Text("${no != null ? "$no. " : ""}${additionalItem.name}"),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Row(
            children: [
              const SizedBox(width: 22),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Estimation Price".tr, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    const SizedBox(height: 3),
                    Text(additionalItem.estimationPrice.toRupiah(), style: const TextStyle(fontSize: 11))
                  ]
                )
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Estimation Weight".tr, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    const SizedBox(height: 3),
                    Text("${additionalItem.estimationWeight} Kg", style: const TextStyle(fontSize: 11))
                  ]
                )
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Quantity".tr, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    const SizedBox(height: 3),
                    Text("${additionalItem.quantity}", style: const TextStyle(fontSize: 11))
                  ]
                )
              )
            ]
          ),
        )
      ]
    );
  }
}