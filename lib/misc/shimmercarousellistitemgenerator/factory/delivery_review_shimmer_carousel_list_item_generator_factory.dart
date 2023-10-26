import '../../../domain/dummy/deliveryreviewdummy/delivery_review_dummy.dart';
import '../delivery_review_shimmer_carousel_list_item_generator.dart';
import '../shimmer_carousel_list_item_generator.dart';
import '../type/delivery_review_shimmer_carousel_list_item_generator_type.dart';
import 'shimmer_carousel_list_item_generator_factory.dart';

class DeliveryReviewShimmerCarouselListItemGeneratorFactory extends ShimmerCarouselListItemGeneratorFactory<DeliveryReviewShimmerCarouselListItemGeneratorType> {
  final DeliveryReviewDummy deliveryReviewDummy;

  DeliveryReviewShimmerCarouselListItemGeneratorFactory({
    required this.deliveryReviewDummy
  });

  @override
  ShimmerCarouselListItemGenerator<DeliveryReviewShimmerCarouselListItemGeneratorType> getShimmerCarouselListItemGeneratorType() {
    return DeliveryReviewShimmerCarouselListItemGenerator(
      deliveryReviewDummy: deliveryReviewDummy
    );
  }
}