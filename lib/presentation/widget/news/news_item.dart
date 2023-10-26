import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entity/news/news.dart';
import '../../../misc/constant.dart';
import '../modifiedcachednetworkimage/news_modified_cached_network_image.dart';

typedef OnTapNews = void Function(News);

abstract class NewsItem extends StatelessWidget {
  final News news;
  final OnTapNews? onTapNews;

  @protected
  double? get itemWidth;

  @protected
  double? get itemHeight;

  const NewsItem({
    super.key,
    required this.news,
    required this.onTapNews
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(8.0);
    return SizedBox(
      width: itemWidth,
      height: itemHeight,
      child: Padding(
        // Use padding widget for avoiding shadow elevation overlap.
        padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
        child: Material(
          borderRadius: borderRadius,
          elevation: 3,
          child: InkWell(
            onTap: onTapNews != null ? () => onTapNews!(news) : null,
            borderRadius: borderRadius,
            child: Stack(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: Constant.aspectRatioValueNewsThumbnail.toDouble(),
                        child: ClipRRect(
                          child: NewsModifiedCachedNetworkImage(
                            imageUrl: news.thumbnail,
                          )
                        )
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news.title,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ]
                        ),
                      ),
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Read More".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary
                      ),
                    ),
                  ),
                ),
              ],
            )
          )
        ),
      )
    );
  }
}