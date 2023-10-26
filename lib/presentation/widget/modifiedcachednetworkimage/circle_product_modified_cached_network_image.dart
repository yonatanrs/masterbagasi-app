import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../misc/constant.dart';

typedef _OnBindShapeParentWidgetWithChild = SingleChildRenderObjectWidget Function(
  BuildContext context,
  Widget widget
);

class CircleProductModifiedCachedNetworkImage extends CachedNetworkImage {
  final String? productImageUrl;
  final double dimension;
  // ignore: library_private_types_in_public_api
  final _OnBindShapeParentWidgetWithChild? onBindShapeParentWidgetWithChild;
  final bool isClipped;

  Widget get _placeholder => Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(Constant.imageProductPlaceholder),
        fit: BoxFit.cover,
      ),
      shape: BoxShape.circle
    ),
  );

  @override
  PlaceholderWidgetBuilder? get placeholder {
    return (context, url) => _placeholder;
  }

  @override
  LoadingErrorWidgetBuilder? get errorWidget {
    return (widget, url, e) => _placeholder;
  }

  CircleProductModifiedCachedNetworkImage({
    Key? key,
    this.onBindShapeParentWidgetWithChild,
    required this.productImageUrl,
    required this.dimension,
    this.isClipped = true
  }) : super(key: key,
        height: dimension,
        width: dimension,
        imageUrl: productImageUrl.toEmptyStringNonNull,
        fit: BoxFit.cover,
      );

  @override
  Widget build(BuildContext context) {
    return isClipped ? onBindShapeParentWidgetWithChild != null ? onBindShapeParentWidgetWithChild!(
      context, super.build(context)
    ) : ClipOval(
      child: super.build(context)
    ) : super.build(context);
  }
}