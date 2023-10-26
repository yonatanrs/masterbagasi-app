import 'package:flutter/material.dart';

class IntroductionButtonCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 137;
    final double _yScaling = size.height / 102;
    path.lineTo(178 * _xScaling,20.5 * _yScaling);
    path.cubicTo(178 * _xScaling,9.17816 * _yScaling,168.822 * _xScaling,0 * _yScaling,157.5 * _xScaling,0 * _yScaling,);
    path.cubicTo(157.5 * _xScaling,0 * _yScaling,151.5 * _xScaling,0 * _yScaling,151.5 * _xScaling,0 * _yScaling,);
    path.cubicTo(143.492 * _xScaling,0 * _yScaling,137 * _xScaling,6.49187 * _yScaling,137 * _xScaling,14.5 * _yScaling,);
    path.cubicTo(137 * _xScaling,22.5081 * _yScaling,130.508 * _xScaling,29 * _yScaling,122.5 * _xScaling,29 * _yScaling,);
    path.cubicTo(122.5 * _xScaling,29 * _yScaling,22 * _xScaling,29 * _yScaling,22 * _xScaling,29 * _yScaling,);
    path.cubicTo(9.84974 * _xScaling,29 * _yScaling,0 * _xScaling,38.8497 * _yScaling,0 * _xScaling,51 * _yScaling,);
    path.cubicTo(0 * _xScaling,63.1503 * _yScaling,9.84973 * _xScaling,73 * _yScaling,22 * _xScaling,73 * _yScaling,);
    path.cubicTo(22 * _xScaling,73 * _yScaling,122.5 * _xScaling,73 * _yScaling,122.5 * _xScaling,73 * _yScaling,);
    path.cubicTo(130.508 * _xScaling,73 * _yScaling,137 * _xScaling,79.4919 * _yScaling,137 * _xScaling,87.5 * _yScaling,);
    path.cubicTo(137 * _xScaling,95.5081 * _yScaling,143.492 * _xScaling,102 * _yScaling,151.5 * _xScaling,102 * _yScaling,);
    path.cubicTo(151.5 * _xScaling,102 * _yScaling,157.5 * _xScaling,102 * _yScaling,157.5 * _xScaling,102 * _yScaling,);
    path.cubicTo(168.822 * _xScaling,102 * _yScaling,178 * _xScaling,92.8218 * _yScaling,178 * _xScaling,81.5 * _yScaling,);
    path.cubicTo(178 * _xScaling,81.5 * _yScaling,178 * _xScaling,20.5 * _yScaling,178 * _xScaling,20.5 * _yScaling,);
    path.cubicTo(178 * _xScaling,20.5 * _yScaling,178 * _xScaling,20.5 * _yScaling,178 * _xScaling,20.5 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}