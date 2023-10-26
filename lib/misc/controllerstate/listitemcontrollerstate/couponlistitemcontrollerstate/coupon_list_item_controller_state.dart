import '../../../../domain/entity/coupon/coupon.dart';
import '../../../../presentation/widget/coupon/coupon_item.dart';
import '../list_item_controller_state.dart';

abstract class CouponListItemControllerState extends ListItemControllerState {
  Coupon coupon;
  OnSelectCoupon? onSelectCoupon;
  bool isSelected;

  CouponListItemControllerState({
    required this.coupon,
    this.onSelectCoupon,
    required this.isSelected
  });
}