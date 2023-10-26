import 'package:flutter/material.dart';

class TapArea extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const TapArea({
    super.key,
    this.onTap,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: child,

        )
      )
    );
  }
}