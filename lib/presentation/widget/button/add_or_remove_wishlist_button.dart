import 'package:flutter/material.dart';

import '../../../misc/constant.dart';
import '../modified_svg_picture.dart';

typedef OnAddWishlist = void Function();
typedef OnRemoveWishlist = void Function();

class AddOrRemoveWishlistButton extends StatelessWidget {
  final OnAddWishlist? onAddWishlist;
  final OnRemoveWishlist? onRemoveWishlist;
  final bool isTransparent;

  const AddOrRemoveWishlistButton({
    super.key,
    this.onAddWishlist,
    this.onRemoveWishlist,
    this.isTransparent = false
  });

  @override
  Widget build(BuildContext context) {
    void Function()? onTap;
    String? vectorString;
    if (onAddWishlist != null) {
      onTap = onAddWishlist;
      vectorString = Constant.vectorLove;
    } else if (onRemoveWishlist != null) {
      onTap = onRemoveWishlist;
      vectorString = Constant.vectorTrash;
    }
    return ClipOval(
      child: Material(
        color: isTransparent ? Colors.transparent : Constant.colorWishlistButton,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: vectorString != null ? ModifiedSvgPicture.asset(
                vectorString,
                color: Constant.colorWishlistIcon,
                width: 25,
                height: 25
              ) : Container()
            )
          ),
        ),
      ),
    );
  }
}