import '../../../../domain/entity/coupon/coupon.dart';
import '../../../../presentation/widget/coupon/coupon_item.dart';
import 'coupon_list_item_controller_state.dart';

class VerticalCouponListItemControllerState extends CouponListItemControllerState {
  VerticalCouponListItemControllerState({
    required Coupon coupon,
    OnSelectCoupon? onSelectCoupon,
    required bool isSelected
  }) : super(
    coupon: coupon,
    onSelectCoupon: onSelectCoupon,
    isSelected: isSelected
  );
}

class ShimmerVerticalCouponListItemControllerState extends VerticalCouponListItemControllerState {
  ShimmerVerticalCouponListItemControllerState({
    required Coupon coupon,
    bool isSelected = false
  }) : super(
    coupon: coupon,
    onSelectCoupon: null,
    isSelected: false
  );
}