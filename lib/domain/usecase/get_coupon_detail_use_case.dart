import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/coupon/coupon.dart';
import '../entity/coupon/coupon_detail_parameter.dart';
import '../repository/coupon_repository.dart';

class GetCouponDetailUseCase {
  final CouponRepository couponRepository;

  const GetCouponDetailUseCase({
    required this.couponRepository
  });

  FutureProcessing<LoadDataResult<Coupon>> execute(CouponDetailParameter couponDetailParameter) {
    return couponRepository.couponDetail(couponDetailParameter);
  }
}