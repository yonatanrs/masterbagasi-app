import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../domain/entity/product/productdiscussion/product_discussion.dart';
import '../../../domain/entity/product/productdiscussion/product_discussion_dialog.dart';
import '../../../misc/date_util.dart';
import '../modifiedcachednetworkimage/product_modified_cached_network_image.dart';

abstract class ProductDiscussionItem extends StatelessWidget {
  final ProductDiscussion productDiscussion;
  final bool isExpanded;
  final void Function(ProductDiscussion)? onProductDiscussionTap;

  @protected
  double? get itemWidth;

  const ProductDiscussionItem({
    super.key,
    required this.productDiscussion,
    required this.isExpanded,
    this.onProductDiscussionTap
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: itemWidth,
      child: Material(
        child: InkWell(
          onTap: onProductDiscussionTap != null ? () => onProductDiscussionTap!(productDiscussion) : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 70,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: ClipRRect(
                      child: ProductModifiedCachedNetworkImage(
                        imageUrl: productDiscussion.imageUrl.toEmptyStringNonNull,
                      )
                    )
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      late List<Widget> columnWidget;
                      if (!isExpanded) {
                        ProductDiscussionDialog productDiscussionDialog = productDiscussion.productDiscussionDialog;
                        String answerAndDate = "${productDiscussion.discussionCount} ${"Answer".tr} ${DateUtil.standardDateFormat9.format(productDiscussionDialog.discussionDate)}";
                        columnWidget = <Widget>[
                          Text(
                            productDiscussion.title,
                            style: TextStyle(
                              color: Colors.grey.shade400
                            )
                          ),
                          const SizedBox(height: 5),
                          Text(
                            productDiscussion.productDiscussionDialog.discussion,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          const SizedBox(height: 5),
                          Text(
                            answerAndDate,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade400
                            )
                          ),
                        ];
                      } else {
                        columnWidget = <Widget>[
                          Text(
                            productDiscussion.productDiscussionDialog.discussion,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ];
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: columnWidget
                      );
                    }
                  ),
                )
              ],
            )
          )
        )
      ),
    );
  }
}