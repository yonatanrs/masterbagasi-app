import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import 'profile_image_placeholder.dart';

typedef _OnBindShapeParentWidgetWithChild = SingleChildRenderObjectWidget Function(
  BuildContext context,
  Widget widget
);

class ProfilePictureCacheNetworkImage extends CachedNetworkImage {
  final String? profileImageUrl;
  final double dimension;
  // ignore: library_private_types_in_public_api
  final _OnBindShapeParentWidgetWithChild? onBindShapeParentWidgetWithChild;
  final Color? _backgroundColor;
  Color get _defaultBackgroundColor => Colors.grey.shade200;

  @override
  PlaceholderWidgetBuilder? get placeholder {
    return (context, url) => ProfileImagePlaceholder(diameter: dimension, backgroundColor: _backgroundColor ?? _defaultBackgroundColor);
  }

  @override
  LoadingErrorWidgetBuilder? get errorWidget {
    return (widget, url, e) => ProfileImagePlaceholder(diameter: dimension, backgroundColor: _backgroundColor ?? _defaultBackgroundColor);
  }

  ProfilePictureCacheNetworkImage({
    Key? key,
    this.onBindShapeParentWidgetWithChild,
    required this.profileImageUrl,
    required this.dimension,
    Color? backgroundColor
  }) : _backgroundColor = backgroundColor,
      super(key: key,
        height: dimension,
        width: dimension,
        imageUrl: profileImageUrl.toEmptyStringNonNull,
        fit: BoxFit.cover,
      );

  @override
  Widget build(BuildContext context) {
    return onBindShapeParentWidgetWithChild != null ? onBindShapeParentWidgetWithChild!(
      context, super.build(context)
    ) : ClipOval(
      child: super.build(context)
    );
  }
}