import '../../domain/dummy/deliveryreviewdummy/delivery_review_dummy.dart';
import '../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/horizontal_delivery_review_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import 'shimmer_carousel_list_item_generator.dart';
import 'type/delivery_review_shimmer_carousel_list_item_generator_type.dart';

class DeliveryReviewShimmerCarouselListItemGenerator extends ShimmerCarouselListItemGenerator<DeliveryReviewShimmerCarouselListItemGeneratorType> {
  final DeliveryReviewDummy deliveryReviewDummy;

  @override
  DeliveryReviewShimmerCarouselListItemGeneratorType get shimmerCarouselListItemGeneratorType => DeliveryReviewShimmerCarouselListItemGeneratorType();

  DeliveryReviewShimmerCarouselListItemGenerator({
    required this.deliveryReviewDummy,
  });

  @override
  ListItemControllerState onGenerateListItemValue() {
    return HorizontalDeliveryReviewListItemControllerState(
      deliveryReview: deliveryReviewDummy.generateShimmerDummy()
    );
  }
}