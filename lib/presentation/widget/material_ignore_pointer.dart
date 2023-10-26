import 'package:flutter/material.dart';

class MaterialIgnorePointer extends StatefulWidget {
  // ignore: library_private_types_in_public_api
  static _MaterialIgnorePointerState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MaterialIgnorePointerState>();
  }

  final Widget child;

  const MaterialIgnorePointer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<MaterialIgnorePointer> createState() => _MaterialIgnorePointerState();
}

class _MaterialIgnorePointerState extends State<MaterialIgnorePointer> {
  bool _ignoring = false;
  set ignoring(bool value) {
    setState(() {
      _ignoring = value;
      _lastIgnoring = _ignoring;
    });
  }

  bool? _lastIgnoring;
  bool? get lastIgnoring => _lastIgnoring;

  void resetIgnoring() {
    setState(() {
      _ignoring = false;
      _lastIgnoring = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ignoring ? IgnorePointer(
      child: ExcludeFocus(
        child: widget.child
      )
    ) : widget.child;
  }
}