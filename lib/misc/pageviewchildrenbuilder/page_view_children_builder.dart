import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

typedef PreloadPageViewChildrenBuilderDelegate = List<Widget> Function(BuildContext context, PreloadPageController preloadPageController);

abstract class PreloadPageViewChildrenBuilder {
  PreloadPageViewChildrenBuilderDelegate buildPageViewChildrenDelegate();
}