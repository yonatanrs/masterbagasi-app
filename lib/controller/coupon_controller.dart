import '../domain/entity/coupon/coupon.dart';
import '../domain/entity/coupon/coupon_list_parameter.dart';
import '../domain/entity/coupon/coupon_paging_parameter.dart';
import '../domain/usecase/get_coupon_list_use_case.dart';
import '../domain/usecase/get_coupon_paging_use_case.dart';
import '../misc/load_data_result.dart';
import '../misc/paging/pagingresult/paging_data_result.dart';
import 'base_getx_controller.dart';

class CouponController extends BaseGetxController {
  final GetCouponPagingUseCase getCouponPagingUseCase;
  final GetCouponListUseCase getCouponListUseCase;

  CouponController(
    super.controllerManager,
    this.getCouponPagingUseCase,
    this.getCouponListUseCase
  );

  Future<LoadDataResult<PagingDataResult<Coupon>>> getCouponPaging(CouponPagingParameter couponPagingParameter) {
    return getCouponPagingUseCase.execute(couponPagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("coupon-paging").value
    );
  }

  Future<LoadDataResult<List<Coupon>>> getCouponList(CouponListParameter couponListParameter) {
    return getCouponListUseCase.execute(couponListParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("coupon-list").value
    );
  }
}