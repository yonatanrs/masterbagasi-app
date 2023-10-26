import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../domain/entity/address/address.dart';
import '../../../misc/constant.dart';

class ShippingAddressIndicator extends StatelessWidget {
  final Address shippingAddress;

  const ShippingAddressIndicator({
    super.key,
    required this.shippingAddress
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: Constant.paddingListItem),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(shippingAddress.label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text((shippingAddress.addressUser != null ? shippingAddress.addressUser!.name : null).toEmptyStringNonNull, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(shippingAddress.phoneNumber, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(shippingAddress.address),
        ],
      )
    );
  }
}