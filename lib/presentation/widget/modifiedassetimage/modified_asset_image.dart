import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../misc/constant.dart';

typedef ImageAssetWidgetBuilder = Widget Function(
  BuildContext context,
  ImageProvider imageProvider,
);

typedef ImagePlaceholderWidgetBuilder = Widget Function(
  BuildContext context
);

typedef ImageLoadingErrorWidgetBuilder = Widget Function(
  BuildContext context,
  dynamic error,
);

class ModifiedAssetImage extends StatelessWidget {
  final String? imageAssetUrl;

  ImagePlaceholderWidgetBuilder get placeholder {
    return (context) => Container(color: Constant.colorPlaceholder);
  }

  ImageLoadingErrorWidgetBuilder get errorWidget {
    return (context, e) => Container(color: Constant.colorPlaceholder);
  }

  const ModifiedAssetImage({
    Key? key,
    required this.imageAssetUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageAssetUrl.toEmptyStringNonNull,
      fit: BoxFit.contain,
      frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
        bool targetLoaded = false;
        if (wasSynchronouslyLoaded || frame != null) {
          targetLoaded = true;
        }
        if (targetLoaded) {
          return Container(child: child);
        } else {
          return placeholder(context);
        }
      },
      errorBuilder: (context, e, stackTrace) => errorWidget(context, e)
    );
  }
}