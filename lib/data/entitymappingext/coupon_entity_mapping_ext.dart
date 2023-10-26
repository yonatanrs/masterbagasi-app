import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';

import '../../domain/entity/coupon/coupon.dart';
import '../../domain/entity/wishlist/wishlist.dart';
import '../../misc/date_util.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/response_wrapper.dart';

extension CouponEntityMappingExt on ResponseWrapper {
  List<Coupon> mapFromResponseToCouponList() {
    return response.map<Coupon>((couponResponse) => ResponseWrapper(couponResponse).mapFromResponseToCoupon()).toList();
  }

  PagingDataResult<Coupon> mapFromResponseToCouponPaging() {
    return ResponseWrapper(response).mapFromResponseToPagingDataResult(
      (dataResponse) => dataResponse.map<Coupon>(
        (couponResponse) => ResponseWrapper(couponResponse).mapFromResponseToCoupon()
      ).toList()
    );
  }
}

extension CouponDetailEntityMappingExt on ResponseWrapper {
  Coupon mapFromResponseToCoupon() {
    late dynamic effectiveResponse;
    if (response is List) {
      effectiveResponse = response[0];
    } else {
      effectiveResponse = response;
    }
    return Coupon(
      id: effectiveResponse["id"],
      userProfessionId: effectiveResponse["user_profession_id"],
      title: effectiveResponse["title"],
      code: effectiveResponse["code"],
      type: effectiveResponse["type"],
      activePeriodStart: ResponseWrapper(effectiveResponse["active_period_start"]).mapFromResponseToDateTime(dateFormat: DateUtil.standardDateFormat3)!,
      activePeriodEnd: ResponseWrapper(effectiveResponse["active_period_end"]).mapFromResponseToDateTime(dateFormat: DateUtil.standardDateFormat3)!,
      minPerUser: effectiveResponse["min_per_user"],
      imageMobile: effectiveResponse["image_mobile"],
      imageDesktop: effectiveResponse["image_desktop"],
      bannerDesktop: effectiveResponse["banner_desktop"],
      bannerMobile: effectiveResponse["banner_mobile"],
      notes: effectiveResponse["notes"],
    );
  }
}