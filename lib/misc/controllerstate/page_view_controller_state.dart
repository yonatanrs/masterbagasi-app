import 'package:preload_page_view/preload_page_view.dart';
import '../pageviewchildrenbuilder/page_view_children_builder.dart';

class PageViewControllerState {
  PreloadPageController preloadPageController;
  PreloadPageViewChildrenBuilder pageViewChildrenBuilder;

  PageViewControllerState({
    required this.preloadPageController,
    required this.pageViewChildrenBuilder
  });
}