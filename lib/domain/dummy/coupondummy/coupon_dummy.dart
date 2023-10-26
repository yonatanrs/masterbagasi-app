import '../../entity/coupon/coupon.dart';

class CouponDummy {
  CouponDummy();

  Coupon generateShimmerDummy() {
    return Coupon(
      id: "",
      userProfessionId: "",
      title: "",
      code: "",
      type: "",
      activePeriodStart: DateTime.now(),
      activePeriodEnd: DateTime.now(),
      minPerUser: 0,
      imageMobile: "",
      imageDesktop: "",
      bannerDesktop: "",
      bannerMobile: "",
      notes: "",
    );
  }

  Coupon generateDefaultDummy() {
    return Coupon(
      id: "",
      userProfessionId: "",
      title: "",
      code: "",
      type: "",
      activePeriodStart: DateTime.now(),
      activePeriodEnd: DateTime.now(),
      minPerUser: 0,
      imageMobile: "",
      imageDesktop: "",
      bannerDesktop: "",
      bannerMobile: "",
      notes: "",
    );
  }
}