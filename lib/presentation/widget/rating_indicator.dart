import 'package:flutter/material.dart';

import '../../misc/constant.dart';
import 'tap_area.dart';

class RatingIndicator extends StatelessWidget {
  final double rating;
  final double maxRating;
  final double ratingSize;
  final double ratingSpacing;
  final void Function(int)? onTapRating;

  const RatingIndicator({
    super.key,
    required this.rating,
    this.maxRating = 5.0,
    this.ratingSize = 20,
    this.ratingSpacing = 10,
    this.onTapRating
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> starRowWidget = [];
    int maxRatingCount = 5;
    int roundedRating = maxRatingCount.toDouble() * rating ~/ maxRating;
    int i = 1;
    while (i <= maxRatingCount) {
      if (i > 1) {
        starRowWidget.add(
          SizedBox(width: ratingSpacing)
        );
      }
      late String imageStarAsset;
      if (i > roundedRating) {
        imageStarAsset = Constant.imageStarPlaceholder;
      } else {
        imageStarAsset = Constant.imageStar;
      }
      int currentTapRating = i;
      starRowWidget.add(
        TapArea(
          onTap: onTapRating != null ? () => onTapRating!(currentTapRating) : null,
          child: SizedBox(
            width: ratingSize,
            height: ratingSize,
            child: FittedBox(
              child: Image.asset(imageStarAsset),
            )
          ),
        ),
      );
      i++;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: starRowWidget,
    );
  }
}