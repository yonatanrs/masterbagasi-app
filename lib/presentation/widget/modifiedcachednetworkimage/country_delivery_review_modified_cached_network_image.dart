import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../misc/constant.dart';

class CountryDeliveryReviewModifiedCachedNetworkImage extends CachedNetworkImage {
  @override
  PlaceholderWidgetBuilder? get placeholder {
    return (context, url) => Container(
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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  CountryDeliveryReviewModifiedCachedNetworkImage({
    Key? key,
    required String imageUrl
  }) : super(
    key: key,
    imageUrl: imageUrl,
  );
}