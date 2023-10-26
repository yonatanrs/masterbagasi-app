import 'package:masterbagasi/misc/shimmercarousellistitemgenerator/shimmer_carousel_list_item_generator.dart';

import '../../domain/dummy/coupondummy/coupon_dummy.dart';
import '../controllerstate/listitemcontrollerstate/couponlistitemcontrollerstate/horizontal_coupon_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import 'type/coupon_shimmer_carousel_list_item_generator_type.dart';

class CouponShimmerCarouselListItemGenerator extends ShimmerCarouselListItemGenerator<CouponShimmerCarouselListItemGeneratorType> {
  final CouponDummy couponDummy;

  @override
  CouponShimmerCarouselListItemGeneratorType get shimmerCarouselListItemGeneratorType => CouponShimmerCarouselListItemGeneratorType();

  CouponShimmerCarouselListItemGenerator({
    required this.couponDummy,
  });

  @override
  ListItemControllerState onGenerateListItemValue() {
    return HorizontalCouponListItemControllerState(
      coupon: couponDummy.generateShimmerDummy(),
      isSelected: false
    );
  }
}