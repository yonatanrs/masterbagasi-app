import '../../../domain/dummy/coupondummy/coupon_dummy.dart';
import '../coupon_shimmer_carousel_list_item_generator.dart';
import '../shimmer_carousel_list_item_generator.dart';
import '../type/coupon_shimmer_carousel_list_item_generator_type.dart';
import 'shimmer_carousel_list_item_generator_factory.dart';

class CouponShimmerCarouselListItemGeneratorFactory extends ShimmerCarouselListItemGeneratorFactory<CouponShimmerCarouselListItemGeneratorType> {
  final CouponDummy couponDummy;

  CouponShimmerCarouselListItemGeneratorFactory({
    required this.couponDummy
  });

  @override
  ShimmerCarouselListItemGenerator<CouponShimmerCarouselListItemGeneratorType> getShimmerCarouselListItemGeneratorType() {
    return CouponShimmerCarouselListItemGenerator(
      couponDummy: couponDummy
    );
  }
}