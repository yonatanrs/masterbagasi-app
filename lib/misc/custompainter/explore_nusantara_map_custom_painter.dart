import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import '../../domain/entity/province/province_map.dart';
import '../constant.dart';

class ExploreNusantaraMapCustomPainter extends CustomPainter {
  final BuildContext context;
  final ProvinceMap? selectedProvinceMap;
  final List<ProvinceMap> provinceMapList;
  final void Function(ProvinceMap)? onSelectProvinceMap;

  ExploreNusantaraMapCustomPainter({
    required this.context,
    this.selectedProvinceMap,
    required this.provinceMapList,
    this.onSelectProvinceMap
  });

  @override
  void paint(Canvas canvas, Size size) {
    //Create and use TouchyCanvas to draw
    TouchyCanvas touchyCanvas = TouchyCanvas(context, canvas);

    // Scale each path to match canvas size
    var xScale = size.width / 1000;
    var yScale = size.height / 357;
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(xScale, yScale);

    for (var provinceMap in provinceMapList) {
      Paint paint = Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 8.0;
      if (provinceMap.id == selectedProvinceMap?.id) {
        paint.color = Theme.of(context).colorScheme.primary;
      } else {
        paint.color = Constant.colorGrey6;
      }
      Path path = parseSvgPath(provinceMap.provinceMapMetadata.svg);
      path.transform(matrix4.storage);
      touchyCanvas.drawPath(
        path.transform(matrix4.storage),
        paint,
        onTapDown: (details) {
          if (onSelectProvinceMap != null) {
            onSelectProvinceMap!(provinceMap);
          }
        },
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
