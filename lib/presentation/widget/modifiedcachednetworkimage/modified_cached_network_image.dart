import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../misc/constant.dart';

class ModifiedCachedNetworkImage extends CachedNetworkImage {
  @override
  PlaceholderWidgetBuilder? get placeholder {
    return (context, url) => Container(color: Constant.colorPlaceholder);
  }

  @override
  LoadingErrorWidgetBuilder? get errorWidget {
    return (context, url, e) => Container(color: Constant.colorPlaceholder);
  }

  @override
  ImageWidgetBuilder? get imageBuilder {
    return (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  ModifiedCachedNetworkImage({
    Key? key,
    required String imageUrl
  }) : super(key: key, imageUrl: imageUrl);
}