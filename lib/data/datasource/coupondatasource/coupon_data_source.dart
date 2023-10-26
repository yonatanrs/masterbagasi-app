import '../../../domain/entity/coupon/coupon.dart';
import '../../../domain/entity/coupon/coupon_detail_parameter.dart';
import '../../../domain/entity/coupon/coupon_list_parameter.dart';
import '../../../domain/entity/coupon/coupon_paging_parameter.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/processing/future_processing.dart';

abstract class CouponDataSource {
  FutureProcessing<PagingDataResult<Coupon>> couponPaging(CouponPagingParameter couponPagingParameter);
  FutureProcessing<List<Coupon>> couponList(CouponListParameter couponListParameter);
  FutureProcessing<Coupon> couponDetail(CouponDetailParameter couponDetailParameter);
}