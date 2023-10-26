import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HorizontalChipGroup extends StatelessWidget {
  final List<Chip> chipList;

  const HorizontalChipGroup({
    Key? key,
    required this.chipList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Builder(
        builder: (context) {
          List<Widget> result = [];
          int i = 0;
          while (i < chipList.length) {
            if (i > 0) {
              result.add(SizedBox(width: 2.w));
            }
            result.add(chipList[i]);
            i++;
          }
          return Row(children: result);
        }
      ),
    );
  }
}