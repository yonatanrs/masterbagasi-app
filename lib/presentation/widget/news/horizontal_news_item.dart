import 'news_item.dart';

class HorizontalNewsItem extends NewsItem {
  @override
  double? get itemWidth => 200.0;

  @override
  double? get itemHeight => 220.0;

  const HorizontalNewsItem({
    super.key,
    required super.news,
    super.onTapNews
  });
}