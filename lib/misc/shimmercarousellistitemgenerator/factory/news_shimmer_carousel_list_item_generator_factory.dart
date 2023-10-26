import '../../../domain/dummy/newsdummy/news_dummy.dart';
import '../news_shimmer_carousel_list_item_generator.dart';
import '../shimmer_carousel_list_item_generator.dart';
import '../type/news_shimmer_carousel_list_item_generator_type.dart';
import 'shimmer_carousel_list_item_generator_factory.dart';

class NewsShimmerCarouselListItemGeneratorFactory extends ShimmerCarouselListItemGeneratorFactory<NewsShimmerCarouselListItemGeneratorType> {
  final NewsDummy newsDummy;

  NewsShimmerCarouselListItemGeneratorFactory({
    required this.newsDummy
  });

  @override
  ShimmerCarouselListItemGenerator<NewsShimmerCarouselListItemGeneratorType> getShimmerCarouselListItemGeneratorType() {
    return NewsShimmerCarouselListItemGenerator(
      newsDummy: newsDummy
    );
  }
}