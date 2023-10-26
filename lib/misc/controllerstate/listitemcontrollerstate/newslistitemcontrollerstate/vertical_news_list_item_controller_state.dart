import 'news_list_item_controller_state.dart';

class VerticalNewsListItemControllerState extends NewsListItemControllerState {
  VerticalNewsListItemControllerState({
    required super.news,
    super.onTapNews
  });
}

class ShimmerVerticalNewsListItemControllerState extends VerticalNewsListItemControllerState {
  ShimmerVerticalNewsListItemControllerState({
    required super.news
  });
}