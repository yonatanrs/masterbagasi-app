import '../../../../domain/entity/news/news.dart';
import '../../../../presentation/widget/news/news_item.dart';
import '../list_item_controller_state.dart';

abstract class NewsListItemControllerState extends ListItemControllerState {
  News news;
  OnTapNews? onTapNews;

  NewsListItemControllerState({
    required this.news,
    this.onTapNews,
  });
}