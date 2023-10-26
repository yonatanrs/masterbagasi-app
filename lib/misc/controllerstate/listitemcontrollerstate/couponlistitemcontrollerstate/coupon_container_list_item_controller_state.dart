import '../../../../domain/entity/coupon/coupon.dart';
import '../../../../presentation/widget/coupon/coupon_item.dart';
import '../list_item_controller_state.dart';

class CouponContainerListItemControllerState extends ListItemControllerState {
  List<Coupon> coupon;
  Coupon? Function()? onGetSelectedCoupon;
  String? Function()? onGetLastSelectedCouponId;
  OnSelectCoupon? onSelectCoupon;
  void Function() onUpdateState;
  CouponContainerStorageListItemControllerState couponContainerStorageListItemControllerState;

  CouponContainerListItemControllerState({
    required this.coupon,
    this.onGetSelectedCoupon,
    this.onGetLastSelectedCouponId,
    this.onSelectCoupon,
    required this.onUpdateState,
    required this.couponContainerStorageListItemControllerState
  });
}

abstract class CouponContainerStorageListItemControllerState {}