import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../misc/constant.dart';
import 'modified_chip.dart';
import 'modified_shimmer.dart';

class ColorfulChipTabBar extends StatelessWidget {
  final List<ColorfulChipTabBarData> colorfulChipTabBarDataList;
  final ColorfulChipTabBarController colorfulChipTabBarController;
  final EdgeInsetsGeometry? padding;
  final bool isWrap;

  const ColorfulChipTabBar({
    Key? key,
    required this.colorfulChipTabBarDataList,
    required this.colorfulChipTabBarController,
    this.padding,
    this.isWrap = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry effectivePadding = padding ?? EdgeInsets.symmetric(horizontal: Constant.paddingListItem);
    if (isWrap) {
      return ValueListenableBuilder<int>(
        valueListenable: colorfulChipTabBarController,
        builder: (context, value, child) => Builder(
          builder: (context) {
            List<Widget> result = [];
            for (int i = 0; i < colorfulChipTabBarDataList.length; i++) {
              ColorfulChipTabBarData data = colorfulChipTabBarDataList[i];
              result.add(
                ModifiedChipButton(
                  label: Text(data.title.toStringNonNull),
                  backgroundColor: Constant.colorTrainingPreEmploymentChip(context),
                  isSelected: i == value,
                  onTap: () => colorfulChipTabBarController.value = i
                )
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
              child: Wrap(
                children: result,
                spacing: 10.0,
                runSpacing: 10.0
              ),
            );
          }
        )
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: effectivePadding,
      child: ValueListenableBuilder<int>(
        valueListenable: colorfulChipTabBarController,
        builder: (context, value, child) => Builder(
          builder: (context) {
            List<Widget> result = [];
            for (int i = 0; i < colorfulChipTabBarDataList.length; i++) {
              if (i > 0) {
                result.add(SizedBox(width: 2.w));
              }
              ColorfulChipTabBarData data = colorfulChipTabBarDataList[i];
              result.add(
                ModifiedChipButton(
                  label: Text(data.title.toStringNonNull),
                  backgroundColor: Constant.colorTrainingPreEmploymentChip(context),
                  isSelected: i == value,
                  onTap: () => colorfulChipTabBarController.value = i
                )
              );
            }
            return Row(children: result);
          }
        ),
      )
    );
  }
}

class ShimmerColorfulChipTabBar extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  const ShimmerColorfulChipTabBar({
    Key? key,
    this.padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry effectivePadding = padding ?? EdgeInsets.symmetric(horizontal: Constant.paddingListItem);
    return IgnorePointer(
      child: ModifiedShimmer.fromColors(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: effectivePadding,
          child: Builder(
            builder: (context) {
              List<Widget> result = [];
              for (int i = 0; i < 5; i++) {
                if (i > 0) {
                  result.add(SizedBox(width: 2.w));
                }
                result.add(
                  ModifiedChipButton(
                    label: Text("Dummy $i"),
                    backgroundColor: Constant.colorTrainingPreEmploymentChip(context),
                    isSelected: true,
                    onTap: () {}
                  )
                );
              }
              return Row(children: result);
            }
          )
        ),
      ),
    );
  }
}

class ColorfulChipTabBarController extends ValueNotifier<int> {
  ColorfulChipTabBarController(int value) : super(value);
}

class ColorfulChipTabBarData {
  String? title;
  Color color;
  dynamic data;

  ColorfulChipTabBarData({
    this.title,
    required this.color,
    this.data
  });
}