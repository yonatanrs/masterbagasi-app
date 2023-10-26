import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entity/location/location.dart';
import '../../misc/constant.dart';
import 'modified_svg_picture.dart';

class DeliveryToIndicator extends StatelessWidget {
  final Location location;

  const DeliveryToIndicator({
    super.key,
    required this.location
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Constant.colorDarkBlue,
      child: Row(
        children: [
          ModifiedSvgPicture.asset(Constant.vectorLocation, color: Colors.white),
          const SizedBox(width: 10),
          Text.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(text: "${"Shipped to".tr} ", style: const TextStyle(color: Colors.white)),
                TextSpan(text: location.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ]
            )
          )
        ],
      ),
    );
  }
}