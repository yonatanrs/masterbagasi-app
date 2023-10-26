import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entity/video/defaultvideo/default_video.dart';
import '../../misc/constant.dart';
import '../../misc/load_data_result.dart';
import 'video/default_video_item.dart';

class DefaultVideoCarouselListItem extends StatelessWidget {
  final LoadDataResult<List<DefaultVideo>> defaultVideoListLoadDataResult;

  const DefaultVideoCarouselListItem({
    Key? key,
    required this.defaultVideoListLoadDataResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Video Trip".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Text(
                      "Look All".tr,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      ),
                    ),
                  ]
                )
              ),
              const SizedBox(height: 30),
              if (defaultVideoListLoadDataResult.isSuccess)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(
                    left: Constant.paddingListItem,
                    right: Constant.paddingListItem,
                  ),
                  child: Builder(
                    builder: (context) {
                      List<Widget> itemMap = [];
                      int i = 0;
                      List<DefaultVideo> defaultVideoList = defaultVideoListLoadDataResult.resultIfSuccess!;
                      while (i < defaultVideoList.length) {
                        if (i > 0) {
                          itemMap.add(SizedBox(width: 3.w));
                        }
                        itemMap.add(
                          DefaultVideoItem(defaultVideo: defaultVideoList[i])
                        );
                        i++;
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: itemMap,
                      );
                    },
                  )
                ),
            ]
          ),
        )
      ],
    );
  }
}