import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HorizontalWidgetGroup extends StatelessWidget {
  final List<Widget> widgetList;
  final double? width;

  const HorizontalWidgetGroup({
    Key? key,
    required this.widgetList,
    this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Builder(
        builder: (context) {
          List<Widget> result = [];
          int i = 0;
          while (i < widgetList.length) {
            if (i > 0) {
              result.add(SizedBox(width: width ?? 2.w));
            }
            result.add(widgetList[i]);
            i++;
          }
          return Row(children: result);
        }
      ),
    );
  }
}