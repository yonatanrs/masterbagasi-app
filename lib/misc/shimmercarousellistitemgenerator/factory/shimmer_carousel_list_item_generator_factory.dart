import '../shimmer_carousel_list_item_generator.dart';
import '../type/shimmer_carousel_list_item_generator_type.dart';

abstract class ShimmerCarouselListItemGeneratorFactory<G extends ShimmerCarouselListItemGeneratorType> {
  ShimmerCarouselListItemGenerator<G> getShimmerCarouselListItemGeneratorType();
}