import '../../../../domain/entity/coupon/coupon.dart';
import '../../../../presentation/widget/coupon/coupon_item.dart';
import 'coupon_list_item_controller_state.dart';

class HorizontalCouponListItemControllerState extends CouponListItemControllerState {
  HorizontalCouponListItemControllerState({
    required Coupon coupon,
    OnSelectCoupon? onSelectCoupon,
    required bool isSelected
  }) : super(
    coupon: coupon,
    onSelectCoupon: onSelectCoupon,
    isSelected: isSelected
  );
}