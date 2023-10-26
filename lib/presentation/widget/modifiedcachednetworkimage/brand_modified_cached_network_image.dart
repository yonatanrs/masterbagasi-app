import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../misc/constant.dart';

class BrandModifiedCachedNetworkImage extends CachedNetworkImage {
  final double dimension;

  @override
  PlaceholderWidgetBuilder? get placeholder {
    return (context, url) => Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Constant.imageProductPlaceholder),
          fit: BoxFit.cover
        )
      ),
    );
  }

  @override
  LoadingErrorWidgetBuilder? get errorWidget {
    return (context, url, e) => Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Constant.imageProductPlaceholder),
          fit: BoxFit.cover
        )
      ),
    );
  }

  @override
  ImageWidgetBuilder? get imageBuilder {
    return (context, imageProvider) => Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  BrandModifiedCachedNetworkImage({
    Key? key,
    required String imageUrl,
    required this.dimension
  }) : super(
    key: key,
    imageUrl: imageUrl,
    height: dimension,
    width: dimension,
  );

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: super.build(context)
    );
  }
}