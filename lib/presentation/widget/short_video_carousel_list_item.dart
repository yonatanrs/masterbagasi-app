import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/presentation/widget/video/short_video_item.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entity/video/shortvideo/short_video.dart';
import '../../misc/constant.dart';
import '../../misc/load_data_result.dart';

class ShortVideoCarouselListItem extends StatelessWidget {
  final LoadDataResult<List<ShortVideo>> shortVideoListLoadDataResult;

  const ShortVideoCarouselListItem({
    Key? key,
    required this.shortVideoListLoadDataResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
          height: 390,
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: Constant.paddingListItem),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Interesting Short Videos For You".tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Text(
                    "Look All".tr,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),
                  ),
                ]
              )
            ),
            if (shortVideoListLoadDataResult.isSuccess)
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
                    List<ShortVideo> shortVideoList = shortVideoListLoadDataResult.resultIfSuccess!;
                    while (i < shortVideoList.length) {
                      if (i > 0) {
                        itemMap.add(SizedBox(width: 3.w));
                      }
                      itemMap.add(
                        ShortVideoItem(shortVideo: shortVideoList[i])
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
        )
      ],
    );
  }
}