import 'package:flutter/material.dart';

import '../../misc/constant.dart';
import 'modified_svg_picture.dart';

class AppBarIconArea extends StatelessWidget {
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Widget child;

  const AppBarIconArea({
    Key? key,
    this.onTap,
    this.width,
    this.height,
    required this.child,
  }) : super(
    key: key
  );

  @override
  Widget build(BuildContext context) {
    Widget effectiveChild = child;
    if (onTap == null) {
      if (effectiveChild is ModifiedSvgPicture) {
        effectiveChild = effectiveChild.copy(color: Constant.colorGrey);
      } else if (effectiveChild is Icon) {
        effectiveChild = Icon(
          effectiveChild.icon,
          color: Constant.colorGrey,
          size: effectiveChild.size,
          key: effectiveChild.key,
          semanticLabel: effectiveChild.semanticLabel,
          shadows: effectiveChild.shadows,
          textDirection: effectiveChild.textDirection,
        );
      }
    }
    return Material(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: width ?? 50,
          height: height ?? 50,
          child: Stack(
            children: [
              Center(child: effectiveChild)
            ]
          )
        ),
      )
    );
  }
}