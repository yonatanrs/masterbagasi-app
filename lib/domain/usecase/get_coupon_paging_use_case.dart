import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/coupon/coupon.dart';
import '../entity/coupon/coupon_paging_parameter.dart';
import '../repository/coupon_repository.dart';

class GetCouponPagingUseCase {
  final CouponRepository couponRepository;

  const GetCouponPagingUseCase({
    required this.couponRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<Coupon>>> execute(CouponPagingParameter couponPagingParameter) {
    return couponRepository.couponPaging(couponPagingParameter);
  }
}