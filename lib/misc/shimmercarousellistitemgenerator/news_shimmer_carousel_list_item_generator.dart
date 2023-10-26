import '../../domain/dummy/newsdummy/news_dummy.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/newslistitemcontrollerstate/horizontal_news_list_item_controller_state.dart';
import 'shimmer_carousel_list_item_generator.dart';
import 'type/news_shimmer_carousel_list_item_generator_type.dart';

class NewsShimmerCarouselListItemGenerator extends ShimmerCarouselListItemGenerator<NewsShimmerCarouselListItemGeneratorType> {
  final NewsDummy newsDummy;

  @override
  NewsShimmerCarouselListItemGeneratorType get shimmerCarouselListItemGeneratorType => NewsShimmerCarouselListItemGeneratorType();

  NewsShimmerCarouselListItemGenerator({
    required this.newsDummy,
  });

  @override
  ListItemControllerState onGenerateListItemValue() {
    return HorizontalNewsListItemControllerState(
      news: newsDummy.generateShimmerDummy()
    );
  }
}