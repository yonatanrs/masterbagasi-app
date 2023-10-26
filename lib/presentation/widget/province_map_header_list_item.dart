import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../domain/entity/province/province_map.dart';
import '../../misc/constant.dart';
import 'button/custombutton/sized_outline_gradient_button.dart';
import 'modifiedcachednetworkimage/explore_nusantara_background_modified_cached_network_image.dart';
import 'modifiedcachednetworkimage/explore_nusantara_modified_cached_network_image.dart';

class ProvinceMapHeaderListItem extends StatelessWidget {
  final ProvinceMap provinceMap;

  const ProvinceMapHeaderListItem({super.key, required this.provinceMap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: ExploreNusantaraModifiedCachedNetworkImage(
                imageUrl: provinceMap.icon.toEmptyStringNonNull
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: SizedBox(
                height: 45,
                child: Stack(
                  children: [
                    IgnorePointer(
                      child: SizedOutlineGradientButton(
                        onPressed: () {},
                        text: provinceMap.name,
                        outlineGradientButtonType: OutlineGradientButtonType.solid,
                        outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                      ),
                    ),
                  ],
                )
              ),
            ),
          ]
        ),
      ]
    );
  }
}