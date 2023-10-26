import 'package:flutter/material.dart';

import '../../../../domain/entity/product/productdiscussion/product_discussion_dialog.dart';
import '../../../../misc/date_util.dart';
import '../../modified_vertical_divider.dart';
import '../../profile_picture_cache_network_image.dart';

abstract class ProductDiscussionDialogItem extends StatelessWidget {
  final ProductDiscussionDialog productDiscussionDialog;
  final bool isMainProductDiscussion;

  const ProductDiscussionDialogItem({
    Key? key,
    required this.productDiscussionDialog,
    required this.isMainProductDiscussion
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isMainProductDiscussion ? null : const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.grey)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Builder(
        builder: (_) {
          if (isMainProductDiscussion) {
            return _defaultMainProductDiscussionDialogContent(context);
          } else {
            return _defaultProductDiscussionDialogContent(context);
          }
        }
      )
    );
  }

  Widget _defaultProductDiscussionDialogContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePictureCacheNetworkImage(
          profileImageUrl: "",
          dimension: 50.0,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    productDiscussionDialog.user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(width: 10),
                  const ModifiedVerticalDivider(
                    lineWidth: 1,
                    lineHeight: 10,
                    lineColor: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Text(DateUtil.standardDateFormat9.format(productDiscussionDialog.discussionDate))
                ]
              ),
              const SizedBox(height: 10.0),
              Text(
                productDiscussionDialog.discussion,
              )
            ]
          ),
        )
      ],
    );
  }

  Widget _defaultMainProductDiscussionDialogContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfilePictureCacheNetworkImage(
              profileImageUrl: "",
              dimension: 50.0,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                productDiscussionDialog.user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                )
              ),
            )
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          productDiscussionDialog.discussion,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        )
      ],
    );
  }
}