import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/coupon/coupon.dart';
import '../entity/coupon/coupon_list_parameter.dart';
import '../repository/coupon_repository.dart';

class GetCouponListUseCase {
  final CouponRepository couponRepository;

  const GetCouponListUseCase({
    required this.couponRepository
  });

  FutureProcessing<LoadDataResult<List<Coupon>>> execute(CouponListParameter couponListParameter) {
    return couponRepository.couponList(couponListParameter);
  }
}