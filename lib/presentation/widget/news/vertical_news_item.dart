import 'package:flutter/material.dart';

import '../modified_shimmer.dart';
import 'news_item.dart';

class VerticalNewsItem extends NewsItem {
  @override
  double? get itemWidth => null;

  @override
  double? get itemHeight => 220.0;

  const VerticalNewsItem({
    super.key,
    required super.news,
    super.onTapNews
  });
}

class ShimmerVerticalNewsItem extends VerticalNewsItem {
  const ShimmerVerticalNewsItem({
    super.key,
    required super.news
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ModifiedShimmer.fromColors(
        child: super.build(context)
      ),
    );
  }
}